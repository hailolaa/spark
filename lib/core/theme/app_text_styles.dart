import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// AppTextStyles defines every text style used in Spark.
///
/// FLUTTER CONCEPT: [TextStyle] controls how text looks —
/// font family, size, weight, color, spacing, etc.
///
/// WHY two fonts?
/// - "Outfit" → Bold, geometric → used for HEADINGS (grabs attention)
/// - "Inter" → Clean, readable → used for BODY TEXT (easy to read)
/// Using two complementary fonts is a pro design technique called
/// "font pairing" — it creates visual hierarchy.
///
/// HOW google_fonts WORKS:
/// Instead of downloading .ttf files and adding them to assets,
/// [GoogleFonts.outfit()] fetches the font from Google's CDN
/// on first use and caches it. It returns a [TextStyle] with
/// that font family applied. You can then override properties
/// like fontSize, fontWeight, color, etc.
class AppTextStyles {
  AppTextStyles._();

  // ============================================================
  // 📰 HEADINGS (Outfit font — bold and eye-catching)
  // ============================================================

  /// Biggest heading — splash screen title, major section headers
  /// fontSize 32 is large enough to be a hero title
  /// FontWeight.w700 = Bold
  /// letterSpacing: 1.2 = slight spacing between letters for elegance
  static TextStyle heading1 = GoogleFonts.outfit(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 1.2,
  );

  /// Section headings — screen titles, card headers
  static TextStyle heading2 = GoogleFonts.outfit(
    fontSize: 24,
    fontWeight: FontWeight.w600, // w600 = Semi-bold
    color: AppColors.textPrimary,
    letterSpacing: 0.8,
  );

  /// Sub-headings — subsection titles, dialog headers
  static TextStyle heading3 = GoogleFonts.outfit(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  // ============================================================
  // 📝 BODY TEXT (Inter font — clean and readable)
  // ============================================================

  /// Main body text — descriptions, paragraphs
  /// fontSize 16 is the sweet spot for mobile readability
  /// height: 1.5 = line height (150%) — gives breathing room between lines
  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400, // w400 = Regular/Normal
    color: AppColors.textSecondary,
    height: 1.5,
  );

  /// Secondary body text — smaller descriptions
  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  /// Small text — timestamps, labels, metadata
  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
    height: 1.3,
  );

  // ============================================================
  // 🔘 BUTTON TEXT
  // ============================================================

  /// Primary button text — "Surprise Me", "Save", "Continue"
  /// FontWeight.w600 makes buttons feel strong/actionable
  static TextStyle buttonLarge = GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 1.0,
  );

  /// Smaller button text — "Skip", "Cancel", secondary actions
  static TextStyle buttonSmall = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500, // w500 = Medium
    color: AppColors.textPrimary,
  );

  // ============================================================
  // 🏷️ SPECIAL STYLES
  // ============================================================

  /// Chip/tag text — category labels, mood labels, badges
  static TextStyle chip = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  /// Number/stat display — XP points, streak counts, levels
  /// fontSize 40 makes numbers feel impactful
  static TextStyle statNumber = GoogleFonts.outfit(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    letterSpacing: 1.5,
  );

  /// Subtitle/tagline — "Your Personalized Activity Generator"
  static TextStyle subtitle = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: 2.0,
    // FLUTTER CONCEPT: letterSpacing in subtitles makes
    // text feel spaced out and elegant — common in premium apps
  );
}
