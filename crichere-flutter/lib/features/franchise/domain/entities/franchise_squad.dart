import 'package:freezed_annotation/freezed_annotation.dart';
import 'franchise_player.dart';

part 'franchise_squad.freezed.dart';
part 'franchise_squad.g.dart';

@freezed
abstract class FranchiseSquad with _$FranchiseSquad {
  const factory FranchiseSquad({
    required String franchiseId,
    required String franchiseName,
    required int purseRemaining,
    required List<FranchisePlayer> players,
  }) = _FranchiseSquad;

  factory FranchiseSquad.fromJson(Map<String, dynamic> json) => _$FranchiseSquadFromJson(json);
}
