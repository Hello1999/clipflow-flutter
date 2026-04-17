import 'package:flutter/material.dart';
import '../theme/colors.dart';

class PhoneBg extends StatelessWidget {
  final Widget? child;

  const PhoneBg({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBg,
      child: Stack(
        children: [
          // Top-left teal bloom
          Positioned(
            top: -160,
            left: -120,
            child: Container(
              width: 440,
              height: 440,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    kTeal.withOpacity(0.18),
                    Colors.transparent,
                  ],
                  stops: const [0, 0.7],
                ),
              ),
            ),
          ),
          // Bottom-right blue bloom
          Positioned(
            bottom: -200,
            right: -160,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF5078FF).withOpacity(0.12),
                    Colors.transparent,
                  ],
                  stops: const [0, 0.7],
                ),
              ),
            ),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
