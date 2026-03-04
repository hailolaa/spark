import 'dart:ui';

class AppColors {
  AppColors._();

  /// Deep navy — top of gradient
  static const Color backgroundDark = Color(0xFF0A0E21);

  /// Deep purple — bottom of gradient
  static const Color backgroundMedium = Color(0xFF1A1A2E);

  /// Slightly lighter — for cards/containers on top of background
  static const Color surfaceDark = Color(0xFF16213E);

  // 💜 ACCENT COLORS (Buttons, highlights, important elements)
  // ============================================================

  /// Electric purple-blue — primary action color (buttons, links)
  /// This is the "Spark" brand color
  static const Color primary = Color(0xFF6C63FF);

  /// Lighter version — for hover states, gradients
  static const Color primaryLight = Color(0xFF8B83FF);

  /// Warm coral — secondary accent (notifications, badges, alerts)
  static const Color secondary = Color(0xFFFF6584);

  /// Teal/cyan — success states, completed items
  static const Color accent = Color(0xFF00D2FF);

  // ============================================================
  // 📝 TEXT COLORS
  // ============================================================

  /// Pure white — headings, important text
  static const Color textPrimary = Color(0xFFFFFFFF);

  /// Light grey — body text, descriptions
  static const Color textSecondary = Color(0xFFB0B0C3);

  /// Dimmed grey — hints, placeholders, disabled text
  static const Color textHint = Color(0xFF6C6C80);

  // ============================================================
  // 🪟 GLASSMORPHISM COLORS
  // ============================================================
  // These are semi-transparent whites used for the frosted glass effect

  /// Glass panel fill (white at 10% opacity)
  static const Color glassFill = Color(0x1AFFFFFF);

  /// Glass border (white at 20% opacity) — creates the subtle edge
  static const Color glassBorder = Color(0x33FFFFFF);

  /// Glass highlight (white at 5% opacity) — inner glow effect
  static const Color glassHighlight = Color(0x0DFFFFFF);
  // ============================================================
  // 🔴🟢 STATUS COLORS
  // ============================================================

  static const Color success = Color(0xFF00E676);
  static const Color warning = Color(0xFFFFAB40);
  static const Color error = Color(0xFFFF5252);
  static const Color info = Color(0xFF448AFF);
  // ============================================================
  // 🎭 MOOD COLORS (Used in mood selection)
  // ============================================================

  /// 😴 Lazy — soft purple
  static const Color moodLazy = Color(0xFF9C88FF);

  /// 😕 Stressed — warm orange
  static const Color moodStressed = Color(0xFFFF9F43);

  /// 😊 Happy — bright yellow
  static const Color moodHappy = Color(0xFFFECA57);

  /// 🤯 Overwhelmed — deep red
  static const Color moodOverwhelmed = Color(0xFFFF6B6B);

  /// 😎 Motivated — electric green
  static const Color moodMotivated = Color(0xFF00D2FF);
  // ============================================================
  // 🏷️ CATEGORY COLORS (One per activity category)
  // ============================================================

  static const Color categoryFitness = Color(0xFFFF6B6B);
  static const Color categoryLearning = Color(0xFF48DBFB);
  static const Color categoryBrainGames = Color(0xFFFF9FF3);
  static const Color categoryMindfulness = Color(0xFF55E6C1);
  static const Color categoryCreative = Color(0xFFFECA57);
  static const Color categorySocial = Color(0xFFFF9F43);
  static const Color categoryHome = Color(0xFF786FA6);
  static const Color categoryTech = Color(0xFF6C63FF);
  static const Color categoryProductivity = Color(0xFF00D2FF);
}
