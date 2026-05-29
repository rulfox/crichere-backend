import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/auction_event.dart';
import '../../domain/entities/auction_state_snapshot.dart';

part 'auction_state_provider.g.dart';

/// A single entry in the live bid feed.
class BidEntry {
  final String franchiseId;
  final String franchiseName;
  final int amount;
  const BidEntry({
    required this.franchiseId,
    required this.franchiseName,
    required this.amount,
  });
}

/// Reduces the SSE [AuctionEvent] stream into a flat, render-friendly state.
@riverpod
class AuctionStateNotifier extends _$AuctionStateNotifier {
  Timer? _timer;

  @override
  AuctionState build() {
    ref.onDispose(() => _timer?.cancel());
    return const AuctionState();
  }

  void handleEvent(AuctionEvent event) {
    state = switch (event) {
      AuctionSnapshotEvent(:final snapshot) => _applySnapshot(snapshot),
      PlayerUpEvent(:final leaguePlayerId, :final playerName, :final basePrice) => () {
          _timer?.cancel();
          return state.copyWith(
            currentPlayerId: leaguePlayerId,
            currentPlayerName: playerName,
            currentBid: basePrice ?? 0,
            leadingFranchise: null,
            leadingFranchiseId: null,
            bidHistory: const [],
            status: 'BIDDING',
            isTimerRunning: false,
          );
        }(),
      BidPlacedEvent(:final franchiseId, :final bidAmount) => () {
          final name = state.franchiseNames[franchiseId] ?? 'Franchise';
          var nextSeconds = state.remainingSeconds;
          // Anti-snipe: a bid inside the anti-snipe window tops the timer back up.
          if (state.isTimerRunning &&
              state.antiSnipeSeconds > 0 &&
              state.remainingSeconds <= state.antiSnipeSeconds &&
              state.remainingSeconds > 0) {
            nextSeconds = state.antiSnipeSeconds;
          }
          return state.copyWith(
            currentBid: bidAmount,
            leadingFranchise: name,
            leadingFranchiseId: franchiseId,
            remainingSeconds: nextSeconds,
            bidHistory: [
              BidEntry(franchiseId: franchiseId, franchiseName: name, amount: bidAmount),
              ...state.bidHistory.take(9),
            ],
          );
        }(),
      BidUndoneEvent(:final newHighestBid, :final newHighestBidder) => state.copyWith(
          currentBid: newHighestBid ?? 0,
          leadingFranchiseId: newHighestBidder,
          leadingFranchise:
              newHighestBidder == null ? null : state.franchiseNames[newHighestBidder],
        ),
      PlayerSoldEvent() => _settle('SOLD'),
      PlayerUnsoldEvent() => _settle('UNSOLD'),
      PlayerWithdrawnEvent() => _settle('WITHDRAWN'),
      PlayerForceAssignedEvent() => _settle('FORCE_ASSIGNED'),
      PlayerPreAssignedEvent() => _settle('PRE_ASSIGNED'),
      SoldRevertedEvent() => state.copyWith(status: 'BIDDING'),
      TimerStartedEvent(:final durationSeconds, :final antiSnipeSeconds) => () {
          _startTimer();
          return state.copyWith(
            isTimerRunning: true,
            remainingSeconds: durationSeconds ?? state.remainingSeconds,
            antiSnipeSeconds: antiSnipeSeconds ?? state.antiSnipeSeconds,
          );
        }(),
      TimerStoppedEvent() => () {
          _timer?.cancel();
          return state.copyWith(isTimerRunning: false);
        }(),
      TimerResetEvent(:final newDurationSeconds) => state.copyWith(
          remainingSeconds: newDurationSeconds ?? state.remainingSeconds,
        ),
      TimerExtendedEvent(:final newDurationSeconds, :final addedSeconds) => state.copyWith(
          remainingSeconds:
              newDurationSeconds ?? (state.remainingSeconds + (addedSeconds ?? 0)),
        ),
      RoundStartedEvent(:final roundNumber) =>
        state.copyWith(status: 'ROUND_${roundNumber ?? ''}'),
      RoundCompletedEvent() => state.copyWith(status: 'ROUND_COMPLETED'),
      AuctionStartedEvent() => state.copyWith(status: 'STARTED'),
      AuctionPausedEvent() => () {
          _timer?.cancel();
          return state.copyWith(status: 'PAUSED', isTimerRunning: false);
        }(),
      AuctionResumedEvent() => state.copyWith(status: 'LIVE'),
      AuctionCompletedEvent() => () {
          _timer?.cancel();
          return state.copyWith(status: 'COMPLETED', isTimerRunning: false);
        }(),
      AuctionCancelledEvent() => () {
          _timer?.cancel();
          return state.copyWith(status: 'CANCELLED', isTimerRunning: false);
        }(),
      UnknownAuctionEvent() => state,
    };
  }

