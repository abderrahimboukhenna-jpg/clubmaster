import 'package:clubmaster/core/theme_notifier.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './widgets/custom_error_widget.dart';
import 'core/app_export.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── Preload font — fixes lag on first theme toggle ──
  await GoogleFonts.pendingFonts([GoogleFonts.plusJakartaSans()]);

  // ── Load saved theme before runApp ──
  final themeNotifier = ThemeNotifier();
  await themeNotifier.init();

  // 🚨 CRITICAL: Custom error handling - DO NOT REMOVE
  bool hasShownError = false;
  ErrorWidget.builder = (FlutterErrorDetails details) {
    if (!hasShownError) {
      hasShownError = true;
      Future.delayed(const Duration(seconds: 5), () {
        hasShownError = false;
      });
      return CustomErrorWidget(errorDetails: details);
    }
    return const SizedBox.shrink();
  };

  // 🚨 CRITICAL: Device orientation lock - DO NOT REMOVE
  await Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  ]);

  GoRouter.optionURLReflectsImperativeAPIs = true;

  runApp(
    ChangeNotifierProvider.value(
      value: themeNotifier,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        // ── Selector: rebuild MyApp ONLY when themeMode changes ──
        return Selector<ThemeNotifier, ThemeMode>(
          selector: (_, n) => n.themeMode,
          builder: (context, themeMode, _) {
            return MaterialApp.router(
              title: 'ClubMaster',
              // ── Static finals — never rebuilt ──
              theme:     AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              // ── Smooth 300ms theme transition ──
              themeAnimationDuration: const Duration(milliseconds: 300),
              themeAnimationCurve:    Curves.easeInOut,
              // 🚨 CRITICAL: NEVER REMOVE OR MODIFY
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: TextScaler.linear(1.0)),
                  child: child!,
                );
              },
              // 🚨 END CRITICAL SECTION
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter,
            );
          },
        );
      },
    );
  }
}