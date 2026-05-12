import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/auction_event.dart';

part 'auction_state_provider.g.dart';

@riverpod
class AuctionStateNotifier extends _$AuctionStateNotifier {
  Timer? _timer;

  @override
  AuctionState build() {
    ref.onDispose(() => _timer?.cancel());
    return const AuctionState();
  }

  void handleEvent(AuctionEvent event) {
    state = event.map(
      playerUp: (e) {
        _timer?.cancel();
        return state.copyWith(
          currentPlayerId: e.playerId,
          currentPlayerName: e.playerName,
          currentBid: e.basePrice,
          bidIncrement: e.bidIncrement ?? 500, // Use from event if available
          leadingFranchise: null,
          status: 'BIDDING',
          remainingSeconds: 60,
          isTimerRunning: false,
        );
      },
      bidPlaced: (e) {
        int nextSeconds = state.remainingSeconds;
        // SC-004: Anti-snipe: If bid lands within <= 10s, reset to 10s
        if (state.isTimerRunning && state.remainingSeconds <= 10 && state.remainingSeconds > 0) {
          nextSeconds = 10;
        }
        return state.copyWith(
          currentBid: e.amount,
          leadingFranchise: e.franchiseName,
          bidHistory: [e, ...state.bidHistory.take(4)],
          remainingSeconds: nextSeconds,
        );
      },
      playerSold: (e) {
        _timer?.cancel();
        return state.copyWith(
          status: 'SOLD',
          bidHistory: [],
          isTimerRunning: false,
        );
      },
      playerUnsold: (e) {
        _timer?.cancel();
        return state.copyWith(
          status: 'UNSOLD',
          bidHistory: [],
          isTimerRunning: false,
        );
      },
      playerForceAssigned: (e) {
        _timer?.cancel();
        return state.copyWith(
          status: 'FORCE_ASSIGNED',
          bidHistory: [],
          isTimerRunning: false,
        );
      },
      timerStarted: (e) {
        _startTimer();
        return state.copyWith(
          isTimerRunning: true,
          remainingSeconds: e.remainingSeconds,
        );
      },
      timerPaused: (e) {
        _timer?.cancel();
        return state.copyWith(
          isTimerRunning: false,
          remainingSeconds: e.remainingSeconds,
        );
      },
      timerReset: (e) {
        return state.copyWith(
          remainingSeconds: e.remainingSeconds,
        );
      },
      bidUndone: (_) => state, 
      soldReverted: (_) => state,
      roundStarted: (e) => state.copyWith(status: 'ROUND_${e.roundNumber}'),
      auctionStarted: (_) => state.copyWith(status: 'STARTED'),
      auctionCompleted: (_) => state.copyWith(status: 'COMPLETED'),
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
  final int bidIncrement; // Added
  final String? leadingFranchise;
  final List<BidPlaced> bidHistory;
  final String status;
  final int remainingSeconds;
  final bool isTimerRunning;

  const AuctionState({
    this.currentPlayerId,
    this.currentPlayerName,
    this.currentBid = 0,
    this.bidIncrement = 500, // Default
    this.leadingFranchise,
    this.bidHistory = const [],
    this.status = 'WAITING',
    this.remainingSeconds = 0,
    this.isTimerRunning = false,
  });

  AuctionState copyWith({
    String? currentPlayerId,
    String? currentPlayerName,
    int? currentBid,
    int? bidIncrement,
    String? leadingFranchise,
    List<BidPlaced>? bidHistory,
    String? status,
    int? remainingSeconds,
    bool? isTimerRunning,
  }) {
    return AuctionState(
      currentPlayerId: currentPlayerId ?? this.currentPlayerId,
      currentPlayerName: currentPlayerName ?? this.currentPlayerName,
      currentBid: currentBid ?? this.currentBid,
      bidIncrement: bidIncrement ?? this.bidIncrement,
      leadingFranchise: leadingFranchise ?? this.leadingFranchise,
      bidHistory: bidHistory ?? this.bidHistory,
      status: status ?? this.status,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isTimerRunning: isTimerRunning ?? this.isTimerRunning,
    );
  }
}
