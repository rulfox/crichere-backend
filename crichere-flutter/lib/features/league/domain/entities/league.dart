import 'package:freezed_annotation/freezed_annotation.dart';

part 'league.freezed.dart';
part 'league.g.dart';

@freezed
abstract class League with _$League {
  const League._();

  const factory League({
    required String id,
    required String name,
    String? logoUrl,
    required String status,
    DateTime? auctionDate,
  }) = _League;

  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);
}
