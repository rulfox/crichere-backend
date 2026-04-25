// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'franchise_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FranchisePlayer _$FranchisePlayerFromJson(Map<String, dynamic> json) =>
    _FranchisePlayer(
      playerId: json['playerId'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String?,
      role: json['role'] as String,
      price: (json['price'] as num).toInt(),
      assignmentType: json['assignmentType'] as String,
    );

Map<String, dynamic> _$FranchisePlayerToJson(_FranchisePlayer instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'role': instance.role,
      'price': instance.price,
      'assignmentType': instance.assignmentType,
    };
