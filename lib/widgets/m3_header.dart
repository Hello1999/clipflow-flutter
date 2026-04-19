import 'package:flutter/material.dart';

class M3Header extends StatelessWidget {
  final String title;
  final String? meta;
  final Widget? trailing;

  const M3Header({super.key, required this.title, this.meta, this.trailing});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: cs.onBackground,
                    letterSpacing: 0,
                    height: 1.1,
                  ),
                ),
                if (meta != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    meta!,
                    style: TextStyle(
                      fontSize: 14,
                      color: cs.onSurfaceVariant,
                      letterSpacing: 0.25,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
