import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:odyss/core/constraints.dart';
import 'package:odyss/screens/chat_screen/chat_screen.dart';
import 'package:odyss/screens/curate_trip_screen/curate_trip_screen.dart';
import 'package:odyss/screens/explore_screen/explore_screen.dart';
import 'package:odyss/screens/login_screen/login_screen.dart';
import 'package:odyss/screens/profile_screen/profile_screen.dart';
import 'package:odyss/screens/ride_details_screen/ride_details_screen.dart';
import 'package:odyss/screens/rides_screen/rides_screen.dart';
import 'package:odyss/screens/signup_screens/signup_sc%20reen1.dart';
import 'package:odyss/screens/signup_screens/signup_screen2.dart';
import 'package:odyss/screens/signup_screens/signup_screen3.dart';
import 'package:odyss/screens/signup_screens/signup_screen4.dart';
import 'package:odyss/screens/signup_screens/signup_screen5.dart';
import 'package:odyss/screens/splash_screen.dart';
import 'package:odyss/screens/start_screen/start_screen.dart';
import 'package:odyss/screens/trip_details_screen/trip_details_screen.dart';
import 'package:odyss/screens/trip_vibe.dart/trip_vibe_screen.dart';
import 'package:odyss/screens/welcome_screen/welcome_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: initLocationFunc(),
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashScreen()),
    GoRoute(
      path: '/start',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: StartScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation.drive(
                Tween<double>(
                  begin: 0.95,
                  end: 1.0,
                ).chain(CurveTween(curve: Curves.easeOut)),
              ),
              child: child,
            ),
          );
        },
      ),
    ),
    GoRoute(
      path: '/welcome',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: WelcomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide in from right
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide in from right
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/signup1',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: SignupScreen1(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide in from right
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/signup2',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: SignupScreen2(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide in from right
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/signup3',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: SignupScreen3(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide in from right
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/signup4',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: SignupScreen4(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide in from right
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/signup5',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: SignupScreen5(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide in from right
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) => NoTransitionPage(child: ProfileScreen()),
    ),
    GoRoute(
      path: '/chat',
      pageBuilder: (context, state) => NoTransitionPage(child: ChatScreen()),
    ),
    GoRoute(
      path: '/explore',
      pageBuilder: (context, state) => NoTransitionPage(child: ExploreScreen()),
    ),
    GoRoute(
      path: '/rides',
      pageBuilder: (context, state) => NoTransitionPage(child: RidesScreen()),
    ),
    GoRoute(path: '/curate',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: CurateTripScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(0, 1), // From bottom
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/tripDetails',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: TripDetailsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide in from right
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/rideDetails',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: RideDetailsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide in from right
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/tripVibe',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: TripVibeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide in from right
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ),
  ],
);
