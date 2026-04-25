// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:crichere_flutter/features/auction/presentation/auctioneer/auctioneer_panel_screen.dart'
    as _i1;
import 'package:crichere_flutter/features/auction/presentation/screens/live_auction_viewer_screen.dart'
    as _i6;
import 'package:crichere_flutter/features/auth/presentation/screens/claim_profile_screen.dart'
    as _i2;
import 'package:crichere_flutter/features/auth/presentation/screens/otp_screen.dart'
    as _i8;
import 'package:crichere_flutter/features/auth/presentation/screens/phone_entry_screen.dart'
    as _i9;
import 'package:crichere_flutter/features/auth/presentation/screens/profile_setup_screen.dart'
    as _i10;
import 'package:crichere_flutter/features/franchise/presentation/screens/franchise_squad_screen.dart'
    as _i3;
import 'package:crichere_flutter/features/league/presentation/screens/home_screen.dart'
    as _i4;
import 'package:crichere_flutter/features/league/presentation/screens/league_detail_screen.dart'
    as _i5;
import 'package:crichere_flutter/features/notification/presentation/screens/notification_screen.dart'
    as _i7;
import 'package:flutter/material.dart' as _i12;

/// generated route for
/// [_i1.AuctioneerPanelScreen]
class AuctioneerPanelRoute
    extends _i11.PageRouteInfo<AuctioneerPanelRouteArgs> {
  AuctioneerPanelRoute({
    _i12.Key? key,
    required String auctionId,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         AuctioneerPanelRoute.name,
         args: AuctioneerPanelRouteArgs(key: key, auctionId: auctionId),
         initialChildren: children,
       );

  static const String name = 'AuctioneerPanelRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AuctioneerPanelRouteArgs>();
      return _i1.AuctioneerPanelScreen(
        key: args.key,
        auctionId: args.auctionId,
      );
    },
  );
}

class AuctioneerPanelRouteArgs {
  const AuctioneerPanelRouteArgs({this.key, required this.auctionId});

  final _i12.Key? key;

  final String auctionId;

  @override
  String toString() {
    return 'AuctioneerPanelRouteArgs{key: $key, auctionId: $auctionId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AuctioneerPanelRouteArgs) return false;
    return key == other.key && auctionId == other.auctionId;
  }

  @override
  int get hashCode => key.hashCode ^ auctionId.hashCode;
}

/// generated route for
/// [_i2.ClaimProfileScreen]
class ClaimProfileRoute extends _i11.PageRouteInfo<void> {
  const ClaimProfileRoute({List<_i11.PageRouteInfo>? children})
    : super(ClaimProfileRoute.name, initialChildren: children);

  static const String name = 'ClaimProfileRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i2.ClaimProfileScreen();
    },
  );
}

/// generated route for
/// [_i3.FranchiseSquadScreen]
class FranchiseSquadRoute extends _i11.PageRouteInfo<FranchiseSquadRouteArgs> {
  FranchiseSquadRoute({
    _i12.Key? key,
    required String franchiseId,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         FranchiseSquadRoute.name,
         args: FranchiseSquadRouteArgs(key: key, franchiseId: franchiseId),
         initialChildren: children,
       );

  static const String name = 'FranchiseSquadRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FranchiseSquadRouteArgs>();
      return _i3.FranchiseSquadScreen(
        key: args.key,
        franchiseId: args.franchiseId,
      );
    },
  );
}

class FranchiseSquadRouteArgs {
  const FranchiseSquadRouteArgs({this.key, required this.franchiseId});

  final _i12.Key? key;

  final String franchiseId;

  @override
  String toString() {
    return 'FranchiseSquadRouteArgs{key: $key, franchiseId: $franchiseId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FranchiseSquadRouteArgs) return false;
    return key == other.key && franchiseId == other.franchiseId;
  }

  @override
  int get hashCode => key.hashCode ^ franchiseId.hashCode;
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeScreen();
    },
  );
}

