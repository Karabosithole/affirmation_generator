import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import '../models/affirmation.dart';
import '../data/affirmation_data.dart';
import '../widgets/animated_affirmation_card.dart';
import '../widgets/category_selector.dart';
import '../widgets/particle_background.dart';
import '../widgets/meditation_timer.dart';
import '../widgets/mood_tracker.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;

  List<String> _selectedCategories = [];
  List<Affirmation> _filteredAffirmations = [];
  Affirmation? _currentAffirmation;
  int _dailyCount = 0;
  int _streak = 0;
  bool _isDarkMode = false;
  bool _enableAnimations = true;
  bool _enableHaptics = true;
  bool _isGenerating = false;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadAffirmations();
    _fadeController.forward();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _slideController.forward();
    _pulseController.repeat(reverse: true);
  }

  void _loadAffirmations() {
    setState(() {
      _filteredAffirmations = AffirmationData.affirmations;
      if (_filteredAffirmations.isNotEmpty) {
        _currentAffirmation = _filteredAffirmations.first;
      }
    });
  }

  void _filterAffirmations() {
    setState(() {
      if (_selectedCategories.isEmpty) {
        _filteredAffirmations = AffirmationData.affirmations;
      } else {
        _filteredAffirmations = AffirmationData.affirmations
            .where((affirmation) => _selectedCategories.contains(affirmation.category))
            .toList();
      }
    });
  }

  void _generateAffirmation() async {
    if (_isGenerating) return;
    
    setState(() {
      _isGenerating = true;
    });

    if (_enableHaptics) {
      HapticFeedback.lightImpact();
    }

    // Animate out current affirmation
    await _fadeController.reverse();
    
    // Generate new affirmation
    if (_filteredAffirmations.isNotEmpty) {
      final random = Random();
      final newAffirmation = _filteredAffirmations[random.nextInt(_filteredAffirmations.length)];
      
      setState(() {
        _currentAffirmation = newAffirmation;
        _dailyCount++;
      });
    }

    // Animate in new affirmation
    await _fadeController.forward();
    
    setState(() {
      _isGenerating = false;
    });

    if (_enableHaptics) {
      HapticFeedback.mediumImpact();
    }
  }

  void _onCategorySelectionChanged(List<String> selectedCategories) {
    setState(() {
      _selectedCategories = selectedCategories;
    });
    _filterAffirmations();
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    if (_enableHaptics) {
      HapticFeedback.selectionClick();
    }
  }

  void _toggleAnimations() {
    setState(() {
      _enableAnimations = !_enableAnimations;
    });
    if (_enableHaptics) {
      HapticFeedback.selectionClick();
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.grey[50],
        appBar: AppBar(
          title: const Text('✨ Affirmation Generator'),
          backgroundColor: _isDarkMode ? Colors.grey[800] : Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: _toggleDarkMode,
            ),
            IconButton(
              icon: Icon(_enableAnimations ? Icons.animation : Icons.pause),
              onPressed: _toggleAnimations,
            ),
          ],
        ),
        body: ParticleBackground(
          enableAnimations: _enableAnimations,
          particleColor: _isDarkMode ? Colors.white : Colors.blue[100]!,
          child: SafeArea(
            child: Column(
              children: [
                // Stats Row
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatCard('Today', _dailyCount.toString(), Icons.today, Colors.blue),
                      _buildStatCard('Streak', _streak.toString(), Icons.local_fire_department, Colors.orange),
                      _buildStatCard('Total', '${_dailyCount + 42}', Icons.star, Colors.purple),
                    ],
                  ),
                ),
                
                // Tab Navigation
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: _isDarkMode ? Colors.grey[800] : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      _buildTabButton(0, 'Affirmations', Icons.auto_awesome),
                      _buildTabButton(1, 'Meditation', Icons.self_improvement),
                      _buildTabButton(2, 'Mood', Icons.mood),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Tab Content
                Expanded(
                  child: IndexedStack(
                    index: _currentTabIndex,
                    children: [
                      // Affirmations Tab
                      Column(
                        children: [
                          // Category Selector
                          CategorySelector(
                            categories: AffirmationData.categories,
                            selectedCategories: _selectedCategories,
                            onSelectionChanged: _onCategorySelectionChanged,
                            enableAnimations: _enableAnimations,
                          ),
                          
                          // Main Affirmation Display
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: SlideTransition(
                                position: _slideAnimation,
                                child: FadeTransition(
                                  opacity: _fadeAnimation,
                                  child: _currentAffirmation != null
                                      ? AnimatedAffirmationCard(
                                          affirmation: _currentAffirmation!,
                                          onTap: _generateAffirmation,
                                          isSelected: true,
                                          enableAnimations: _enableAnimations,
                                        )
                                      : Container(
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
                                          child: const Center(
                                            child: Text(
                                              'Tap to generate your first affirmation!',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          
                          // Action Buttons
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildActionButton(
                                  'Generate',
                                  Icons.auto_awesome,
                                  _generateAffirmation,
                                  Colors.blue,
                                  isLoading: _isGenerating,
                                ),
                                _buildActionButton(
                                  'Share',
                                  Icons.share,
                                  () {
                                    if (_currentAffirmation != null) {
                                      // TODO: Implement sharing
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Sharing feature coming soon!')),
                                      );
                                    }
                                  },
                                  Colors.green,
                                ),
                                _buildActionButton(
                                  'Favorite',
                                  Icons.favorite,
                                  () {
                                    // TODO: Implement favorites
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Favorites feature coming soon!')),
                                    );
                                  },
                                  Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      // Meditation Tab
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: MeditationTimer(
                          enableAnimations: _enableAnimations,
                          enableHaptics: _enableHaptics,
                        ),
                      ),
                      
                      // Mood Tracker Tab
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: SingleChildScrollView(
                          child: MoodTracker(
                            enableAnimations: _enableAnimations,
                            enableHaptics: _enableHaptics,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(int index, String label, IconData icon) {
    final isSelected = _currentTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentTabIndex = index;
          });
          if (_enableHaptics) {
            HapticFeedback.selectionClick();
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected 
                ? (_isDarkMode ? Colors.blue[700] : Colors.blue[100])
                : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected 
                    ? (_isDarkMode ? Colors.white : Colors.blue[800])
                    : (_isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected 
                      ? (_isDarkMode ? Colors.white : Colors.blue[800])
                      : (_isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    VoidCallback onPressed,
    Color color, {
    bool isLoading = false,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 4,
        ),
      ),
    );
  }
}
