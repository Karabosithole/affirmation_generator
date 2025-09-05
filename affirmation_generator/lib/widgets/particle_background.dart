import 'package:flutter/material.dart';
import 'dart:math';

class ParticleBackground extends StatefulWidget {
  final Widget child;
  final bool enableAnimations;
  final Color particleColor;

  const ParticleBackground({
    Key? key,
    required this.child,
    this.enableAnimations = true,
    this.particleColor = Colors.white,
  }) : super(key: key);

  @override
  _ParticleBackgroundState createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  List<Particle> particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    
    _initializeParticles();
    
    if (widget.enableAnimations) {
      _controller.repeat();
    }
  }

  void _initializeParticles() {
    particles = List.generate(50, (index) {
      return Particle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 3 + 1,
        speed: _random.nextDouble() * 0.5 + 0.1,
        opacity: _random.nextDouble() * 0.5 + 0.1,
        direction: _random.nextDouble() * 2 * pi,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.enableAnimations)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: ParticlePainter(
                  particles: particles,
                  animationValue: _controller.value,
                  particleColor: widget.particleColor,
                ),
                size: Size.infinite,
              );
            },
          ),
        widget.child,
      ],
    );
  }
}

class Particle {
  double x;
  double y;
  double size;
  double speed;
  double opacity;
  double direction;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.direction,
  });

  void update() {
    x += cos(direction) * speed * 0.01;
    y += sin(direction) * speed * 0.01;
    
    // Wrap around screen
    if (x < 0) x = 1;
    if (x > 1) x = 0;
    if (y < 0) y = 1;
    if (y > 1) y = 0;
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double animationValue;
  final Color particleColor;

  ParticlePainter({
    required this.particles,
    required this.animationValue,
    required this.particleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = particleColor.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    for (final particle in particles) {
      particle.update();
      
      final x = particle.x * size.width;
      final y = particle.y * size.height;
      
      // Create floating effect
      final floatY = y + sin(animationValue * 2 * pi + particle.x * pi) * 10;
      
      canvas.drawCircle(
        Offset(x, floatY),
        particle.size,
        paint..color = particleColor.withOpacity(particle.opacity),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
