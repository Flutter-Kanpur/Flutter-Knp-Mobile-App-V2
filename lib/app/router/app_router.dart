import 'package:flutter_knp_mobile_app_v2/app/router/route_names.dart';
import 'package:flutter_knp_mobile_app_v2/modules/auth/presentation/screens/auth_landing_screen.dart';
import 'package:flutter_knp_mobile_app_v2/modules/auth/presentation/screens/auth_options_screen.dart';
import 'package:flutter_knp_mobile_app_v2/modules/auth/presentation/screens/sign_in_screen.dart';
import 'package:flutter_knp_mobile_app_v2/modules/auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter_knp_mobile_app_v2/modules/auth/presentation/screens/splash_screen.dart';
import 'package:flutter_knp_mobile_app_v2/shared/screens/app_feedback_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.splash,
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
      path: RouteNames.authOptions,
      builder: (context, state) => const AuthOptionsScreen(),
    ),
    GoRoute(
      path: RouteNames.signIn,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: RouteNames.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: RouteNames.feedback,

      builder: (context, state) {
        return state.extra as AppFeedbackScreen;
      },
    ),
  ],
);
