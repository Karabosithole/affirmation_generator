import '../models/affirmation.dart';

class AffirmationData {
  static final List<AffirmationCategory> categories = [
    AffirmationCategory(
      name: 'Motivation',
      emoji: '🚀',
      color: '0xFF4CAF50',
      description: 'Boost your drive and determination',
    ),
    AffirmationCategory(
      name: 'Confidence',
      emoji: '💪',
      color: '0xFF2196F3',
      description: 'Build self-belief and courage',
    ),
    AffirmationCategory(
      name: 'Success',
      emoji: '⭐',
      color: '0xFFFF9800',
      description: 'Achieve your goals and dreams',
    ),
    AffirmationCategory(
      name: 'Peace',
      emoji: '🕊️',
      color: '0xFF9C27B0',
      description: 'Find inner calm and tranquility',
    ),
    AffirmationCategory(
      name: 'Love',
      emoji: '❤️',
      color: '0xFFE91E63',
      description: 'Embrace self-love and relationships',
    ),
    AffirmationCategory(
      name: 'Growth',
      emoji: '🌱',
      color: '0xFF4CAF50',
      description: 'Personal development and learning',
    ),
    AffirmationCategory(
      name: 'Gratitude',
      emoji: '🙏',
      color: '0xFFFF5722',
      description: 'Appreciate life\'s blessings',
    ),
    AffirmationCategory(
      name: 'Strength',
      emoji: '💎',
      color: '0xFF607D8B',
      description: 'Overcome challenges and adversity',
    ),
  ];

