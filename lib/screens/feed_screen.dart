import 'package:flutter/material.dart';
import '../widgets/m3_status_bar.dart';
import '../widgets/m3_header.dart';
import '../theme/m3_colors.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedFilter = 0;

  static const _filters = ['All', 'Text', 'Links', 'Images', 'Code'];
  static const _counts = [47, 28, 11, 6, 2];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final surf1 = M3Colors.surface1(cs);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const M3StatusBar(),
        M3Header(
          title: 'Clipboard',
          meta: '47 items · synced 2s ago',
          trailing: IconButton(
            icon: Icon(Icons.search_outlined, color: cs.onSurfaceVariant),
            onPressed: () {},
          ),
        ),
        // Filter chips
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            itemCount: _filters.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final selected = i == _selectedFilter;
              return FilterChip(
                selected: selected,
                label: Text('${_filters[i]} ${_counts[i]}'),
                onSelected: (_) => setState(() => _selectedFilter = i),
                showCheckmark: selected,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.symmetric(horizontal: 4),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        // Section label
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'JUST NOW',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                  color: cs.onSurfaceVariant,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: cs.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'LIVE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                      color: cs.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Feed
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            children: [
              _ClipCard(
                icon: Icons.link_outlined,
                source: 'Safari · iPhone',
                time: 'just now',
                isAccent: true,
                surf1: surf1,
                cs: cs,
                content: 'figma.com/file/k3Mx9…/ClipFlow',
              ),
              const SizedBox(height: 12),
              _ClipCard(
                icon: Icons.code_outlined,
                source: 'Terminal · MacBook',
                time: '1m',
                surf1: surf1,
                cs: cs,
                mono: true,
                content: 'git checkout -b feat/share-sheet',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'EARLIER TODAY',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ),
              _ClipCard(
                icon: Icons.text_fields_outlined,
                source: 'Notes · iPad',
                time: '14m',
                surf1: surf1,
                cs: cs,
                content: 'Move onboarding handoff to Thursday.',
              ),
              const SizedBox(height: 12),
              _ClipCard(
                icon: Icons.message_outlined,
                source: 'Messages',
                time: '1h',
                surf1: surf1,
                cs: cs,
                content: 'Hotel confirmation: #A2-7841-22B',
              ),
              const SizedBox(height: 12),
              _ClipCard(
                icon: Icons.image_outlined,
                source: 'Photos · iPhone',
                time: '2h',
                surf1: surf1,
                cs: cs,
                content: 'Screenshot_2026-04-18.png',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ClipCard extends StatelessWidget {
  final IconData icon;
  final String source;
  final String time;
  final String content;
  final bool isAccent;
  final bool mono;
  final Color surf1;
  final ColorScheme cs;

  const _ClipCard({
    required this.icon,
    required this.source,
    required this.time,
    required this.content,
    required this.surf1,
    required this.cs,
    this.isAccent = false,
    this.mono = false,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isAccent ? cs.primaryContainer : surf1;
    final iconBg = isAccent ? cs.primary : cs.surfaceVariant;
    final iconColor = isAccent ? cs.onPrimary : cs.onSurfaceVariant;
    final metaColor = isAccent ? cs.onPrimaryContainer : cs.onSurfaceVariant;
    final contentColor = isAccent ? cs.onPrimaryContainer : cs.onSurface;

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(28),
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
                    child: Icon(icon, size: 14, color: iconColor),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      source,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.4,
                        color: metaColor,
                      ),
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: metaColor.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                content,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.45,
                  letterSpacing: 0.15,
                  color: contentColor,
                  fontFamily: mono ? 'Courier' : null,
                  fontFamilyFallback: mono ? const ['monospace'] : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
