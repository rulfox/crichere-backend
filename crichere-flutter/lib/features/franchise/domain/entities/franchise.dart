import 'package:freezed_annotation/freezed_annotation.dart';

part 'franchise.freezed.dart';
part 'franchise.g.dart';

@freezed
abstract class Franchise with _$Franchise {
  const Franchise._();

  const factory Franchise({
    required String id,
    required String leagueId,
    required String name,
    String? logoUrl,
    required int startingPurse,
    required int currentPurse,
  }) = _Franchise;

  factory Franchise.fromJson(Map<String, dynamic> json) => _$FranchiseFromJson(json);
}
