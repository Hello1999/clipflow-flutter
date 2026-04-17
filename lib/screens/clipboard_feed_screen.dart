import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/screen_header.dart';
import '../widgets/app_status_bar.dart';

class ClipboardFeedScreen extends StatefulWidget {
  const ClipboardFeedScreen({super.key});

  @override
  State<ClipboardFeedScreen> createState() => _ClipboardFeedScreenState();
}

class _ClipboardFeedScreenState extends State<ClipboardFeedScreen> {
  int _activeFilter = 0;

  static const _filters = [
    _FilterItem(label: 'All', count: 47),
    _FilterItem(label: 'Text', count: 28),
    _FilterItem(label: 'Links', count: 11),
    _FilterItem(label: 'Images', count: 6),
    _FilterItem(label: 'Code', count: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppStatusBar(),
          ScreenHeader(
            pretitle: 'CLIPFLOW',
            title: 'Clipboard',
            sub: '47 items · synced 2s ago',
            trailing: GlassCard(
              borderRadius: BorderRadius.circular(18),
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.search, size: 16, color: Colors.white),
            ),
          ),
          // Filter chips
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 6),
              itemBuilder: (context, i) {
                final f = _filters[i];
                final isOn = i == _activeFilter;
                return GestureDetector(
                  onTap: () => setState(() => _activeFilter = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isOn ? kTeal : kWhite5,
                      borderRadius: BorderRadius.circular(12),
                      border: isOn
                          ? null
                          : Border.all(
                              color: Colors.white.withOpacity(0.1),
                              width: 0.5,
                            ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          f.label,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isOn ? kTealDark : kWhite60,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${f.count}',
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Courier',
                            color: (isOn ? kTealDark : kWhite60).withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Section label with LIVE indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Just now',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: kWhite45,
                    letterSpacing: 1,
                    fontFamily: 'Courier',
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: kTeal,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: kTeal, blurRadius: 8)],
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'LIVE',
                      style: TextStyle(
                        fontSize: 11,
                        color: kTeal,
                        fontFamily: 'Courier',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Feed
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
              children: [
                _ClipCard(
                  icon: Icons.link,
                  source: 'Safari · iPhone',
                  time: 'just now',
                  accent: true,
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 14, height: 1.45, letterSpacing: -0.15),
                      children: [
                        TextSpan(text: 'figma.com', style: TextStyle(color: kTeal)),
                        const TextSpan(
                          text: '/file/k3Mx…/ClipFlow-Designs',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _ClipCard(
                  icon: Icons.code,
                  source: 'Terminal · MacBook Pro',
                  time: '1m',
                  pinned: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 12,
                            color: Color(0xFFE8E8EC),
                          ),
                          children: [
                            TextSpan(text: '\$ ', style: TextStyle(color: kWhite30)),
                            const TextSpan(text: 'git checkout -b'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: Text(
                          'feat/share-sheet',
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 12,
                            color: kTeal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    'Earlier today',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: kWhite45,
                      letterSpacing: 1,
                      fontFamily: 'Courier',
                    ),
                  ),
                ),
                _ClipCard(
                  icon: Icons.text_fields,
                  source: 'Notes · iPad',
                  time: '14m',
                  child: const Text(
                    'Move the onboarding handoff to Thursday — keep Eng async on the API review.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      height: 1.45,
                      letterSpacing: -0.15,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _ClipCard(
                  icon: Icons.message_outlined,
                  source: 'Messages · iPhone',
                  time: '1h',
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        height: 1.45,
                        letterSpacing: -0.15,
                      ),
                      children: [
                        const TextSpan(text: 'hotel confirmation: '),
                        TextSpan(
                          text: '#A2-7841-22B',
                          style: TextStyle(fontFamily: 'Courier', color: kTeal),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _ClipCard(
                  icon: Icons.text_fields,
                  source: 'Slack · MacBook Pro',
                  time: '2h',
                  child: const Text(
                    'Design review at 3pm — make sure to pull the latest Figma branch before.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      height: 1.45,
                      letterSpacing: -0.15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ClipCard extends StatelessWidget {
  final IconData icon;
  final String source;
  final String time;
  final Widget child;
  final bool accent;
  final bool pinned;

  const _ClipCard({
    required this.icon,
    required this.source,
    required this.time,
    required this.child,
    this.accent = false,
    this.pinned = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.045),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: accent ? kTeal.withOpacity(0.3) : Colors.white.withOpacity(0.1),
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: accent ? kTealDim : kWhite5,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Icon(icon, size: 12, color: accent ? kTeal : kWhite60),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      source,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: kWhite60,
                      ),
                    ),
                  ),
                  if (pinned) ...[
                    Icon(Icons.push_pin, size: 11, color: kTeal),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 11,
                      color: kWhite30,
                      fontFamily: 'Courier',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterItem {
  final String label;
  final int count;
  const _FilterItem({required this.label, required this.count});
}
