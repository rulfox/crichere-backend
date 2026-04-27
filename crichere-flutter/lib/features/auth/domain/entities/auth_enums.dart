import 'package:json_annotation/json_annotation.dart';

enum ProfileStatus {
  @JsonValue('GHOST') ghost,
  @JsonValue('CLAIMED') claimed,
  @JsonValue('ACTIVE') active
}

enum PlayingRole {
  @JsonValue('BATTER') batter,
  @JsonValue('BOWLER') bowler,
  @JsonValue('ALL_ROUNDER') allRounder,
  @JsonValue('WICKET_KEEPER') wicketKeeper
}

enum BattingStyle {
  @JsonValue('RIGHT_HAND') rightHand,
  @JsonValue('LEFT_HAND') leftHand
}

enum BowlingStyle {
  @JsonValue('RIGHT_ARM') rightArm,
  @JsonValue('LEFT_ARM') leftArm
}

enum BowlingType {
  @JsonValue('FAST') fast,
  @JsonValue('MEDIUM_FAST') mediumFast,
  @JsonValue('MEDIUM') medium,
  @JsonValue('OFF_SPIN') offSpin,
  @JsonValue('LEG_SPIN') legSpin,
  @JsonValue('SLOW_LEFT_ARM') slowLeftArm,
  @JsonValue('SLOW_LEFT_ARM_ORTHODOX') slowLeftArmOrthodox
}

enum ExperienceLevel {
  @JsonValue('LOCAL') local,
  @JsonValue('DISTRICT') district,
  @JsonValue('STATE') state,
  @JsonValue('NATIONAL') national
}

enum LeagueRole {
  @JsonValue('LEAGUE_ADMIN') leagueAdmin,
  @JsonValue('AUCTIONEER') auctioneer
}
