import 'package:freezed_annotation/freezed_annotation.dart';

part 'fee_entities.freezed.dart';
part 'fee_entities.g.dart';

@freezed
abstract class FeeObligation with _$FeeObligation {
  const factory FeeObligation({
    required String id,
    required String leagueId,
    required String entityId, // PlayerId or FranchiseId
    required String entityName,
    required String feeType, // PLAYER_FEE, FRANCHISE_FEE
    required int totalAmount,
    required int paidAmount,
    required String status, // UNPAID, PARTIALLY_PAID, PAID, WAIVED
    required bool auctionEligible,
  }) = _FeeObligation;

  factory FeeObligation.fromJson(Map<String, dynamic> json) => _$FeeObligationFromJson(json);
}

@freezed
abstract class FeePayment with _$FeePayment {
  const factory FeePayment({
    required String id,
    required String obligationId,
    required int amount,
    required String paymentMode, // CASH, ONLINE
    required DateTime paidAt,
    String? notes,
  }) = _FeePayment;

  factory FeePayment.fromJson(Map<String, dynamic> json) => _$FeePaymentFromJson(json);
}
