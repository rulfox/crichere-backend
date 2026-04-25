import 'package:auto_route/auto_route.dart';
import 'auth_guard.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final AuthGuard authGuard;

  AppRouter(this.authGuard);

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: PhoneEntryRoute.page, initial: true, guards: [authGuard]),
    AutoRoute(page: OtpRoute.page, guards: [authGuard]),
    AutoRoute(page: HomeRoute.page, guards: [authGuard]),
    AutoRoute(page: LeagueDetailRoute.page, guards: [authGuard]),
    AutoRoute(page: LiveAuctionViewerRoute.page, guards: [authGuard]),
    AutoRoute(page: AuctioneerPanelRoute.page, guards: [authGuard]),
    AutoRoute(page: FranchiseSquadRoute.page, guards: [authGuard]),
    AutoRoute(page: NotificationRoute.page, guards: [authGuard]),
    AutoRoute(page: LeagueCreateRoute.page, guards: [authGuard]),
  ];
}
