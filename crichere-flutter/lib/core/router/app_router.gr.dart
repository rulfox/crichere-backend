// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i19;
import 'package:crichere_flutter/features/admin/presentation/screens/platform_admin_screen.dart'
    as _i14;
import 'package:crichere_flutter/features/auction/presentation/auctioneer/auctioneer_panel_screen.dart'
    as _i1;
import 'package:crichere_flutter/features/auction/presentation/screens/live_auction_viewer_screen.dart'
    as _i10;
import 'package:crichere_flutter/features/auction/presentation/screens/post_auction_screen.dart'
    as _i15;
import 'package:crichere_flutter/features/auth/presentation/screens/claim_profile_screen.dart'
    as _i2;
import 'package:crichere_flutter/features/auth/presentation/screens/otp_screen.dart'
    as _i12;
import 'package:crichere_flutter/features/auth/presentation/screens/phone_entry_screen.dart'
    as _i13;
import 'package:crichere_flutter/features/auth/presentation/screens/profile_setup_screen.dart'
    as _i18;
import 'package:crichere_flutter/features/financials/presentation/screens/fee_management_screen.dart'
    as _i3;
import 'package:crichere_flutter/features/financials/presentation/screens/forfeit_management_screen.dart'
    as _i4;
import 'package:crichere_flutter/features/franchise/presentation/screens/franchise_invite_screen.dart'
    as _i5;
import 'package:crichere_flutter/features/franchise/presentation/screens/franchise_squad_screen.dart'
    as _i6;
import 'package:crichere_flutter/features/league/presentation/screens/home_screen.dart'
    as _i7;
import 'package:crichere_flutter/features/league/presentation/screens/league_create_screen.dart'
    as _i8;
import 'package:crichere_flutter/features/league/presentation/screens/league_detail_screen.dart'
    as _i9;
import 'package:crichere_flutter/features/league/presentation/screens/pre_assignment_screen.dart'
    as _i16;
import 'package:crichere_flutter/features/notification/presentation/screens/notification_screen.dart'
    as _i11;
import 'package:crichere_flutter/features/player/presentation/screens/profile_edit_screen.dart'
    as _i17;
import 'package:flutter/material.dart' as _i20;

/// generated route for
/// [_i1.AuctioneerPanelScreen]
class AuctioneerPanelRoute
    extends _i19.PageRouteInfo<AuctioneerPanelRouteArgs> {
  AuctioneerPanelRoute({
    _i20.Key? key,
    required String auctionId,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         AuctioneerPanelRoute.name,
         args: AuctioneerPanelRouteArgs(key: key, auctionId: auctionId),
         initialChildren: children,
       );

  static const String name = 'AuctioneerPanelRoute';

  static _i19.PageInfo page = _i19.PageInfo(
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

  final _i20.Key? key;

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
class ClaimProfileRoute extends _i19.PageRouteInfo<ClaimProfileRouteArgs> {
  ClaimProfileRoute({
    _i20.Key? key,
    required String profileId,
    required String suggestedName,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         ClaimProfileRoute.name,
         args: ClaimProfileRouteArgs(
           key: key,
           profileId: profileId,
           suggestedName: suggestedName,
         ),
         initialChildren: children,
       );

  static const String name = 'ClaimProfileRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ClaimProfileRouteArgs>();
      return _i2.ClaimProfileScreen(
        key: args.key,
        profileId: args.profileId,
        suggestedName: args.suggestedName,
      );
    },
  );
}

class ClaimProfileRouteArgs {
  const ClaimProfileRouteArgs({
    this.key,
    required this.profileId,
    required this.suggestedName,
  });

  final _i20.Key? key;

  final String profileId;

  final String suggestedName;

  @override
  String toString() {
    return 'ClaimProfileRouteArgs{key: $key, profileId: $profileId, suggestedName: $suggestedName}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ClaimProfileRouteArgs) return false;
    return key == other.key &&
        profileId == other.profileId &&
        suggestedName == other.suggestedName;
  }

  @override
  int get hashCode =>
      key.hashCode ^ profileId.hashCode ^ suggestedName.hashCode;
}

/// generated route for
/// [_i3.FeeManagementScreen]
class FeeManagementRoute extends _i19.PageRouteInfo<FeeManagementRouteArgs> {
  FeeManagementRoute({
    _i20.Key? key,
    required String leagueId,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         FeeManagementRoute.name,
         args: FeeManagementRouteArgs(key: key, leagueId: leagueId),
         initialChildren: children,
       );

  static const String name = 'FeeManagementRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FeeManagementRouteArgs>();
      return _i3.FeeManagementScreen(key: args.key, leagueId: args.leagueId);
    },
  );
}

class FeeManagementRouteArgs {
  const FeeManagementRouteArgs({this.key, required this.leagueId});

  final _i20.Key? key;

  final String leagueId;

  @override
  String toString() {
    return 'FeeManagementRouteArgs{key: $key, leagueId: $leagueId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FeeManagementRouteArgs) return false;
    return key == other.key && leagueId == other.leagueId;
  }

  @override
  int get hashCode => key.hashCode ^ leagueId.hashCode;
}

/// generated route for
/// [_i4.ForfeitManagementScreen]
class ForfeitManagementRoute
    extends _i19.PageRouteInfo<ForfeitManagementRouteArgs> {
  ForfeitManagementRoute({
    _i20.Key? key,
    required String leagueId,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         ForfeitManagementRoute.name,
         args: ForfeitManagementRouteArgs(key: key, leagueId: leagueId),
         initialChildren: children,
       );

  static const String name = 'ForfeitManagementRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForfeitManagementRouteArgs>();
      return _i4.ForfeitManagementScreen(
        key: args.key,
        leagueId: args.leagueId,
      );
    },
  );
}

