import 'package:flutter/material.dart';

class M3StatusBar extends StatelessWidget {
  const M3StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 18, 28, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '9:41',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: cs.onBackground,
              letterSpacing: -0.2,
            ),
          ),
          Row(
            children: [
              _SignalBars(color: cs.onBackground),
              const SizedBox(width: 5),
              _BatteryIcon(color: cs.onBackground),
            ],
          ),
        ],
      ),
    );
  }
}

class _SignalBars extends StatelessWidget {
  final Color color;
  const _SignalBars({required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 10,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _bar(4, color),
          _bar(6, color),
          _bar(8, color),
        ],
      ),
    );
  }

  Widget _bar(double h, Color c) => Container(
        width: 3,
        height: h,
        decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(0.5)),
      );
}

class _BatteryIcon extends StatelessWidget {
  final Color color;
  const _BatteryIcon({required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      height: 10,
      child: Stack(
        children: [
          Container(
            width: 19,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.5),
              border: Border.all(color: color.withValues(alpha: 0.45), width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.5),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 3,
            child: Container(
              width: 2.5,
              height: 4,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