  AuctionState _settle(String status) {
    _timer?.cancel();
    return state.copyWith(
      status: status,
      bidHistory: const [],
      isTimerRunning: false,
    );
  }

  AuctionState _applySnapshot(AuctionStateSnapshot s) {
    _timer?.cancel();
    final names = <String, String>{
      for (final p in s.franchisePurseStates)
        if (p.franchiseName != null) p.franchiseId: p.franchiseName!,
    };
    final timer = s.timer;
    final running = timer?.isRunning ?? false;
    if (running) _startTimer();
    return state.copyWith(
      franchises: s.franchisePurseStates,
      franchiseNames: names,
      currentPlayerId: s.currentPlayer?.leaguePlayerId,
      currentPlayerName: s.currentPlayer?.playerName,
      currentBid: s.currentHighestBid ?? s.currentPlayer?.basePrice ?? 0,
      leadingFranchiseId: s.currentHighestBidderId,
      leadingFranchise: s.currentHighestBidderId == null
          ? null
          : names[s.currentHighestBidderId],
      status: s.auctionStatus.name.toUpperCase(),
      remainingSeconds: timer?.remainingSeconds ?? 0,
      antiSnipeSeconds: timer?.antiSnipeSeconds ?? 0,
      isTimerRunning: running,
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds > 0) {
        state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
      } else {
        _timer?.cancel();
        state = state.copyWith(isTimerRunning: false);
      }
    });
  }
}

class AuctionState {
  final String? currentPlayerId;
  final String? currentPlayerName;
  final int currentBid;
  final int bidIncrement;
  final String? leadingFranchise;
  final String? leadingFranchiseId;
  final List<BidEntry> bidHistory;
  final String status;
  final int remainingSeconds;
  final bool isTimerRunning;
  final int antiSnipeSeconds;
  final List<FranchisePurseState> franchises;
  final Map<String, String> franchiseNames;

  const AuctionState({
    this.currentPlayerId,
    this.currentPlayerName,
    this.currentBid = 0,
    this.bidIncrement = 500,
    this.leadingFranchise,
    this.leadingFranchiseId,
    this.bidHistory = const [],
    this.status = 'WAITING',
    this.remainingSeconds = 0,
    this.isTimerRunning = false,
    this.antiSnipeSeconds = 0,
    this.franchises = const [],
    this.franchiseNames = const {},
  });

  AuctionState copyWith({
    String? currentPlayerId,
    String? currentPlayerName,
    int? currentBid,
    int? bidIncrement,
    String? leadingFranchise,
    String? leadingFranchiseId,
    List<BidEntry>? bidHistory,
    String? status,
    int? remainingSeconds,
    bool? isTimerRunning,
    int? antiSnipeSeconds,
    List<FranchisePurseState>? franchises,
    Map<String, String>? franchiseNames,
  }) {
    return AuctionState(
      currentPlayerId: currentPlayerId ?? this.currentPlayerId,
      currentPlayerName: currentPlayerName ?? this.currentPlayerName,
      currentBid: currentBid ?? this.currentBid,
      bidIncrement: bidIncrement ?? this.bidIncrement,
      leadingFranchise: leadingFranchise ?? this.leadingFranchise,
      leadingFranchiseId: leadingFranchiseId ?? this.leadingFranchiseId,
      bidHistory: bidHistory ?? this.bidHistory,
      status: status ?? this.status,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isTimerRunning: isTimerRunning ?? this.isTimerRunning,
      antiSnipeSeconds: antiSnipeSeconds ?? this.antiSnipeSeconds,
      franchises: franchises ?? this.franchises,
      franchiseNames: franchiseNames ?? this.franchiseNames,
    );
  }
}
