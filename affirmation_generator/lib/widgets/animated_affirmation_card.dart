import 'package:flutter/material.dart';
import '../models/affirmation.dart';

class AnimatedAffirmationCard extends StatefulWidget {
  final Affirmation affirmation;
  final VoidCallback onTap;
  final bool isSelected;
  final bool enableAnimations;

  const AnimatedAffirmationCard({
    Key? key,
    required this.affirmation,
    required this.onTap,
    this.isSelected = false,
    this.enableAnimations = true,
  }) : super(key: key);

  @override
  _AnimatedAffirmationCardState createState() => _AnimatedAffirmationCardState();
}

class _AnimatedAffirmationCardState extends State<AnimatedAffirmationCard>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.elasticOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    if (widget.enableAnimations) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enableAnimations) {
      _scaleController.forward();
      _rotationController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enableAnimations) {
      _scaleController.reverse();
      _rotationController.reverse();
    }
    widget.onTap();
  }

  void _handleTapCancel() {
    if (widget.enableAnimations) {
      _scaleController.reverse();
      _rotationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: Listenable.merge([_scaleAnimation, _rotationAnimation, _pulseAnimation]),
        builder: (context, child) {
          return Transform.scale(
            scale: widget.enableAnimations ? _scaleAnimation.value : 1.0,
            child: Transform.rotate(
              angle: widget.enableAnimations ? _rotationAnimation.value : 0.0,
              child: Transform.scale(
                scale: widget.isSelected && widget.enableAnimations ? _pulseAnimation.value : 1.0,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: widget.isSelected 
                        ? Color(int.parse(widget.affirmation.color)).withOpacity(0.2)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(int.parse(widget.affirmation.color)).withOpacity(0.3),
                        blurRadius: widget.isSelected ? 15 : 8,
                        offset: const Offset(0, 4),
                        spreadRadius: widget.isSelected ? 2 : 0,
                      ),
                    ],
                    border: Border.all(
                      color: Color(int.parse(widget.affirmation.color)).withOpacity(0.3),
                      width: widget.isSelected ? 2 : 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.affirmation.emoji,
                          style: const TextStyle(fontSize: 32),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.affirmation.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Color(int.parse(widget.affirmation.color)).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                widget.affirmation.category,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(int.parse(widget.affirmation.color)),
                                ),
                              ),
                            ),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  size: 12,
                                  color: index < widget.affirmation.intensity
                                      ? Color(int.parse(widget.affirmation.color))
                                      : Colors.grey[300],
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
