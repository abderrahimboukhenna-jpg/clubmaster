import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ── Palette ──
  static const Color primary           = Color(0xFF0B5D3B);
  static const Color primaryLight      = Color(0xFF137A4F);
  static const Color primaryContainer  = Color(0xFFDFF5E6);
  static const Color accentContainer   = Color(0xFFEAFAD9);
  static const Color accent            = Color(0xFF69C12F);
  static const Color accentLight       = Color(0xFF8CE04D);
  static const Color success           = Color(0xFF22C55E);
  static const Color successContainer  = Color(0xFFE8F5E9);
  static const Color warning           = Color(0xFFF59E0B);
  static const Color warningContainer  = Color(0xFFFFF8E1);
  static const Color error             = Color(0xFFEF4444);
  static const Color errorContainer    = Color(0xFFFFEBEE);
  static const Color surfaceLight      = Color(0xFFFFFFFF);
  static const Color backgroundLight   = Color(0xFFF8FBF8);
  static const Color surfaceVariantLight = Color(0xFFF1F5F2);
  static const Color surfaceDark       = Color(0xFF1E1E2E);
  static const Color backgroundDark    = Color(0xFF121212);
  static const Color surfaceVariantDark = Color(0xFF2A2A3E);
  static const Color onSurfaceLight    = Color(0xFF1A1A1A);
  static const Color onSurfaceDark     = Color(0xFFE6E6F0);
  static const Color mutedLight        = Color(0xFF647067);
  static const Color mutedDark         = Color(0xFF9A9AB0);

  // ── Cache TextTheme — built ONCE, reused forever ──
  static final TextTheme _baseTextTheme = GoogleFonts.plusJakartaSansTextTheme(
    const TextTheme(
      displayLarge:  TextStyle(fontSize: 57, fontWeight: FontWeight.w700, letterSpacing: -0.25),
      displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w600),
      displaySmall:  TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
      headlineMedium:TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      titleLarge:    TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      titleMedium:   TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.15),
      titleSmall:    TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1),
      bodyLarge:     TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
      bodyMedium:    TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      bodySmall:     TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
      labelLarge:    TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1),
      labelMedium:   TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      labelSmall:    TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5),
    ),
  );

  // ── Dark TextTheme — same font, dark colors applied via colorScheme ──
  static final TextTheme _darkTextTheme = _baseTextTheme.apply(
    bodyColor:    onSurfaceDark,
    displayColor: onSurfaceDark,
  );

  // ── Cache ThemeData — built ONCE each ──
  static final ThemeData lightTheme = _buildLight();
  static final ThemeData darkTheme  = _buildDark();

  static ThemeData _buildLight() => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary:               primary,
      onPrimary:             Colors.white,
      primaryContainer:      primaryContainer,
      onPrimaryContainer:    Color(0xFF001D36),
      secondary:             accent,
      onSecondary:           Colors.white,
      secondaryContainer:    accentContainer,
      onSecondaryContainer:  Color(0xFF001E2C),
      tertiary:              Color(0xFF1B4D1E),
      onTertiary:            Colors.white,
      surface:               surfaceLight,
      onSurface:             onSurfaceLight,
      surfaceContainerHighest: surfaceVariantLight,
      onSurfaceVariant:      Color(0xFF44546F),
      error:                 error,
      onError:               Colors.white,
      errorContainer:        errorContainer,
      outline:               Color(0xFFBCC8E0),
      outlineVariant:        Color(0xFFDDE3EF),
      shadow:                Color(0x141565C0),
      scrim:                 Colors.black,
      inverseSurface:        Color(0xFF1A1A2E),
      onInverseSurface:      Color(0xFFEFF0FF),
      inversePrimary:        Color(0xFF9ECAFF),
    ),
    scaffoldBackgroundColor: backgroundLight,
    textTheme: _baseTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor:        surfaceLight,
      elevation:              0,
      scrolledUnderElevation: 1,
      shadowColor:            Color(0x1A0B5D3B),
      centerTitle:            false,
      iconTheme:              const IconThemeData(color: primary),
      titleTextStyle: GoogleFonts.plusJakartaSans(
        fontSize: 20, fontWeight: FontWeight.w700,
        color: onSurfaceLight, letterSpacing: -0.2,
      ),
    ),
    cardTheme: CardThemeData(
      color:       surfaceLight,
      elevation:   0,
      shape:       RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Color(0x140B5D3B),
      margin:      EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled:         true,
      fillColor:      surfaceVariantLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border:         _border(const Color(0xFFBCC8E0)),
      enabledBorder:  _border(const Color(0xFFBCC8E0)),
      focusedBorder:  _border(primary, width: 2),
      errorBorder:    _border(error),
      focusedErrorBorder: _border(error, width: 2),
      labelStyle:     const TextStyle(color: mutedLight, fontSize: 14, fontWeight: FontWeight.w500),
      floatingLabelStyle: const TextStyle(color: primary, fontSize: 12, fontWeight: FontWeight.w600),
      hintStyle:      TextStyle(color: mutedLight.withAlpha(179), fontSize: 14),
      errorStyle:     const TextStyle(color: error, fontSize: 12),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: 0.5),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: surfaceVariantLight,
      selectedColor:   primaryContainer,
      shape:           RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      labelStyle:      GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600),
      padding:         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),
    dividerTheme: const DividerThemeData(color: Color(0xFFDDE3EF), thickness: 1, space: 1),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFF1A1A2E),
      contentTextStyle: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
    ),
  );

  static ThemeData _buildDark() => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary:               Color(0xFF69C12F),
      onPrimary:             Color(0xFF003258),
      primaryContainer:      Color(0xFF1D4027),
      onPrimaryContainer:    Color(0xFFD1E4FF),
      secondary:             accent,
      onSecondary:           Color(0xFF003544),
      secondaryContainer:    Color(0xFF004D61),
      onSecondaryContainer:  Color(0xFFB3E5FC),
      tertiary:              Color(0xFF4CAF50),
      onTertiary:            Color(0xFF003909),
      surface:               surfaceDark,
      onSurface:             onSurfaceDark,
      surfaceContainerHighest: surfaceVariantDark,
      onSurfaceVariant:      Color(0xFFBCC8E0),
      error:                 Color(0xFFCF6679),
      onError:               Color(0xFF690018),
      errorContainer:        Color(0xFF93000A),
      outline:               Color(0xFF44546F),
      outlineVariant:        Color(0xFF2A3A54),
      shadow:                Colors.black,
      scrim:                 Colors.black,
      inverseSurface:        Color(0xFFE6E6F0),
      onInverseSurface:      Color(0xFF1A1A2E),
      inversePrimary:        primary,
    ),
    scaffoldBackgroundColor: backgroundDark,
    textTheme: _darkTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor:        surfaceDark,
      elevation:              0,
      scrolledUnderElevation: 1,
      shadowColor:            Colors.black38,
      centerTitle:            false,
      iconTheme:              const IconThemeData(color: Color(0xFF9ECAFF)),
      titleTextStyle: GoogleFonts.plusJakartaSans(
        fontSize: 20, fontWeight: FontWeight.w700, color: onSurfaceDark,
      ),
    ),
    cardTheme: CardThemeData(
      color:     surfaceDark,
      elevation: 0,
      shape:     RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin:    EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled:         true,
      fillColor:      surfaceVariantDark,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border:         _border(const Color(0xFF44546F)),
      enabledBorder:  _border(const Color(0xFF44546F)),
      focusedBorder:  _border(const Color(0xFF9ECAFF), width: 2),
      errorBorder:    _border(const Color(0xFFCF6679)),
      focusedErrorBorder: _border(const Color(0xFFCF6679), width: 2),
      labelStyle:     const TextStyle(color: mutedDark, fontSize: 14, fontWeight: FontWeight.w500),
      floatingLabelStyle: const TextStyle(color: Color(0xFF9ECAFF), fontSize: 12, fontWeight: FontWeight.w600),
      hintStyle:      TextStyle(color: mutedDark.withAlpha(179), fontSize: 14),
      errorStyle:     const TextStyle(color: Color(0xFFCF6679), fontSize: 12),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF9ECAFF),
        foregroundColor: const Color(0xFF003258),
        elevation: 0,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: 0.5),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: surfaceVariantDark,
      selectedColor:   const Color(0xFF004880),
      shape:           RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      labelStyle:      GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600, color: onSurfaceDark),
      padding:         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),
    dividerTheme: const DividerThemeData(color: Color(0xFF2A3A54), thickness: 1, space: 1),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFF9ECAFF),
      contentTextStyle: GoogleFonts.plusJakartaSans(color: const Color(0xFF003258), fontSize: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
    ),
  );

  // ── Helper ──
  static OutlineInputBorder _border(Color color, {double width = 1}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: width),
      );
}