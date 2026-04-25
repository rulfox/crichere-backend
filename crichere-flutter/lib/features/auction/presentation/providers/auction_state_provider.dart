import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/auction_event.dart';

part 'auction_state_provider.g.dart';

@riverpod
class AuctionStateNotifier extends _$AuctionStateNotifier {
  @override
  AuctionState build() => const AuctionState();

  void handleEvent(AuctionEvent event) {
    state = event.map(
      playerUp: (e) => state.copyWith(
        currentPlayerId: e.playerId,
        currentPlayerName: e.playerName,
        currentBid: e.basePrice,
        leadingFranchise: null,
        status: 'BIDDING',
      ),
      bidPlaced: (e) => state.copyWith(
        currentBid: e.amount,
        leadingFranchise: e.franchiseName,
        bidHistory: [e, ...state.bidHistory.take(4)],
      ),
      playerSold: (e) => state.copyWith(
        status: 'SOLD',
        bidHistory: [],
      ),
      playerUnsold: (e) => state.copyWith(
        status: 'UNSOLD',
        bidHistory: [],
      ),
      bidUndone: (_) => state, // Simplified
      soldReverted: (_) => state,
      roundStarted: (e) => state.copyWith(status: 'ROUND_${e.roundNumber}'),
      auctionStarted: (_) => state.copyWith(status: 'STARTED'),
      auctionCompleted: (_) => state.copyWith(status: 'COMPLETED'),
    );
  }
}

class AuctionState {
  final String? currentPlayerId;
  final String? currentPlayerName;
  final int currentBid;
  final String? leadingFranchise;
  final List<BidPlaced> bidHistory;
  final String status;

  const AuctionState({
    this.currentPlayerId,
    this.currentPlayerName,
    this.currentBid = 0,
    this.leadingFranchise,
    this.bidHistory = const [],
    this.status = 'WAITING',
  });

  AuctionState copyWith({
    String? currentPlayerId,
    String? currentPlayerName,
    int? currentBid,
    String? leadingFranchise,
    List<BidPlaced>? bidHistory,
    String? status,
  }) {
    return AuctionState(
      currentPlayerId: currentPlayerId ?? this.currentPlayerId,
      currentPlayerName: currentPlayerName ?? this.currentPlayerName,
      currentBid: currentBid ?? this.currentBid,
      leadingFranchise: leadingFranchise ?? this.leadingFranchise,
      bidHistory: bidHistory ?? this.bidHistory,
      status: status ?? this.status,
    );
  }
}
