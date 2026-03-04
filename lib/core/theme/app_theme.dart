import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// AppTheme — The master theme configuration for Spark.
///
/// WHAT IS ThemeData?
/// ThemeData is Flutter's centralized styling system. When you set it
/// on MaterialApp, EVERY widget in the app automatically inherits these
/// styles. Instead of styling each button, card, and input individually,
/// you define them once here.
///
/// HOW IT WORKS:
/// MaterialApp(theme: AppTheme.darkTheme)
///   → Every ElevatedButton uses your button style
///   → Every Text uses your font
///   → Every Scaffold uses your background color
///   → Every InputField uses your input decoration
///
/// You can still override per-widget, but the theme is the DEFAULT.
class AppTheme {
  AppTheme._();

  /// The main dark theme for Spark.
  ///
  /// FLUTTER CONCEPT: [ThemeData]
  /// This is a massive object with 50+ properties. Each property
  /// controls the default look of a specific widget type.
  /// We customize the ones we need, Flutter handles the rest.
  static ThemeData darkTheme = ThemeData(
    // ----------------------------------------------------------
    // 🌑 BASE: Tell Flutter this is a dark theme
    // ----------------------------------------------------------
    /// [brightness] tells Flutter "this is a dark app"
    /// It affects default text colors, icon colors, etc.
    /// Brightness.dark = white text on dark backgrounds (auto)
    brightness: Brightness.dark,

    /// [scaffoldBackgroundColor] — Background of every screen.
    /// Scaffold is the base widget for every page. Setting this
    /// here means every screen starts with this dark navy color.
    /// We'll add the gradient on top of this in individual screens.
    scaffoldBackgroundColor: AppColors.backgroundDark,

    /// [colorScheme] — Flutter's modern color system.
    /// This replaces the old primaryColor, accentColor, etc.
    /// Widgets like FloatingActionButton, Switch, Slider
    /// automatically pick colors from this scheme.
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary, // Main brand color
      secondary: AppColors.secondary, // Accent/coral color
      surface: AppColors.surfaceDark, // Card/surface backgrounds
      error: AppColors.error, // Error states
      onPrimary: AppColors.textPrimary, // Text ON primary color
      onSecondary: AppColors.textPrimary, // Text ON secondary color
      onSurface: AppColors.textPrimary, // Text ON surfaces
      onError: AppColors.textPrimary, // Text ON error color
    ),

    // ----------------------------------------------------------
    // 🔤 TYPOGRAPHY: Default font for the entire app
    // ----------------------------------------------------------
    /// [textTheme] — Default text styles for the app.
    /// GoogleFonts.interTextTheme() sets Inter as the base font
    /// for ALL text widgets that don't specify a font.
    ///
    /// .apply() lets us override colors across ALL text styles at once.
    /// This is more efficient than setting color on each style individually.
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
      bodyColor: AppColors.textSecondary,
      displayColor: AppColors.textPrimary,
    ),

    // ----------------------------------------------------------
    // 🔘 BUTTON STYLES
    // ----------------------------------------------------------

    /// [ElevatedButton] — Primary action buttons ("Surprise Me", "Save")
    /// These are solid buttons with our primary gradient look.
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        /// Button background color
        backgroundColor: AppColors.primary,

        /// Text/icon color on the button
        foregroundColor: AppColors.textPrimary,

        /// Remove default shadow (glass style = flat)
        elevation: 0,

        /// Rounded pill shape
        /// StadiumBorder = fully rounded ends (like a pill/capsule)
        shape: const StadiumBorder(),

        /// Internal padding — makes button comfortable to tap
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),

        /// Text style for button label
        textStyle: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
        ),
      ),
    ),

    /// [OutlinedButton] — Secondary action buttons ("Skip", "Cancel")
    /// These have a transparent background with a visible border.
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.glassBorder, width: 1.5),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    ),

    /// [TextButton] — Minimal buttons ("Forgot password?", links)
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.primary),
    ),

    // ----------------------------------------------------------
    // 📝 INPUT FIELDS
    // ----------------------------------------------------------

    /// [InputDecorationTheme] — Default look for all TextFields.
    /// This makes every text input field look glassmorphic
    /// with rounded borders and consistent styling.
    inputDecorationTheme: InputDecorationTheme(
      /// Fill the input with a glass-like background
      filled: true,
      fillColor: AppColors.glassFill,

      /// Hint text style (placeholder)
      hintStyle: GoogleFonts.inter(color: AppColors.textHint, fontSize: 14),

      /// Default border (when not focused/tapped)
      /// OutlineInputBorder = has a visible border line
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.glassBorder, width: 1),
      ),

      /// Focused border (when user taps the field)
      /// Changes to primary color to show "I'm active"
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),

      /// Error border (when validation fails)
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),

      /// Content padding inside the input field
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),

    // ----------------------------------------------------------
    // 🃏 CARD THEME
    // ----------------------------------------------------------
    /// Cards in Spark use the glass surface color with no elevation
    cardTheme: CardThemeData(
      color: AppColors.surfaceDark,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),

    // ----------------------------------------------------------
    // 📱 APP BAR (Top navigation bar)
    // ----------------------------------------------------------
    /// Transparent app bar that blends with the gradient background
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.outfit(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
    ),

    // ----------------------------------------------------------
    // ⚙️ MISC
    // ----------------------------------------------------------
    /// Remove the debug banner in top-right corner
    /// (We'll also set this on MaterialApp, but good to have here)

    /// Divider styling
    dividerTheme: const DividerThemeData(
      color: AppColors.glassBorder,
      thickness: 1,
    ),

    /// Icon default color
    iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 24),
  );
}
