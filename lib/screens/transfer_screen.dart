import 'package:flutter/material.dart';
import '../widgets/m3_status_bar.dart';
import '../widgets/m3_header.dart';
import '../theme/m3_colors.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final surf1 = M3Colors.surface1(cs);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const M3StatusBar(),
        const M3Header(title: 'Transfer', meta: '1 active · 2.4 GB today'),
        // Active transfer hero card
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Material(
            color: cs.primaryContainer,
            borderRadius: BorderRadius.circular(28),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: cs.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'TRANSFERRING',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: cs.onPrimaryContainer,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Keynote_Q2.sketch',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: cs.onPrimaryContainer,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '148.2 MB · MacBook → iPhone',
                    style: TextStyle(
                      fontSize: 13,
                      color: cs.onPrimaryContainer.withValues(alpha: 0.75),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '99.3 / 148.2 MB',
                        style: TextStyle(fontSize: 13, color: cs.onPrimaryContainer),
                      ),
                      Text(
                        '67%',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: cs.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: 0.67,
                      minHeight: 6,
                      backgroundColor: Colors.black.withValues(alpha: 0.12),
                      valueColor: AlwaysStoppedAnimation(cs.primary),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '12.4 MB/s',
                        style: TextStyle(
                          fontSize: 12,
                          color: cs.onPrimaryContainer.withValues(alpha: 0.7),
                        ),
                      ),
                      Text(
                        '4s remaining',
                        style: TextStyle(
                          fontSize: 12,
                          color: cs.onPrimaryContainer.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _ActionChip(
                        label: 'Pause',
                        icon: Icons.pause_outlined,
                        cs: cs,
                        onTap: () {},
                      ),
                      const SizedBox(width: 8),
                      _ActionChip(
                        label: 'Cancel',
                        icon: Icons.close,
                        cs: cs,
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // Recent header
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Text(
            'RECENT',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
              color: cs.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            children: [
              _TransferItem(
                name: 'brand-guidelines.pdf',
                size: '4.2 MB',
                from: 'iPad',
                to: 'iPhone',
                status: _Status.done,
                progress: 1.0,
                surf1: surf1,
                cs: cs,
              ),
              const SizedBox(height: 10),
              _TransferItem(
                name: 'studio_shot.png',
                size: '12.8 MB',
                from: 'iPhone',
                to: 'MacBook',
                status: _Status.done,
                progress: 1.0,
                surf1: surf1,
                cs: cs,
              ),
              const SizedBox(height: 10),
              _TransferItem(
                name: 'onboarding.mov',
                size: '284 MB',
                from: 'MacBook',
                to: 'iPad',
                status: _Status.paused,
                progress: 0.42,
                surf1: surf1,
                cs: cs,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum _Status { done, paused, active }

class _TransferItem extends StatelessWidget {
  final String name;
  final String size;
  final String from;
  final String to;
  final _Status status;
  final double progress;
  final Color surf1;
  final ColorScheme cs;

  const _TransferItem({
    required this.name,
    required this.size,
    required this.from,
    required this.to,
    required this.status,
    required this.progress,
    required this.surf1,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: surf1,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: cs.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.description_outlined, size: 20, color: cs.onSurfaceVariant),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: cs.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$size · $from → $to',
                          style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  if (status == _Status.done)
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: cs.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.check, size: 16, color: cs.onPrimaryContainer),
                    ),
                ],
              ),
              if (status != _Status.done) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 4,
                    backgroundColor: cs.surfaceVariant,
                    valueColor: AlwaysStoppedAnimation(
                      status == _Status.paused ? cs.outline : cs.primary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final ColorScheme cs;
  final VoidCallback onTap;

  const _ActionChip({
    required this.label,
    required this.icon,
    required this.cs,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 14, color: cs.onPrimaryContainer),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: cs.onPrimaryContainer,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: cs.primary.withValues(alpha: 0.2),
      side: BorderSide.none,
      onPressed: onTap,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}
