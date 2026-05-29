import 'package:freezed_annotation/freezed_annotation.dart';

part 'fee_entities.freezed.dart';
part 'fee_entities.g.dart';

// Matches backend FeeObligationResponse (wrapped inside FeeObligationDetailResponse)
@freezed
abstract class FeeObligation with _$FeeObligation {
  const factory FeeObligation({
    required String id,
    required String leagueId,
    required String userId,
    String? franchiseId,
    required String feeType,
    required int totalAmount,
    int? minimumToRegister,
    required int paidAmount,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FeeObligation;

  factory FeeObligation.fromJson(Map<String, dynamic> json) => _$FeeObligationFromJson(json);
}

// Matches backend FeeObligationDetailResponse {obligation, payments}
@freezed
abstract class FeeObligationDetail with _$FeeObligationDetail {
  const factory FeeObligationDetail({
    required FeeObligation obligation,
    required List<FeePayment> payments,
  }) = _FeeObligationDetail;

  factory FeeObligationDetail.fromJson(Map<String, dynamic> json) => _$FeeObligationDetailFromJson(json);
}

// Matches backend FeeObligationListResponse (paginated)
@freezed
abstract class FeeObligationListResponse with _$FeeObligationListResponse {
  const factory FeeObligationListResponse({
    required List<FeeObligationDetail> obligations,
    required int totalElements,
    required int totalPages,
    required int pageNumber,
    required int pageSize,
  }) = _FeeObligationListResponse;

  factory FeeObligationListResponse.fromJson(Map<String, dynamic> json) => _$FeeObligationListResponseFromJson(json);
}

// Matches backend FeePaymentResponse
@freezed
abstract class FeePayment with _$FeePayment {
  const factory FeePayment({
    required String id,
    required String obligationId,
    required int amount,
    required String paymentMode, // CASH, ONLINE, REFUND, WAIVER
    String? notes,
    String? recordedBy,
    DateTime? createdAt,
  }) = _FeePayment;

  factory FeePayment.fromJson(Map<String, dynamic> json) => _$FeePaymentFromJson(json);
}

// Matches backend FeeSummaryResponse
@freezed
abstract class FeeSummary with _$FeeSummary {
  const factory FeeSummary({
    @Default(0) int totalExpected,
    @Default(0) int totalCollected,
    @Default(0) int balanceDue,
    @Default(0) int unpaidCount,
    @Default(0) int partiallyPaidCount,
    @Default(0) int paidCount,
    @Default(0) int waivedCount,
  }) = _FeeSummary;

  factory FeeSummary.fromJson(Map<String, dynamic> json) => _$FeeSummaryFromJson(json);
}
