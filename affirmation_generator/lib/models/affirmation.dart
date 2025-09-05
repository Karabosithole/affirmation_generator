class Affirmation {
  final String text;
  final String category;
  final String emoji;
  final int intensity; // 1-5 scale
  final List<String> tags;
  final String color;

  Affirmation({
    required this.text,
    required this.category,
    required this.emoji,
    required this.intensity,
    required this.tags,
    required this.color,
  });
}

class AffirmationCategory {
  final String name;
  final String emoji;
  final String color;
  final String description;

  AffirmationCategory({
    required this.name,
    required this.emoji,
    required this.color,
    required this.description,
  });
}

class UserPreferences {
  final List<String> favoriteCategories;
  final int preferredIntensity;
  final bool enableAnimations;
  final bool enableSounds;
  final bool enableHaptics;
  final String theme;
  final int dailyGoal;
  final int currentStreak;
  final int totalAffirmations;

  UserPreferences({
    this.favoriteCategories = const [],
    this.preferredIntensity = 3,
    this.enableAnimations = true,
    this.enableSounds = true,
    this.enableHaptics = true,
    this.theme = 'light',
    this.dailyGoal = 5,
    this.currentStreak = 0,
    this.totalAffirmations = 0,
  });

  UserPreferences copyWith({
    List<String>? favoriteCategories,
    int? preferredIntensity,
    bool? enableAnimations,
    bool? enableSounds,
    bool? enableHaptics,
    String? theme,
    int? dailyGoal,
    int? currentStreak,
    int? totalAffirmations,
  }) {
    return UserPreferences(
      favoriteCategories: favoriteCategories ?? this.favoriteCategories,
      preferredIntensity: preferredIntensity ?? this.preferredIntensity,
      enableAnimations: enableAnimations ?? this.enableAnimations,
      enableSounds: enableSounds ?? this.enableSounds,
      enableHaptics: enableHaptics ?? this.enableHaptics,
      theme: theme ?? this.theme,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      currentStreak: currentStreak ?? this.currentStreak,
      totalAffirmations: totalAffirmations ?? this.totalAffirmations,
    );
  }
}
