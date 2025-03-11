import 'package:flutter/material.dart';

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({
    super.key,
    required Animation<Offset> positionanimation,
  }) : _positionanimation = positionanimation;

  final Animation<Offset> _positionanimation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _positionanimation,
        builder: (context, _) {
          return SlideTransition(
            position: _positionanimation,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', width: 150),
                Image.asset('assets/images/jots.png', width: 150),
              ],
            ),
          );
        },
      ),
    );
  }
}
