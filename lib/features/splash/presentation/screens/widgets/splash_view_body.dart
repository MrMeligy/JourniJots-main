import 'package:flutter/material.dart';
import 'package:journijots/features/splash/presentation/screens/widgets/animated_logo.dart';

class SblashViewBody extends StatelessWidget {
  const SblashViewBody({
    super.key,
    required Animation<double> animation,
    required Animation<Offset> positionanimation,
  })  : _animation = animation,
        _positionanimation = positionanimation;

  final Animation<double> _animation;
  final Animation<Offset> _positionanimation;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center, // جعل الهالة في المنتصف
            radius: 0.6, // حجم الهالة
            colors: [
              Colors.white.withValues(alpha: 0.8), // منتصف الهالة (فاتح جدًا)
              const Color(0xFF68B0F8), // لون الخلفية الأساسي
            ],
          ),
        ),
        child: AnimatedLogo(positionanimation: _positionanimation),
      ),
    );
  }
}
