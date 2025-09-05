import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoodTracker extends StatefulWidget {
  final bool enableAnimations;
  final bool enableHaptics;

  const MoodTracker({
    Key? key,
    this.enableAnimations = true,
    this.enableHaptics = true,
  }) : super(key: key);

  @override
  _MoodTrackerState createState() => _MoodTrackerState();
}

class _MoodTrackerState extends State<MoodTracker>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  String? _selectedMood;
  String? _selectedEmotion;
  String _note = '';

  final List<MoodData> _moods = [
    MoodData(emoji: '😊', name: 'Happy', color: Colors.yellow, intensity: 5),
    MoodData(emoji: '😌', name: 'Calm', color: Colors.blue, intensity: 4),
    MoodData(emoji: '😤', name: 'Frustrated', color: Colors.red, intensity: 2),
    MoodData(emoji: '😔', name: 'Sad', color: Colors.purple, intensity: 1),
    MoodData(emoji: '😰', name: 'Anxious', color: Colors.orange, intensity: 2),
    MoodData(emoji: '😴', name: 'Tired', color: Colors.grey, intensity: 3),
    MoodData(emoji: '🤩', name: 'Excited', color: Colors.pink, intensity: 5),
    MoodData(emoji: '😌', name: 'Grateful', color: Colors.green, intensity: 4),
  ];

  final List<String> _emotions = [
    'Confident', 'Motivated', 'Peaceful', 'Loved', 'Stressed',
    'Overwhelmed', 'Hopeful', 'Lonely', 'Proud', 'Worried',
    'Content', 'Angry', 'Joyful', 'Nervous', 'Optimistic'
  ];

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _bounceAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  void _selectMood(String mood) {
    setState(() {
      _selectedMood = mood;
    });
    
    if (widget.enableHaptics) {
      HapticFeedback.selectionClick();
    }
    
    if (widget.enableAnimations) {
      _bounceController.forward().then((_) {
        _bounceController.reverse();
      });
    }
  }

  void _selectEmotion(String emotion) {
    setState(() {
      _selectedEmotion = emotion;
    });
    
    if (widget.enableHaptics) {
      HapticFeedback.selectionClick();
    }
  }

  void _saveMood() {
    if (_selectedMood != null) {
      if (widget.enableHaptics) {
        HapticFeedback.mediumImpact();
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mood saved: $_selectedMood ${_selectedEmotion != null ? '($_selectedEmotion)' : ''}'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Reset form
      setState(() {
        _selectedMood = null;
        _selectedEmotion = null;
        _note = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '😊 Mood Tracker',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // Mood Selection
          const Text(
            'How are you feeling?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _moods.map((mood) {
              final isSelected = _selectedMood == mood.name;
              return GestureDetector(
                onTap: () => _selectMood(mood.name),
                child: AnimatedBuilder(
                  animation: _bounceAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: isSelected && widget.enableAnimations 
                          ? _bounceAnimation.value 
                          : 1.0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? mood.color.withOpacity(0.2)
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected 
                                ? mood.color
                                : Colors.grey[300]!,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              mood.emoji,
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              mood.name,
                              style: TextStyle(
                                fontWeight: isSelected 
                                    ? FontWeight.bold 
                                    : FontWeight.normal,
                                color: isSelected 
                                    ? mood.color 
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 20),
          
          // Emotion Selection
          const Text(
            'What emotion best describes you right now?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _emotions.map((emotion) {
              final isSelected = _selectedEmotion == emotion;
              return GestureDetector(
                onTap: () => _selectEmotion(emotion),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? Colors.blue.withOpacity(0.2)
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: isSelected 
                          ? Colors.blue
                          : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Text(
                    emotion,
                    style: TextStyle(
                      fontWeight: isSelected 
                          ? FontWeight.bold 
                          : FontWeight.normal,
                      color: isSelected 
                          ? Colors.blue 
                          : Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 20),
          
          // Note Input
          const Text(
            'Add a note (optional)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          
          TextField(
            onChanged: (value) => setState(() => _note = value),
            decoration: InputDecoration(
              hintText: 'How was your day? What made you feel this way?',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.all(12),
            ),
            maxLines: 3,
          ),
          
          const SizedBox(height: 20),
          
          // Save Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _selectedMood != null ? _saveMood : null,
              icon: const Icon(Icons.save),
              label: const Text('Save Mood'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MoodData {
  final String emoji;
  final String name;
  final Color color;
  final int intensity;

  MoodData({
    required this.emoji,
    required this.name,
    required this.color,
    required this.intensity,
  });
}