  static final List<Affirmation> affirmations = [
    // Motivation
    Affirmation(
      text: "I am unstoppable and capable of achieving anything I set my mind to.",
      category: "Motivation",
      emoji: "🚀",
      intensity: 5,
      tags: ["power", "achievement", "determination"],
      color: "0xFF4CAF50",
    ),
    Affirmation(
      text: "Every challenge I face makes me stronger and more resilient.",
      category: "Motivation",
      emoji: "💪",
      intensity: 4,
      tags: ["resilience", "growth", "challenge"],
      color: "0xFF4CAF50",
    ),
    Affirmation(
      text: "I am the architect of my own success story.",
      category: "Motivation",
      emoji: "🏗️",
      intensity: 5,
      tags: ["success", "control", "future"],
      color: "0xFF4CAF50",
    ),
    Affirmation(
      text: "My potential is limitless and I choose to embrace it fully.",
      category: "Motivation",
      emoji: "🌟",
      intensity: 4,
      tags: ["potential", "limitless", "embrace"],
      color: "0xFF4CAF50",
    ),

    // Confidence
    Affirmation(
      text: "I am confident in my abilities and trust my intuition completely.",
      category: "Confidence",
      emoji: "💪",
      intensity: 4,
      tags: ["confidence", "trust", "intuition"],
      color: "0xFF2196F3",
    ),
    Affirmation(
      text: "I radiate self-assurance and attract positive opportunities.",
      category: "Confidence",
      emoji: "✨",
      intensity: 5,
      tags: ["self-assurance", "attraction", "opportunities"],
      color: "0xFF2196F3",
    ),
    Affirmation(
      text: "I am worthy of all the good things that come my way.",
      category: "Confidence",
      emoji: "👑",
      intensity: 4,
      tags: ["worthiness", "goodness", "deserving"],
      color: "0xFF2196F3",
    ),
    Affirmation(
      text: "My voice matters and I express myself with clarity and conviction.",
      category: "Confidence",
      emoji: "🗣️",
      intensity: 3,
      tags: ["voice", "expression", "conviction"],
      color: "0xFF2196F3",
    ),

    // Success
    Affirmation(
      text: "I am a magnet for success and prosperity in all areas of my life.",
      category: "Success",
      emoji: "⭐",
      intensity: 5,
      tags: ["success", "prosperity", "magnet"],
      color: "0xFFFF9800",
    ),
    Affirmation(
      text: "Every day I take steps closer to achieving my biggest dreams.",
      category: "Success",
      emoji: "🎯",
      intensity: 4,
      tags: ["progress", "dreams", "action"],
      color: "0xFFFF9800",
    ),
    Affirmation(
      text: "I am surrounded by abundance and opportunities for growth.",
      category: "Success",
      emoji: "💰",
      intensity: 4,
      tags: ["abundance", "opportunities", "growth"],
      color: "0xFFFF9800",
    ),
    Affirmation(
      text: "My hard work and dedication are paying off in amazing ways.",
      category: "Success",
      emoji: "🏆",
      intensity: 5,
      tags: ["hard work", "dedication", "results"],
      color: "0xFFFF9800",
    ),

    // Peace
    Affirmation(
      text: "I am at peace with who I am and where I am in life.",
      category: "Peace",
      emoji: "🕊️",
      intensity: 3,
      tags: ["peace", "acceptance", "present"],
      color: "0xFF9C27B0",
    ),
    Affirmation(
      text: "I release all worry and embrace the calm within me.",
      category: "Peace",
      emoji: "🧘",
      intensity: 4,
      tags: ["release", "worry", "calm"],
      color: "0xFF9C27B0",
    ),
    Affirmation(
      text: "My mind is clear, my heart is open, and my soul is at rest.",
      category: "Peace",
      emoji: "🌸",
      intensity: 5,
      tags: ["clarity", "openness", "rest"],
      color: "0xFF9C27B0",
    ),
    Affirmation(
      text: "I choose peace over chaos and love over fear.",
      category: "Peace",
      emoji: "💜",
      intensity: 4,
      tags: ["choice", "love", "fear"],
      color: "0xFF9C27B0",
    ),

    // Love
    Affirmation(
      text: "I am deeply loved and I love myself unconditionally.",
      category: "Love",
      emoji: "❤️",
      intensity: 5,
      tags: ["love", "self-love", "unconditional"],
      color: "0xFFE91E63",
    ),
    Affirmation(
      text: "My heart is open to giving and receiving love freely.",
      category: "Love",
      emoji: "💕",
      intensity: 4,
      tags: ["open heart", "giving", "receiving"],
      color: "0xFFE91E63",
    ),
    Affirmation(
      text: "I attract loving relationships that honor and respect me.",
      category: "Love",
      emoji: "💖",
      intensity: 4,
      tags: ["attraction", "relationships", "respect"],
      color: "0xFFE91E63",
    ),
    Affirmation(
      text: "I am worthy of the deepest, most meaningful love.",
      category: "Love",
      emoji: "💝",
      intensity: 5,
      tags: ["worthy", "meaningful", "deep"],
      color: "0xFFE91E63",
    ),

    // Growth
    Affirmation(
      text: "I am constantly growing and evolving into my best self.",
      category: "Growth",
      emoji: "🌱",
      intensity: 4,
      tags: ["growth", "evolution", "best self"],
      color: "0xFF4CAF50",
    ),
    Affirmation(
      text: "Every experience teaches me something valuable about myself.",
      category: "Growth",
      emoji: "📚",
      intensity: 3,
      tags: ["learning", "experience", "value"],
      color: "0xFF4CAF50",
    ),
    Affirmation(
      text: "I embrace change as an opportunity for personal transformation.",
      category: "Growth",
      emoji: "🦋",
      intensity: 4,
      tags: ["change", "transformation", "opportunity"],
      color: "0xFF4CAF50",
    ),
    Affirmation(
      text: "My mistakes are stepping stones to wisdom and growth.",
      category: "Growth",
      emoji: "🪨",
      intensity: 3,
      tags: ["mistakes", "wisdom", "stepping stones"],
      color: "0xFF4CAF50",
    ),

    // Gratitude
    Affirmation(
      text: "I am grateful for all the blessings in my life, big and small.",
      category: "Gratitude",
      emoji: "🙏",
      intensity: 4,
      tags: ["grateful", "blessings", "appreciation"],
      color: "0xFFFF5722",
    ),
    Affirmation(
      text: "Every day I find something beautiful to appreciate and celebrate.",
      category: "Gratitude",
      emoji: "🌅",
      intensity: 3,
      tags: ["beauty", "appreciation", "celebration"],
      color: "0xFFFF5722",
    ),
    Affirmation(
      text: "I am thankful for the lessons learned and the growth they bring.",
      category: "Gratitude",
      emoji: "🎁",
      intensity: 4,
      tags: ["thankful", "lessons", "growth"],
      color: "0xFFFF5722",
    ),
    Affirmation(
      text: "My heart overflows with gratitude for this beautiful life.",
      category: "Gratitude",
      emoji: "💝",
      intensity: 5,
      tags: ["overflowing", "gratitude", "beautiful life"],
      color: "0xFFFF5722",
    ),

    // Strength
    Affirmation(
      text: "I am stronger than any obstacle that comes my way.",
      category: "Strength",
      emoji: "💎",
      intensity: 5,
      tags: ["strength", "obstacles", "overcome"],
      color: "0xFF607D8B",
    ),
    Affirmation(
      text: "My inner strength grows with every challenge I face.",
      category: "Strength",
      emoji: "⚡",
      intensity: 4,
      tags: ["inner strength", "challenges", "growth"],
      color: "0xFF607D8B",
    ),
    Affirmation(
      text: "I have the courage to stand up for what I believe in.",
      category: "Strength",
      emoji: "🛡️",
      intensity: 4,
      tags: ["courage", "beliefs", "standing up"],
      color: "0xFF607D8B",
    ),
    Affirmation(
      text: "I am unbreakable, resilient, and capable of handling anything.",
      category: "Strength",
      emoji: "🏔️",
      intensity: 5,
      tags: ["unbreakable", "resilient", "capable"],
      color: "0xFF607D8B",
    ),
  ];

  static List<Affirmation> getAffirmationsByCategory(String category) {
    return affirmations.where((affirmation) => affirmation.category == category).toList();
  }

  static List<Affirmation> getAffirmationsByIntensity(int intensity) {
    return affirmations.where((affirmation) => affirmation.intensity == intensity).toList();
  }

  static List<Affirmation> getRandomAffirmations(int count) {
    affirmations.shuffle();
    return affirmations.take(count).toList();
  }
}
