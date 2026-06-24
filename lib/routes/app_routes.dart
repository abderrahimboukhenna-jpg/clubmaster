import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/home_dashboard_screen/home_dashboard_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/member_card_screen/member_card_screen.dart';
import '../presentation/registration_screen/widgets/generate_receipt_screen.dart';
import '../presentation/registration_screen/widgets/success_registration_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/membership_screen/membership_screen.dart';
import '../presentation/schedule_screen/schedule_screen.dart';
import '../presentation/notifications_screen/notifications_screen.dart';
import '../presentation/profile_screen/profile_screen.dart';
import '../presentation/settings_screen/settings_screen.dart';
import '../presentation/about_screen/about_screen.dart';
import '../widgets/app_scaffold.dart';
import '../presentation/registration_screen/registration_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String splashScreen = '/';
  static const String loginScreen = '/login-screen';
  static const String registrationScreen = '/registration-screen';
  static const String successRegistrationScreen ='/success-registration-screen';
  static const String generateReceiptScreen ='/generate-receipt-screen';
  static const String homeDashboardScreen = '/home-dashboard-screen';
  static const String memberCardScreen = '/member-card-screen';
  static const String membershipScreen = '/membership-screen';
  static const String scheduleScreen = '/schedule-screen';
  static const String notificationsScreen = '/notifications-screen';
  static const String profileScreen = '/profile-screen';
  static const String settingsScreen = '/settings-screen';
  static const String aboutScreen = '/about-screen';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.initial,
  errorBuilder: (context, state) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              state.error.toString(),
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  },
  routes: [
    GoRoute(
      path: AppRoutes.initial,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SplashScreen(),
        transitionDuration: const Duration(milliseconds: 280),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.loginScreen,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const LoginScreen(),
        transitionDuration: const Duration(milliseconds: 280),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0.04, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
              child: child,
            ),
          );
        },
      ),
    ),
    GoRoute(
  path: AppRoutes.registrationScreen,
  pageBuilder: (context, state) => CustomTransitionPage(
    key: state.pageKey,
    child: const RegistrationScreen(),
    transitionDuration: const Duration(milliseconds: 280),
    transitionsBuilder:
        (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        ),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.04, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
          ),
          child: child,
        ),
      );
    },
  ),
),
    GoRoute(
      path: AppRoutes.notificationsScreen,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const NotificationsScreen(),
        transitionDuration: const Duration(milliseconds: 280),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.settingsScreen,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SettingsScreen(),
        transitionDuration: const Duration(milliseconds: 280),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.aboutScreen,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const AboutScreen(),
        transitionDuration: const Duration(milliseconds: 280),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
  path: AppRoutes.successRegistrationScreen,
  builder: (context, state) {
    final dossierNumber = state.extra is String ? state.extra as String : null;

    if (dossierNumber == null || dossierNumber.isEmpty) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Numéro de dossier manquant ou invalide.',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return SuccessRegistrationScreen(
      dossierNumber: dossierNumber,
    );
  },
),
GoRoute(
  path: AppRoutes.generateReceiptScreen,
  builder: (context, state) {
    final args = state.extra is GenerateReceiptArgs
        ? state.extra as GenerateReceiptArgs
        : null;

    return GenerateReceiptScreen(
      args: args,
    );
  },
),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.homeDashboardScreen,
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const HomeDashboardScreen(),
                transitionDuration: const Duration(milliseconds: 280),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                        ),
                        child: child,
                      );
                    },
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.membershipScreen,
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const MembershipScreen(),
                transitionDuration: const Duration(milliseconds: 280),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                        ),
                        child: child,
                      );
                    },
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.scheduleScreen,
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const ScheduleScreen(),
                transitionDuration: const Duration(milliseconds: 280),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                        ),
                        child: child,
                      );
                    },
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.memberCardScreen,
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const MemberCardScreen(),
                transitionDuration: const Duration(milliseconds: 280),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                        ),
                        child: child,
                      );
                    },
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profileScreen,
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const ProfileScreen(),
                transitionDuration: const Duration(milliseconds: 280),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                        ),
                        child: child,
                      );
                    },
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
