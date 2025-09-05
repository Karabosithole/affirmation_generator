import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import '../models/affirmation.dart';
import '../data/affirmation_data.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentScreenIndex = 0;
  String _userName = "Steven";
  String _currentDate = "Today is June 14, 2022";
  
  // Color palette from the design
  static const Color lightBlueGrey = Color(0xFFE8F0F2);
  static const Color dustyRose = Color(0xFFD4A5A5);
  static const Color mediumBlueGrey = Color(0xFF8FA3A8);
  static const Color darkBlueGrey = Color(0xFF5A6B70);
  static const Color lightGrey = Color(0xFFF5F5F5);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      body: SafeArea(
        child: IndexedStack(
          index: _currentScreenIndex,
          children: [
            _buildWelcomeScreen(),
            _buildHomeScreen(),
            _buildPlaylistScreen(),
            _buildArticleScreen(),
            _buildPracticesScreen(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildWelcomeScreen() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFF6B6B).withOpacity(0.8),
            const Color(0xFF4ECDC4).withOpacity(0.8),
            const Color(0xFF45B7D1).withOpacity(0.8),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Daily affirmations.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const Text(
              'Progress Checker.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const Text(
              'Your step forward.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text(
                    'Peace is a click away',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkBlueGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Let\'s get started →',
                    style: TextStyle(
                      fontSize: 16,
                      color: mediumBlueGrey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Have an account already? Log In',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeScreen() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning, $_userName',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: darkBlueGrey,
                    ),
                  ),
                  Text(
                    _currentDate,
                    style: const TextStyle(
                      fontSize: 16,
                      color: mediumBlueGrey,
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: dustyRose,
                child: const Text(
                  'S',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Today\'s Exercise',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: darkBlueGrey,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: dustyRose.withOpacity(0.3),
            ),
            child: const Center(
              child: Text(
                'Positivity',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: darkBlueGrey,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'More for you',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: darkBlueGrey,
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                  fontSize: 16,
                  color: mediumBlueGrey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildExerciseCard('Peaceful'),
                const SizedBox(height: 12),
                _buildExerciseCard('Mindful'),
                const SizedBox(height: 12),
                _buildExerciseCard('Spiritual'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(String title) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: lightBlueGrey,
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: darkBlueGrey,
          ),
        ),
      ),
    );
  }

  Widget _buildPlaylistScreen() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Made for $_userName',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: darkBlueGrey,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: dustyRose.withOpacity(0.3),
            ),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle_fill,
                    color: darkBlueGrey,
                    size: 48,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Positivity',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: darkBlueGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Playlist',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: darkBlueGrey,
                ),
              ),
              Text(
                '4 songs',
                style: TextStyle(
                  fontSize: 16,
                  color: mediumBlueGrey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildSongItem('The Recipe', 'Sir'),
                _buildSongItem('My Mind', 'Yebba'),
                _buildSongItem('Let Go', 'Ark Patrol'),
                _buildSongItem('WAYS', 'Jhene Aiko'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSongItem(String title, String artist) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: dustyRose,
            ),
            child: const Icon(
              Icons.music_note,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: darkBlueGrey,
                  ),
                ),
                Text(
                  artist,
                  style: TextStyle(
                    fontSize: 14,
                    color: mediumBlueGrey,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.more_vert,
            color: mediumBlueGrey,
          ),
        ],
      ),
    );
  }

  Widget _buildArticleScreen() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: lightBlueGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '15 min read',
                  style: TextStyle(
                    fontSize: 12,
                    color: darkBlueGrey,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: dustyRose,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Article',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Balance',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: darkBlueGrey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '"The Importance of symmetry"',
            style: TextStyle(
              fontSize: 18,
              color: mediumBlueGrey,
            ),
          ),
          const Text(
            'by Beth Thomaz',
            style: TextStyle(
              fontSize: 16,
              color: mediumBlueGrey,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: lightBlueGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(
                Icons.directions_walk,
                size: 64,
                color: mediumBlueGrey,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
            style: TextStyle(
              fontSize: 16,
              color: darkBlueGrey,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            style: TextStyle(
              fontSize: 16,
              color: darkBlueGrey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPracticesScreen() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Practices',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: darkBlueGrey,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildPracticeButton('Peace'),
                _buildPracticeButton('Calm'),
                _buildPracticeButton('Happy'),
                _buildPracticeButton('Kind'),
                _buildPracticeButton('Passion'),
                _buildPracticeButton('Joy'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: lightBlueGrey,
            ),
            child: const Center(
              child: Text(
                'Peaceful',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: darkBlueGrey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPracticeButton(String practice) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Master',
            style: TextStyle(
              fontSize: 12,
              color: mediumBlueGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            practice,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: darkBlueGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home, 'Home'),
          _buildNavItem(1, Icons.library_music, 'Playlist'),
          _buildNavItem(2, Icons.article, 'Article'),
          _buildNavItem(3, Icons.self_improvement, 'Practices'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentScreenIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentScreenIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? dustyRose : mediumBlueGrey,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? dustyRose : mediumBlueGrey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

