import 'package:auto_route/auto_route.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  final FlutterSecureStorage _storage;

  AuthGuard(this._storage);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // A storage read that throws must not crash navigation — treat it as
    // "no token" so the app falls back to the login flow gracefully.
    String? token;
    try {
      token = await _storage.read(key: 'accessToken');
    } catch (_) {
      token = null;
    }

    if (token != null) {
      // If user is trying to go to login/otp while authenticated, send them home
      if (resolver.route.name == PhoneEntryRoute.name || resolver.route.name == OtpRoute.name) {
        router.replaceAll([const HomeRoute()]);
      } else {
        resolver.next(true);
      }
    } else {
      // Not authenticated
      if (resolver.route.name == PhoneEntryRoute.name || 
          resolver.route.name == OtpRoute.name ||
          resolver.route.name == FranchiseInviteRoute.name) {
        resolver.next(true);
      } else {
        router.replaceAll([const PhoneEntryRoute()]);
        resolver.next(false);
      }
    }
  }
}
