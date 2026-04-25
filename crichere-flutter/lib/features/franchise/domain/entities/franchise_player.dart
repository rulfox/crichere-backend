import 'package:freezed_annotation/freezed_annotation.dart';

part 'franchise_player.freezed.dart';
part 'franchise_player.g.dart';

@freezed
abstract class FranchisePlayer with _$FranchisePlayer {
  const factory FranchisePlayer({
    required String playerId,
    required String name,
    String? photoUrl,
    required String role,
    required int price,
    required String assignmentType, // CAPTAIN, ICON, AUCTIONED
  }) = _FranchisePlayer;

  factory FranchisePlayer.fromJson(Map<String, dynamic> json) => _$FranchisePlayerFromJson(json);
}