class ForfeitManagementRouteArgs {
  const ForfeitManagementRouteArgs({this.key, required this.leagueId});

  final _i20.Key? key;

  final String leagueId;

  @override
  String toString() {
    return 'ForfeitManagementRouteArgs{key: $key, leagueId: $leagueId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ForfeitManagementRouteArgs) return false;
    return key == other.key && leagueId == other.leagueId;
  }

  @override
  int get hashCode => key.hashCode ^ leagueId.hashCode;
}

/// generated route for
/// [_i5.FranchiseInviteScreen]
class FranchiseInviteRoute
    extends _i19.PageRouteInfo<FranchiseInviteRouteArgs> {
  FranchiseInviteRoute({
    _i20.Key? key,
    required String token,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         FranchiseInviteRoute.name,
         args: FranchiseInviteRouteArgs(key: key, token: token),
         rawPathParams: {'token': token},
         initialChildren: children,
       );

  static const String name = 'FranchiseInviteRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<FranchiseInviteRouteArgs>(
        orElse: () =>
            FranchiseInviteRouteArgs(token: pathParams.getString('token')),
      );
      return _i5.FranchiseInviteScreen(key: args.key, token: args.token);
    },
  );
}

class FranchiseInviteRouteArgs {
  const FranchiseInviteRouteArgs({this.key, required this.token});

  final _i20.Key? key;

  final String token;

  @override
  String toString() {
    return 'FranchiseInviteRouteArgs{key: $key, token: $token}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FranchiseInviteRouteArgs) return false;
    return key == other.key && token == other.token;
  }

  @override
  int get hashCode => key.hashCode ^ token.hashCode;
}

/// generated route for
/// [_i6.FranchiseSquadScreen]
class FranchiseSquadRoute extends _i19.PageRouteInfo<FranchiseSquadRouteArgs> {
  FranchiseSquadRoute({
    _i20.Key? key,
    required String franchiseId,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         FranchiseSquadRoute.name,
         args: FranchiseSquadRouteArgs(key: key, franchiseId: franchiseId),
         initialChildren: children,
       );

  static const String name = 'FranchiseSquadRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FranchiseSquadRouteArgs>();
      return _i6.FranchiseSquadScreen(
        key: args.key,
        franchiseId: args.franchiseId,
      );
    },
  );
}

class FranchiseSquadRouteArgs {
  const FranchiseSquadRouteArgs({this.key, required this.franchiseId});

  final _i20.Key? key;

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
/// [_i7.HomeScreen]
class HomeRoute extends _i19.PageRouteInfo<void> {
  const HomeRoute({List<_i19.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i7.HomeScreen();
    },
  );
}

/// generated route for
/// [_i8.LeagueCreateScreen]
class LeagueCreateRoute extends _i19.PageRouteInfo<void> {
  const LeagueCreateRoute({List<_i19.PageRouteInfo>? children})
    : super(LeagueCreateRoute.name, initialChildren: children);

  static const String name = 'LeagueCreateRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i8.LeagueCreateScreen();
    },
  );
}

/// generated route for
/// [_i9.LeagueDetailScreen]
class LeagueDetailRoute extends _i19.PageRouteInfo<LeagueDetailRouteArgs> {
  LeagueDetailRoute({
    _i20.Key? key,
    required String leagueId,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         LeagueDetailRoute.name,
         args: LeagueDetailRouteArgs(key: key, leagueId: leagueId),
         initialChildren: children,
       );

  static const String name = 'LeagueDetailRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LeagueDetailRouteArgs>();
      return _i9.LeagueDetailScreen(key: args.key, leagueId: args.leagueId);
    },
  );
}

class LeagueDetailRouteArgs {
  const LeagueDetailRouteArgs({this.key, required this.leagueId});

  final _i20.Key? key;

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
/// [_i10.LiveAuctionViewerScreen]
class LiveAuctionViewerRoute
    extends _i19.PageRouteInfo<LiveAuctionViewerRouteArgs> {
  LiveAuctionViewerRoute({
    _i20.Key? key,
    required String auctionId,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         LiveAuctionViewerRoute.name,
         args: LiveAuctionViewerRouteArgs(key: key, auctionId: auctionId),
         initialChildren: children,
       );

  static const String name = 'LiveAuctionViewerRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LiveAuctionViewerRouteArgs>();
      return _i10.LiveAuctionViewerScreen(
        key: args.key,
        auctionId: args.auctionId,
      );
    },
  );
}

