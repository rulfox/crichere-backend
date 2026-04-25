import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: PhoneEntryRoute.page, initial: true),
    AutoRoute(page: OtpRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: LeagueDetailRoute.page),
    AutoRoute(page: LiveAuctionViewerRoute.page),
    AutoRoute(page: AuctioneerPanelRoute.page),
    AutoRoute(page: FranchiseSquadRoute.page),
    AutoRoute(page: NotificationRoute.page),
  ];
}
