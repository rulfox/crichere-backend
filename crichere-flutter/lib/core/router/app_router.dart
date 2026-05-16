import 'package:auto_route/auto_route.dart';
import 'auth_guard.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final AuthGuard authGuard;

  AppRouter(this.authGuard);

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true), // no guard — reads token and routes
    AutoRoute(page: PhoneEntryRoute.page, guards: [authGuard]),
    AutoRoute(page: OtpRoute.page, guards: [authGuard]),
    AutoRoute(page: ClaimProfileRoute.page, guards: [authGuard]),
    AutoRoute(page: ProfileSetupRoute.page, guards: [authGuard]),
    AutoRoute(page: ProfileEditRoute.page, guards: [authGuard]),
    AutoRoute(page: HomeRoute.page, guards: [authGuard]),
    AutoRoute(page: LeagueDetailRoute.page, guards: [authGuard]),
    AutoRoute(page: LiveAuctionViewerRoute.page, guards: [authGuard]),
    AutoRoute(page: AuctioneerPanelRoute.page, guards: [authGuard]),
    AutoRoute(page: FeeManagementRoute.page, guards: [authGuard]),
    AutoRoute(page: ForfeitManagementRoute.page, guards: [authGuard]),
    AutoRoute(page: FranchiseSquadRoute.page, guards: [authGuard]),
    AutoRoute(page: NotificationRoute.page, guards: [authGuard]),
    AutoRoute(page: LeagueCreateRoute.page, guards: [authGuard]),
    AutoRoute(page: PostAuctionRoute.page, guards: [authGuard]),
    AutoRoute(page: FranchiseInviteRoute.page, path: '/invite/:token', guards: [authGuard]),
    AutoRoute(page: PlatformAdminRoute.page, path: '/admin', guards: [authGuard]),
    AutoRoute(page: PreAssignmentRoute.page, path: '/leagues/:leagueId/pre-assignment', guards: [authGuard]),
  ];
}
