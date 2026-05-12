// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeeObligation _$FeeObligationFromJson(Map<String, dynamic> json) =>
    _FeeObligation(
      id: json['id'] as String,
      leagueId: json['leagueId'] as String,
      entityId: json['entityId'] as String,
      entityName: json['entityName'] as String,
      feeType: json['feeType'] as String,
      totalAmount: (json['totalAmount'] as num).toInt(),
      paidAmount: (json['paidAmount'] as num).toInt(),
      status: json['status'] as String,
      auctionEligible: json['auctionEligible'] as bool,
    );

Map<String, dynamic> _$FeeObligationToJson(_FeeObligation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leagueId': instance.leagueId,
      'entityId': instance.entityId,
      'entityName': instance.entityName,
      'feeType': instance.feeType,
      'totalAmount': instance.totalAmount,
      'paidAmount': instance.paidAmount,
      'status': instance.status,
      'auctionEligible': instance.auctionEligible,
    };

_FeePayment _$FeePaymentFromJson(Map<String, dynamic> json) => _FeePayment(
  id: json['id'] as String,
  obligationId: json['obligationId'] as String,
  amount: (json['amount'] as num).toInt(),
  paymentMode: json['paymentMode'] as String,
  paidAt: DateTime.parse(json['paidAt'] as String),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$FeePaymentToJson(_FeePayment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'obligationId': instance.obligationId,
      'amount': instance.amount,
      'paymentMode': instance.paymentMode,
      'paidAt': instance.paidAt.toIso8601String(),
      'notes': instance.notes,
    };
