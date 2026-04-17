import 'package:flutter/material.dart';
import '../models/clip_item.dart';
import '../widgets/clip_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  ClipType? _selectedFilter;

  List<ClipItem> get filteredClips {
    if (_selectedFilter == null) return mockClips;
    return mockClips.where((c) => c.type == _selectedFilter).toList();
  }

  int countByType(ClipType? type) {
    if (type == null) return mockClips.length;
    return mockClips.where((c) => c.type == type).length;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Clipboard'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '${mockClips.length} items · synced 2s ago',
                      style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _FilterChip(
                          label: 'All',
                          count: countByType(null),
                          selected: _selectedFilter == null,
                          onTap: () => setState(() => _selectedFilter = null),
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Text',
                          count: countByType(ClipType.text),
                          selected: _selectedFilter == ClipType.text,
                          onTap: () => setState(() => _selectedFilter = ClipType.text),
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Links',
                          count: countByType(ClipType.link),
                          selected: _selectedFilter == ClipType.link,
                          onTap: () => setState(() => _selectedFilter = ClipType.link),
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Code',
                          count: countByType(ClipType.code),
                          selected: _selectedFilter == ClipType.code,
                          onTap: () => setState(() => _selectedFilter = ClipType.code),
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Images',
                          count: countByType(ClipType.image),
                          selected: _selectedFilter == ClipType.image,
                          onTap: () => setState(() => _selectedFilter = ClipType.image),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'JUST NOW',
                      style: tt.labelSmall?.copyWith(
                        color: cs.onSurfaceVariant,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final clip = filteredClips[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ClipCard(
                      clip: clip,
                      accent: index == 0 && _selectedFilter == null,
                    ),
                  );
                },
                childCount: filteredClips.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('New'),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(
          horizontal: selected ? 12 : 16,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: selected ? cs.secondaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: selected
              ? null
              : Border.all(color: cs.outlineVariant),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
              Icon(Icons.check, size: 16, color: cs.onSecondaryContainer),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: selected ? cs.onSecondaryContainer : cs.onSurfaceVariant,
                letterSpacing: 0.1,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 12,
                color: (selected ? cs.onSecondaryContainer : cs.onSurfaceVariant)
                    .withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
