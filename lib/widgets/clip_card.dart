import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/clip_item.dart';

class ClipCard extends StatelessWidget {
  final ClipItem clip;
  final bool accent;

  const ClipCard({super.key, required this.clip, this.accent = false});

  IconData _iconForType(ClipType type) {
    switch (type) {
      case ClipType.link:
        return Icons.link;
      case ClipType.code:
        return Icons.code;
      case ClipType.image:
        return Icons.image_outlined;
      case ClipType.text:
        return Icons.text_fields;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final bgColor = accent ? cs.primaryContainer : cs.surfaceContainerLow;
    final onBgColor = accent ? cs.onPrimaryContainer : cs.onSurface;
    final onBgVariant = accent ? cs.onPrimaryContainer : cs.onSurfaceVariant;
    final iconBg = accent ? cs.primary : cs.surfaceContainerHighest;
    final iconColor = accent ? cs.onPrimary : cs.onSurfaceVariant;

    return GestureDetector(
      onLongPress: () => _showContextMenu(context),
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: () => _copyToClipboard(context),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: iconBg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _iconForType(clip.type),
                        size: 14,
                        color: iconColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        clip.source,
                        style: tt.labelSmall?.copyWith(
                          color: onBgVariant,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                    Text(
                      clip.time,
                      style: tt.labelSmall?.copyWith(
                        color: onBgVariant.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  clip.content,
                  style: (clip.type == ClipType.code
                          ? tt.bodyMedium?.copyWith(
                              fontFamily: 'monospace',
                              fontSize: 13,
                            )
                          : tt.bodyMedium)
                      ?.copyWith(
                    color: onBgColor,
                    height: 1.45,
                    letterSpacing: 0.15,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: clip.content));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      builder: (ctx) => _ClipContextMenu(clip: clip),
    );
  }
}

class _ClipContextMenu extends StatelessWidget {
  final ClipItem clip;

  const _ClipContextMenu({required this.clip});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: cs.onSurfaceVariant.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cs.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                clip.content,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: cs.onSurface,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 12),
            _ActionTile(
              icon: Icons.copy,
              label: 'Copy',
              onTap: () {
                Clipboard.setData(ClipboardData(text: clip.content));
                Navigator.pop(context);
              },
            ),
            _ActionTile(
              icon: Icons.push_pin_outlined,
              label: 'Pin',
              onTap: () => Navigator.pop(context),
            ),
            _ActionTile(
              icon: Icons.share_outlined,
              label: 'Share',
              onTap: () => Navigator.pop(context),
            ),
            _ActionTile(
              icon: Icons.delete_outline,
              label: 'Delete',
              color: cs.error,
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final c = color ?? cs.onSurface;

    return ListTile(
      leading: Icon(icon, color: c),
      title: Text(label, style: TextStyle(color: c)),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
