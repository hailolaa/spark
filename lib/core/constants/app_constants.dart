class AppConstants {
  AppConstants._();

  //Durations

  /// How long the splash screen shows before navigating
  static const Duration splashDuration = Duration(milliseconds: 3000);

  /// Default animation duration for transitions
  static const Duration animationDuration = Duration(milliseconds: 600);

  /// Quick animation for micro-interactions (button press, etc.)
  static const Duration quickAnimation = Duration(milliseconds: 300);

  // SHARED PREFERENCES KEYS

  /// Whether the user has completed onboarding
  static const String keyOnboardingComplete = 'onboarding_complete';

  /// User's selected interests (stored as JSON string)
  static const String keyUserInterests = 'user_interests';

  /// User's budget preference
  static const String keyBudgetLevel = 'budget_level';

  /// User's energy level preference
  static const String keyEnergyLevel = 'energy_level';

  /// User's available time preference
  static const String keyAvailableTime = 'available_time';

  /// User's personality type
  static const String keyPersonalityType = 'personality_type';

  /// User's indoor/outdoor preference
  static const String keyLocationPreference = 'location_preference';

  /// User's role (user or admin)
  static const String keyUserRole = 'user_role';

  /// Whether user is logged in
  static const String keyIsLoggedIn = 'is_logged_in';

  /// User's display name
  static const String keyUserName = 'user_name';

  /// User's email
  static const String keyUserEmail = 'user_email';

  // ROUTE NAMES

  static const String routeSplash = '/';
  static const String routeLogin = '/login';
  static const String routeRegister = '/register';
  static const String routeOnboarding = '/onboarding';
  static const String routeHome = '/home';
  static const String routeActivityDetail = '/activity-detail';
  static const String routeHistory = '/history';
  static const String routeProfile = '/profile';
  static const String routeAdminDashboard = '/admin/dashboard';
  static const String routeAdminActivities = '/admin/activities';
  static const String routeAdminUsers = '/admin/users';

  // ROLE VALUES

  static const String roleUser = 'user';
  static const String roleAdmin = 'admin';
}