/// generated route for
/// [_i5.LeagueDetailScreen]
class LeagueDetailRoute extends _i11.PageRouteInfo<LeagueDetailRouteArgs> {
  LeagueDetailRoute({
    _i12.Key? key,
    required String leagueId,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         LeagueDetailRoute.name,
         args: LeagueDetailRouteArgs(key: key, leagueId: leagueId),
         initialChildren: children,
       );

  static const String name = 'LeagueDetailRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LeagueDetailRouteArgs>();
      return _i5.LeagueDetailScreen(key: args.key, leagueId: args.leagueId);
    },
  );
}

class LeagueDetailRouteArgs {
  const LeagueDetailRouteArgs({this.key, required this.leagueId});

  final _i12.Key? key;

  final String leagueId;

  @override
  String toString() {
    return 'LeagueDetailRouteArgs{key: $key, leagueId: $leagueId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LeagueDetailRouteArgs) return false;
    return key == other.key && leagueId == other.leagueId;
  }

  @override
  int get hashCode => key.hashCode ^ leagueId.hashCode;
}

/// generated route for
/// [_i6.LiveAuctionViewerScreen]
class LiveAuctionViewerRoute
    extends _i11.PageRouteInfo<LiveAuctionViewerRouteArgs> {
  LiveAuctionViewerRoute({
    _i12.Key? key,
    required String auctionId,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         LiveAuctionViewerRoute.name,
         args: LiveAuctionViewerRouteArgs(key: key, auctionId: auctionId),
         initialChildren: children,
       );

  static const String name = 'LiveAuctionViewerRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LiveAuctionViewerRouteArgs>();
      return _i6.LiveAuctionViewerScreen(
        key: args.key,
        auctionId: args.auctionId,
      );
    },
  );
}

class LiveAuctionViewerRouteArgs {
  const LiveAuctionViewerRouteArgs({this.key, required this.auctionId});

  final _i12.Key? key;

  final String auctionId;

  @override
  String toString() {
    return 'LiveAuctionViewerRouteArgs{key: $key, auctionId: $auctionId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LiveAuctionViewerRouteArgs) return false;
    return key == other.key && auctionId == other.auctionId;
  }

  @override
  int get hashCode => key.hashCode ^ auctionId.hashCode;
}

/// generated route for
/// [_i7.NotificationScreen]
class NotificationRoute extends _i11.PageRouteInfo<void> {
  const NotificationRoute({List<_i11.PageRouteInfo>? children})
    : super(NotificationRoute.name, initialChildren: children);

  static const String name = 'NotificationRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i7.NotificationScreen();
    },
  );
}

/// generated route for
/// [_i8.OtpScreen]
class OtpRoute extends _i11.PageRouteInfo<OtpRouteArgs> {
  OtpRoute({
    _i12.Key? key,
    required String phone,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         OtpRoute.name,
         args: OtpRouteArgs(key: key, phone: phone),
         initialChildren: children,
       );

  static const String name = 'OtpRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpRouteArgs>();
      return _i8.OtpScreen(key: args.key, phone: args.phone);
    },
  );
}

class OtpRouteArgs {
  const OtpRouteArgs({this.key, required this.phone});

  final _i12.Key? key;

  final String phone;

  @override
  String toString() {
    return 'OtpRouteArgs{key: $key, phone: $phone}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OtpRouteArgs) return false;
    return key == other.key && phone == other.phone;
  }

  @override
  int get hashCode => key.hashCode ^ phone.hashCode;
}

/// generated route for
/// [_i9.PhoneEntryScreen]
class PhoneEntryRoute extends _i11.PageRouteInfo<void> {
  const PhoneEntryRoute({List<_i11.PageRouteInfo>? children})
    : super(PhoneEntryRoute.name, initialChildren: children);

  static const String name = 'PhoneEntryRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.PhoneEntryScreen();
    },
  );
}

/// generated route for
/// [_i10.ProfileSetupScreen]
class ProfileSetupRoute extends _i11.PageRouteInfo<void> {
  const ProfileSetupRoute({List<_i11.PageRouteInfo>? children})
    : super(ProfileSetupRoute.name, initialChildren: children);

  static const String name = 'ProfileSetupRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.ProfileSetupScreen();
    },
  );
}
