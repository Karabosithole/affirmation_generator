import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class MeditationTimer extends StatefulWidget {
  final bool enableAnimations;
  final bool enableHaptics;

  const MeditationTimer({
    Key? key,
    this.enableAnimations = true,
    this.enableHaptics = true,
  }) : super(key: key);

  @override
  _MeditationTimerState createState() => _MeditationTimerState();
}

class _MeditationTimerState extends State<MeditationTimer>
    with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late AnimationController _pulseController;
  late Animation<double> _breathingAnimation;
  late Animation<double> _pulseAnimation;

  Timer? _timer;
  int _remainingSeconds = 300; // 5 minutes default
  bool _isRunning = false;
  bool _isPaused = false;
  String _currentPhase = 'Inhale';

  final List<int> _presetTimes = [60, 300, 600, 900, 1800]; // 1, 5, 10, 15, 30 minutes

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _breathingController = AnimationController(
      duration: const Duration(seconds: 4), // 4 seconds per breath cycle
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _breathingAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _breathingController,
      curve: Curves.easeInOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _breathingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _breathingController.reverse();
        setState(() {
          _currentPhase = _currentPhase == 'Inhale' ? 'Exhale' : 'Inhale';
        });
      } else if (status == AnimationStatus.dismissed) {
        _breathingController.forward();
        setState(() {
          _currentPhase = _currentPhase == 'Inhale' ? 'Exhale' : 'Inhale';
        });
      }
    });
  }

  void _startTimer() {
    if (_isPaused) {
      _resumeTimer();
      return;
    }

    setState(() {
      _isRunning = true;
      _isPaused = false;
    });

    if (widget.enableHaptics) {
      HapticFeedback.mediumImpact();
    }

    _breathingController.repeat();
    _pulseController.repeat(reverse: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _completeMeditation();
      }
    });
  }

  void _pauseTimer() {
    setState(() {
      _isRunning = false;
      _isPaused = true;
    });

    if (widget.enableHaptics) {
      HapticFeedback.lightImpact();
    }

    _timer?.cancel();
    _breathingController.stop();
    _pulseController.stop();
  }

  void _resumeTimer() {
    setState(() {
      _isRunning = true;
      _isPaused = false;
    });

    if (widget.enableHaptics) {
      HapticFeedback.mediumImpact();
    }

    _breathingController.repeat();
    _pulseController.repeat(reverse: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _completeMeditation();
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
      _isPaused = false;
    });

    if (widget.enableHaptics) {
      HapticFeedback.lightImpact();
    }

    _timer?.cancel();
    _breathingController.stop();
    _pulseController.stop();
  }

  void _completeMeditation() {
    setState(() {
      _isRunning = false;
      _isPaused = false;
    });

    if (widget.enableHaptics) {
      HapticFeedback.heavyImpact();
    }

    _timer?.cancel();
    _breathingController.stop();
    _pulseController.stop();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🎉 Meditation Complete!'),
        content: const Text('Great job! You\'ve completed your meditation session.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _setTime(int seconds) {
    if (!_isRunning) {
      setState(() {
        _remainingSeconds = seconds;
      });
    }
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _breathingController.dispose();
    _pulseController.dispose();
    super.dispose();
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
        children: [
          const Text(
            '🧘 Meditation Timer',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // Breathing Circle
          AnimatedBuilder(
            animation: Listenable.merge([_breathingAnimation, _pulseAnimation]),
            builder: (context, child) {
              return Transform.scale(
                scale: widget.enableAnimations ? _breathingAnimation.value : 1.0,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPhase == 'Inhale' 
                        ? Colors.blue.withOpacity(0.3)
                        : Colors.green.withOpacity(0.3),
                    border: Border.all(
                      color: _currentPhase == 'Inhale' 
                          ? Colors.blue
                          : Colors.green,
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _currentPhase,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 20),
          
          // Timer Display
          Text(
            _formatTime(_remainingSeconds),
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Preset Time Buttons
          if (!_isRunning && !_isPaused)
            Wrap(
              spacing: 8,
              children: _presetTimes.map((time) {
                return ElevatedButton(
                  onPressed: () => _setTime(time),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _remainingSeconds == time 
                        ? Colors.blue 
                        : Colors.grey[300],
                    foregroundColor: _remainingSeconds == time 
                        ? Colors.white 
                        : Colors.black,
                  ),
                  child: Text('${time ~/ 60}m'),
                );
              }).toList(),
            ),
          
          const SizedBox(height: 20),
          
          // Control Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (!_isRunning && !_isPaused)
                ElevatedButton.icon(
                  onPressed: _startTimer,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              
              if (_isRunning)
                ElevatedButton.icon(
                  onPressed: _pauseTimer,
                  icon: const Icon(Icons.pause),
                  label: const Text('Pause'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
              
              if (_isPaused)
                ElevatedButton.icon(
                  onPressed: _resumeTimer,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Resume'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              
              if (_isRunning || _isPaused)
                ElevatedButton.icon(
                  onPressed: _stopTimer,
                  icon: const Icon(Icons.stop),
                  label: const Text('Stop'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
