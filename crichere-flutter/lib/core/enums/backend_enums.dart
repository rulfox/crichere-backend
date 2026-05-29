/// Backend enums mirrored from `crichere-backend`.
///
/// Every enum carries an `unknown` member so that when the server adds a new
/// constant the client deserializes it to `unknown` instead of throwing. When a
/// field of one of these types is used inside a json_serializable model, annotate
/// it with `@JsonKey(unknownEnumValue: <Enum>.unknown)`.
library;

import 'package:json_annotation/json_annotation.dart';

enum AuctionStatus {
  @JsonValue('DRAFT') draft,
  @JsonValue('LIVE') live,
  @JsonValue('PAUSED') paused,
  @JsonValue('COMPLETED') completed,
  @JsonValue('CANCELLED') cancelled,
  unknown,
}

enum LeagueStatus {
  @JsonValue('DRAFT') draft,
  @JsonValue('OPEN') open,
  @JsonValue('AUCTION_INITIALIZED') auctionInitialized,
  @JsonValue('AUCTION_IN_PROGRESS') auctionInProgress,
  @JsonValue('AUCTION_COMPLETED') auctionCompleted,
  @JsonValue('COMPLETED') completed,
  unknown,
}

enum PlayerOrderMode {
  @JsonValue('RANDOM') random,
  @JsonValue('FREE_PICK') freePick,
  @JsonValue('HYBRID') hybrid,
  unknown,
}

enum WaitingListMode {
  @JsonValue('AUTO_PROMOTE') autoPromote,
  @JsonValue('ADMIN_PICKS') adminPicks,
  unknown,
}

enum CurrencyType {
  @JsonValue('POINTS') points,
  @JsonValue('CASH') cash,
  unknown,
}

enum PurseSource {
  @JsonValue('FRESH') fresh,
  @JsonValue('CARRY_OVER') carryOver,
  unknown,
}

enum BidMode {
  @JsonValue('FINAL_BID_ONLY') finalBidOnly,
  @JsonValue('EACH_BID_RECORDED') eachBidRecorded,
  unknown,
}

enum PlayerPoolSource {
  @JsonValue('ALL_REGISTERED') allRegistered,
  @JsonValue('UNSOLD_PREVIOUS_ROUND') unsoldPreviousRound,
  @JsonValue('UNSOLD_ANY_PREVIOUS_ROUND') unsoldAnyPreviousRound,
  @JsonValue('AUCTIONEER_CURATED') auctioneerCurated,
  unknown,
}

enum FranchiseEligibilityRule {
  @JsonValue('ALL') all,
  @JsonValue('REMAINING_PURSE_GREATER_THAN_ZERO') remainingPurseGreaterThanZero,
  unknown,
}

enum CompletionTrigger {
  @JsonValue('PLAYER_POOL_EXHAUSTED') playerPoolExhausted,
  @JsonValue('ALL_PURSE_EXHAUSTED') allPurseExhausted,
  @JsonValue('AUCTIONEER_MANUAL') auctioneerManual,
  unknown,
}

enum RoundStatus {
  @JsonValue('PENDING') pending,
  @JsonValue('LIVE') live,
  @JsonValue('COMPLETED') completed,
  unknown,
}

enum BidStatus {
  @JsonValue('ACTIVE') active,
  @JsonValue('UNDONE') undone,
  unknown,
}

enum PlayerAuctionStateValue {
  @JsonValue('AVAILABLE') available,
  @JsonValue('UP_FOR_BIDDING') upForBidding,
  @JsonValue('SOLD') sold,
  @JsonValue('UNSOLD') unsold,
  @JsonValue('WITHDRAWN') withdrawn,
  @JsonValue('FORCE_ASSIGNED') forceAssigned,
  @JsonValue('PRE_ASSIGNED') preAssigned,
  unknown,
}

