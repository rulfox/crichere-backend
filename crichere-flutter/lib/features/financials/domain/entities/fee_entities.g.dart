// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeeObligation _$FeeObligationFromJson(Map<String, dynamic> json) =>
    _FeeObligation(
      id: json['id'] as String,
      leagueId: json['leagueId'] as String,
      userId: json['userId'] as String,
      franchiseId: json['franchiseId'] as String?,
      feeType: json['feeType'] as String,
      totalAmount: (json['totalAmount'] as num).toInt(),
      minimumToRegister: (json['minimumToRegister'] as num?)?.toInt(),
      paidAmount: (json['paidAmount'] as num).toInt(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$FeeObligationToJson(_FeeObligation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leagueId': instance.leagueId,
      'userId': instance.userId,
      'franchiseId': instance.franchiseId,
      'feeType': instance.feeType,
      'totalAmount': instance.totalAmount,
      'minimumToRegister': instance.minimumToRegister,
      'paidAmount': instance.paidAmount,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_FeeObligationDetail _$FeeObligationDetailFromJson(Map<String, dynamic> json) =>
    _FeeObligationDetail(
      obligation: FeeObligation.fromJson(
        json['obligation'] as Map<String, dynamic>,
      ),
      payments: (json['payments'] as List<dynamic>)
          .map((e) => FeePayment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeeObligationDetailToJson(
  _FeeObligationDetail instance,
) => <String, dynamic>{
  'obligation': instance.obligation,
  'payments': instance.payments,
};

_FeeObligationListResponse _$FeeObligationListResponseFromJson(
  Map<String, dynamic> json,
) => _FeeObligationListResponse(
  obligations: (json['obligations'] as List<dynamic>)
      .map((e) => FeeObligationDetail.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalElements: (json['totalElements'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  pageNumber: (json['pageNumber'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
);

Map<String, dynamic> _$FeeObligationListResponseToJson(
  _FeeObligationListResponse instance,
) => <String, dynamic>{
  'obligations': instance.obligations,
  'totalElements': instance.totalElements,
  'totalPages': instance.totalPages,
  'pageNumber': instance.pageNumber,
  'pageSize': instance.pageSize,
};

_FeePayment _$FeePaymentFromJson(Map<String, dynamic> json) => _FeePayment(
  id: json['id'] as String,
  obligationId: json['obligationId'] as String,
  amount: (json['amount'] as num).toInt(),
  paymentMode: json['paymentMode'] as String,
  notes: json['notes'] as String?,
  recordedBy: json['recordedBy'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$FeePaymentToJson(_FeePayment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'obligationId': instance.obligationId,
      'amount': instance.amount,
      'paymentMode': instance.paymentMode,
      'notes': instance.notes,
      'recordedBy': instance.recordedBy,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_FeeSummary _$FeeSummaryFromJson(Map<String, dynamic> json) => _FeeSummary(
  totalExpected: (json['totalExpected'] as num?)?.toInt() ?? 0,
  totalCollected: (json['totalCollected'] as num?)?.toInt() ?? 0,
  balanceDue: (json['balanceDue'] as num?)?.toInt() ?? 0,
  unpaidCount: (json['unpaidCount'] as num?)?.toInt() ?? 0,
  partiallyPaidCount: (json['partiallyPaidCount'] as num?)?.toInt() ?? 0,
  paidCount: (json['paidCount'] as num?)?.toInt() ?? 0,
  waivedCount: (json['waivedCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$FeeSummaryToJson(_FeeSummary instance) =>
    <String, dynamic>{
      'totalExpected': instance.totalExpected,
      'totalCollected': instance.totalCollected,
      'balanceDue': instance.balanceDue,
      'unpaidCount': instance.unpaidCount,
      'partiallyPaidCount': instance.partiallyPaidCount,
      'paidCount': instance.paidCount,
      'waivedCount': instance.waivedCount,
    };