class LiveAuctionViewerRouteArgs {
  const LiveAuctionViewerRouteArgs({this.key, required this.auctionId});

  final _i20.Key? key;

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
/// [_i11.NotificationScreen]
class NotificationRoute extends _i19.PageRouteInfo<void> {
  const NotificationRoute({List<_i19.PageRouteInfo>? children})
    : super(NotificationRoute.name, initialChildren: children);

  static const String name = 'NotificationRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i11.NotificationScreen();
    },
  );
}

/// generated route for
/// [_i12.OtpScreen]
class OtpRoute extends _i19.PageRouteInfo<OtpRouteArgs> {
  OtpRoute({
    _i20.Key? key,
    required String phone,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         OtpRoute.name,
         args: OtpRouteArgs(key: key, phone: phone),
         initialChildren: children,
       );

  static const String name = 'OtpRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpRouteArgs>();
      return _i12.OtpScreen(key: args.key, phone: args.phone);
    },
  );
}

class OtpRouteArgs {
  const OtpRouteArgs({this.key, required this.phone});

  final _i20.Key? key;

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
/// [_i13.PhoneEntryScreen]
class PhoneEntryRoute extends _i19.PageRouteInfo<void> {
  const PhoneEntryRoute({List<_i19.PageRouteInfo>? children})
    : super(PhoneEntryRoute.name, initialChildren: children);

  static const String name = 'PhoneEntryRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i13.PhoneEntryScreen();
    },
  );
}

/// generated route for
/// [_i14.PlatformAdminScreen]
class PlatformAdminRoute extends _i19.PageRouteInfo<void> {
  const PlatformAdminRoute({List<_i19.PageRouteInfo>? children})
    : super(PlatformAdminRoute.name, initialChildren: children);

  static const String name = 'PlatformAdminRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i14.PlatformAdminScreen();
    },
  );
}

/// generated route for
/// [_i15.PostAuctionScreen]
class PostAuctionRoute extends _i19.PageRouteInfo<PostAuctionRouteArgs> {
  PostAuctionRoute({
    _i20.Key? key,
    required String auctionId,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         PostAuctionRoute.name,
         args: PostAuctionRouteArgs(key: key, auctionId: auctionId),
         initialChildren: children,
       );

  static const String name = 'PostAuctionRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostAuctionRouteArgs>();
      return _i15.PostAuctionScreen(key: args.key, auctionId: args.auctionId);
    },
  );
}

class PostAuctionRouteArgs {
  const PostAuctionRouteArgs({this.key, required this.auctionId});

  final _i20.Key? key;

  final String auctionId;

  @override
  String toString() {
    return 'PostAuctionRouteArgs{key: $key, auctionId: $auctionId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PostAuctionRouteArgs) return false;
    return key == other.key && auctionId == other.auctionId;
  }

  @override
  int get hashCode => key.hashCode ^ auctionId.hashCode;
}

/// generated route for
/// [_i16.PreAssignmentScreen]
class PreAssignmentRoute extends _i19.PageRouteInfo<PreAssignmentRouteArgs> {
  PreAssignmentRoute({
    _i20.Key? key,
    required String leagueId,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         PreAssignmentRoute.name,
         args: PreAssignmentRouteArgs(key: key, leagueId: leagueId),
         initialChildren: children,
       );

  static const String name = 'PreAssignmentRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PreAssignmentRouteArgs>();
      return _i16.PreAssignmentScreen(key: args.key, leagueId: args.leagueId);
    },
  );
}

class PreAssignmentRouteArgs {
  const PreAssignmentRouteArgs({this.key, required this.leagueId});

  final _i20.Key? key;

  final String leagueId;

  @override
  String toString() {
    return 'PreAssignmentRouteArgs{key: $key, leagueId: $leagueId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PreAssignmentRouteArgs) return false;
    return key == other.key && leagueId == other.leagueId;
  }

  @override
  int get hashCode => key.hashCode ^ leagueId.hashCode;
}

/// generated route for
/// [_i17.ProfileEditScreen]
class ProfileEditRoute extends _i19.PageRouteInfo<void> {
  const ProfileEditRoute({List<_i19.PageRouteInfo>? children})
    : super(ProfileEditRoute.name, initialChildren: children);

  static const String name = 'ProfileEditRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i17.ProfileEditScreen();
    },
  );
}

/// generated route for
/// [_i18.ProfileSetupScreen]
class ProfileSetupRoute extends _i19.PageRouteInfo<void> {
  const ProfileSetupRoute({List<_i19.PageRouteInfo>? children})
    : super(ProfileSetupRoute.name, initialChildren: children);

  static const String name = 'ProfileSetupRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i18.ProfileSetupScreen();
    },
  );
}
