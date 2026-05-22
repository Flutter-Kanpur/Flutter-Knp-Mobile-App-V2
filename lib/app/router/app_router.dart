import 'package:flutter_knp_mobile_app_v2/app/router/route_names.dart';
import 'package:flutter_knp_mobile_app_v2/modules/auth/presentation/screens/auth_landing_screen.dart';
import 'package:flutter_knp_mobile_app_v2/modules/auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter_knp_mobile_app_v2/modules/auth/presentation/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.authLanding,
  routes: [
    GoRoute(
      path: RouteNames.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteNames.authLanding,
      builder: (context, state) => const AuthLandingScreen(),
    ),
    GoRoute(
      path: RouteNames.signIn,
      builder: (context, state) => const AuthLandingScreen(),
    ),
    GoRoute(
      path: RouteNames.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
  ],
);
