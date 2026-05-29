import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'auth_guard.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final AuthGuard authGuard;

  AppRouter(this.authGuard);

  // On web, route transitions cause a brief frame where both the old and new
  // route are painted side-by-side (since there is no GPU animation layer).
  // Use zero-duration / no-transition for web to avoid this visual glitch.
  AutoRoute _route({
    required PageInfo page,
    String? path,
    List<AutoRouteGuard> guards = const [],
    bool initial = false,
  }) {
    if (kIsWeb) {
      return CustomRoute(
        page: page,
        path: path,
        guards: guards,
        initial: initial,
        transitionsBuilder: TransitionsBuilders.noTransition,
        duration: Duration.zero,
      );
    }
    return AutoRoute(page: page, path: path, guards: guards, initial: initial);
  }

  @override
  List<AutoRoute> get routes => [
    _route(page: SplashRoute.page, initial: true),
    _route(page: PhoneEntryRoute.page, guards: [authGuard]),
    _route(page: OtpRoute.page, guards: [authGuard]),
    _route(page: ClaimProfileRoute.page, guards: [authGuard]),
    _route(page: ProfileSetupRoute.page, guards: [authGuard]),
    _route(page: ProfileEditRoute.page, guards: [authGuard]),
    _route(page: HomeRoute.page, guards: [authGuard]),
    _route(page: LeagueDetailRoute.page, guards: [authGuard]),
    _route(page: LiveAuctionViewerRoute.page, guards: [authGuard]),
    _route(page: AuctioneerPanelRoute.page, guards: [authGuard]),
    _route(page: FeeManagementRoute.page, guards: [authGuard]),
    _route(page: ForfeitManagementRoute.page, guards: [authGuard]),
    _route(page: FranchiseSquadRoute.page, guards: [authGuard]),
    _route(page: NotificationRoute.page, guards: [authGuard]),
    _route(page: LeagueCreateRoute.page, guards: [authGuard]),
    _route(page: PostAuctionRoute.page, guards: [authGuard]),
    _route(page: FranchiseInviteRoute.page, path: '/invite/:token', guards: [authGuard]),
    // Public spectator share link — no auth guard.
    _route(page: SpectatorRoute.page, path: '/spectate/:token'),
    _route(page: PlatformAdminRoute.page, path: '/admin', guards: [authGuard]),
    _route(page: AdminUsersRoute.page, path: '/admin/users', guards: [authGuard]),
    _route(page: PreAssignmentRoute.page, path: '/leagues/:leagueId/pre-assignment', guards: [authGuard]),
    _route(page: PricingRoute.page, path: '/leagues/:leagueId/pricing', guards: [authGuard]),
  ];
}
