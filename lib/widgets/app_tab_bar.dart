import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'glass_card.dart';

class AppTabBar extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onTap;

  const AppTabBar({
    super.key,
    required this.activeIndex,
    required this.onTap,
  });

  static const _tabs = [
    _TabItem(icon: Icons.content_paste_outlined, label: 'Feed'),
    _TabItem(icon: Icons.description_outlined, label: 'Transfer'),
    _TabItem(icon: Icons.devices_outlined, label: 'Devices'),
    _TabItem(icon: Icons.settings_outlined, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      strong: true,
      borderRadius: BorderRadius.circular(28),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: List.generate(_tabs.length, (i) {
          final tab = _tabs[i];
          final isActive = i == activeIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(i),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isActive ? kTealDim : Colors.transparent,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      tab.icon,
                      size: 22,
                      color: isActive ? kTeal : kWhite45,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      tab.label,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isActive ? kTeal : kWhite45,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _TabItem {
  final IconData icon;
  final String label;
  const _TabItem({required this.icon, required this.label});
}
