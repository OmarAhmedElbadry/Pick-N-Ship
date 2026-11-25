import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Shared monochrome visual language inspired by the supplied editorial UI.
class AppTheme {
  static const Color primaryColor = Color(0xFF303134);
  static const Color secondaryColor = Color(0xFF66686C);
  static const Color accentOrange = Color(0xFF45464A);
  static const Color successGreen = Color(0xFF59665D);
  static const Color warningAmber = Color(0xFF777064);
  static const Color errorRed = Color(0xFF8B5555);
  static const Color bgLight = Color(0xFFF2F3F3);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF292A2D);
  static const Color textMuted = Color(0xFF85878A);
  static const Color hairline = Color(0xFFE4E5E6);

  static const Map<String, Color> categoryColors = {
    'grocery': secondaryColor,
    'fish': secondaryColor,
    'meat': secondaryColor,
    'vegetables': secondaryColor,
    'pharmacy': secondaryColor,
    'parcel_pickup': secondaryColor,
  };

  static ThemeData get lightTheme {
    final textTheme = GoogleFonts.interTextTheme().copyWith(
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        height: 1.12,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
        color: textDark,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 25,
        height: 1.18,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        color: textDark,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 19,
        fontWeight: FontWeight.w700,
        color: textDark,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      bodyLarge: GoogleFonts.inter(fontSize: 16, height: 1.45, color: textDark),
      bodyMedium: GoogleFonts.inter(fontSize: 14, height: 1.4, color: textDark),
      bodySmall: GoogleFonts.inter(fontSize: 12, height: 1.4, color: textMuted),
      labelLarge: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: bgLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: cardWhite,
        error: errorRed,
      ),
      textTheme: textTheme,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: ZoomPageTransitionsBuilder(),
          TargetPlatform.linux: ZoomPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: bgLight,
        foregroundColor: textDark,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: textDark,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardWhite,
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: const BorderSide(color: hairline),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFB8B9BA),
          disabledForegroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(48, 54),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          shape: const StadiumBorder(),
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          minimumSize: const Size(48, 50),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          side: const BorderSide(color: hairline),
          shape: const StadiumBorder(),
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardWhite,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 17,
        ),
        hintStyle: GoogleFonts.inter(color: textMuted, fontSize: 14),
        labelStyle: GoogleFonts.inter(color: textMuted, fontSize: 14),
        prefixIconColor: textMuted,
        suffixIconColor: textMuted,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: hairline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: hairline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: errorRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: errorRed, width: 1.5),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 74,
        backgroundColor: cardWhite,
        surfaceTintColor: Colors.transparent,
        indicatorColor: const Color(0xFFE9EAEB),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => GoogleFonts.inter(
            fontSize: 11,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
            color: states.contains(WidgetState.selected) ? textDark : textMuted,
          ),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: cardWhite,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: cardWhite,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textDark,
        ),
        contentTextStyle: GoogleFonts.inter(fontSize: 14, color: textMuted),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: primaryColor,
        contentTextStyle: GoogleFonts.inter(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      dividerColor: hairline,
    );
  }
}