enum AuctionAction {
  @JsonValue('PLAYER_UP') playerUp,
  @JsonValue('BID_PLACED') bidPlaced,
  @JsonValue('BID_UNDONE') bidUndone,
  @JsonValue('PLAYER_SOLD') playerSold,
  @JsonValue('SOLD_REVERTED') soldReverted,
  @JsonValue('PLAYER_UNSOLD') playerUnsold,
  @JsonValue('PLAYER_WITHDRAWN') playerWithdrawn,
  @JsonValue('PLAYER_FORCE_ASSIGNED') playerForceAssigned,
  @JsonValue('PLAYER_PRE_ASSIGNED') playerPreAssigned,
  @JsonValue('ROUND_STARTED') roundStarted,
  @JsonValue('ROUND_COMPLETED') roundCompleted,
  @JsonValue('AUCTION_STARTED') auctionStarted,
  @JsonValue('AUCTION_PAUSED') auctionPaused,
  @JsonValue('AUCTION_RESUMED') auctionResumed,
  @JsonValue('AUCTION_COMPLETED') auctionCompleted,
  @JsonValue('AUCTION_CANCELLED') auctionCancelled,
  @JsonValue('TIMER_STARTED') timerStarted,
  @JsonValue('TIMER_STOPPED') timerStopped,
  @JsonValue('TIMER_RESET') timerReset,
  @JsonValue('TIMER_EXTENDED') timerExtended,
  unknown,
}

enum AssignmentType {
  @JsonValue('CAPTAIN') captain,
  @JsonValue('ICON') icon,
  unknown,
}

enum FranchiseInviteStatus {
  @JsonValue('SENT') sent,
  @JsonValue('ACCEPTED') accepted,
  @JsonValue('EXPIRED') expired,
  unknown,
}

enum LeaguePlayerStatus {
  @JsonValue('PENDING') pending,
  @JsonValue('APPROVED') approved,
  @JsonValue('REJECTED') rejected,
  @JsonValue('WITHDRAWN') withdrawn,
  unknown,
}

enum DevicePlatform {
  @JsonValue('ANDROID') android,
  @JsonValue('IOS') ios,
  @JsonValue('WEB') web,
  unknown,
}

enum NotificationType {
  @JsonValue('AUCTION_STARTED') auctionStarted,
  @JsonValue('PLAYER_SOLD') playerSold,
  @JsonValue('FORFEIT_APPROVED') forfeitApproved,
  @JsonValue('WAITING_LIST_PROMOTED') waitingListPromoted,
  @JsonValue('FEE_PAYMENT_RECORDED') feePaymentRecorded,
  @JsonValue('FRANCHISE_INVITE') franchiseInvite,
  @JsonValue('GHOST_PROFILE_INVITE') ghostProfileInvite,
  unknown,
}

enum FeeType {
  @JsonValue('PLAYER_FEE') playerFee,
  @JsonValue('FRANCHISE_FEE') franchiseFee,
  unknown,
}

enum FeeStatus {
  @JsonValue('UNPAID') unpaid,
  @JsonValue('PARTIALLY_PAID') partiallyPaid,
  @JsonValue('PAID') paid,
  @JsonValue('WAIVED') waived,
  unknown,
}

enum PaymentMode {
  @JsonValue('CASH') cash,
  @JsonValue('ONLINE') online,
  @JsonValue('REFUND') refund,
  @JsonValue('WAIVER') waiver,
  unknown,
}

enum ForfeitType {
  @JsonValue('PLAYER') player,
  @JsonValue('FRANCHISE') franchise,
  unknown,
}

enum ForfeitStatus {
  @JsonValue('PENDING') pending,
  @JsonValue('APPROVED') approved,
  @JsonValue('REJECTED') rejected,
  @JsonValue('CANCELLED') cancelled,
  unknown,
}

enum FeeRefundDecision {
  @JsonValue('FULL_REFUND') fullRefund,
  @JsonValue('PARTIAL_REFUND') partialRefund,
  @JsonValue('NO_REFUND') noRefund,
  unknown,
}

enum WaitingListType {
  @JsonValue('PLAYER') player,
  @JsonValue('FRANCHISE') franchise,
  unknown,
}

enum WaitingListStatus {
  @JsonValue('WAITING') waiting,
  @JsonValue('PROMOTED') promoted,
  @JsonValue('REJECTED') rejected,
  @JsonValue('WITHDRAWN') withdrawn,
  unknown,
}