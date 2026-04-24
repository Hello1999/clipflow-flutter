import 'package:flutter/cupertino.dart';
import '../theme/ios_colors.dart';

class ClipboardFeedScreen extends StatefulWidget {
  const ClipboardFeedScreen({super.key});

  @override
  State<ClipboardFeedScreen> createState() => _ClipboardFeedScreenState();
}

class _ClipboardFeedScreenState extends State<ClipboardFeedScreen> {
  int _segment = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Clipboard'),
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text('Edit'),
              onPressed: () {},
            ),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.plus_circle_fill, size: 22),
              onPressed: () {},
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: CupertinoSearchTextField(
                placeholder: 'Search',
              ),
            ),
          ),
          SliverToBoxAdapter(child: _buildSegmentedControl(context)),
          SliverToBoxAdapter(child: _buildSection(context, 'Just now', showLive: true)),
          SliverToBoxAdapter(child: _buildJustNowCards(context)),
          SliverToBoxAdapter(child: _buildSection(context, 'Earlier Today')),
          SliverToBoxAdapter(child: _buildEarlierCards(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  Widget _buildSegmentedControl(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: CupertinoSlidingSegmentedControl<int>(
        groupValue: _segment,
        onValueChanged: (v) => setState(() => _segment = v ?? 0),
        children: const {
          0: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text('All', style: TextStyle(fontSize: 13))),
          1: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text('Text', style: TextStyle(fontSize: 13))),
          2: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text('Links', style: TextStyle(fontSize: 13))),
          3: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text('Images', style: TextStyle(fontSize: 13))),
          4: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text('Code', style: TextStyle(fontSize: 13))),
        },
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title,
      {bool showLive = false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 6),
      child: Row(
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: context.label2,
              letterSpacing: -0.08,
            ),
          ),
          if (showLive) ...[
            const Spacer(),
            const _PulseDot(),
            const SizedBox(width: 4),
            Text(
              'LIVE',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: context.blue,
                fontFamily: 'Courier',
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildJustNowCards(BuildContext context) {
    final bg = context.cardBg;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            _ClipCell(
              icon: CupertinoIcons.link,
              iconTint: context.blue,
              source: 'Safari',
              time: 'just now',
              bg: bg,
              isLast: false,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 15,
                    color: context.label,
                    letterSpacing: -0.24,
                    height: 1.4,
                    decoration: TextDecoration.none,
                  ),
                  children: [
                    TextSpan(
                        text: 'figma.com',
                        style: TextStyle(color: context.blue)),
                    const TextSpan(text: '/file/k3Mx9…/ClipFlow-Designs'),
                  ],
                ),
              ),
            ),
            _ClipCell(
              icon: CupertinoIcons.chevron_left_slash_chevron_right,
              iconTint: context.label2,
              source: 'Terminal',
              time: '1m',
              pinned: true,
              bg: bg,
              isLast: true,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 14,
                    color: context.label,
                    letterSpacing: -0.1,
                    decoration: TextDecoration.none,
                  ),
                  children: [
                    const TextSpan(text: 'git checkout -b '),
                    TextSpan(
                        text: 'feat/share-sheet',
                        style: TextStyle(color: context.blue)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarlierCards(BuildContext context) {
    final bg = context.cardBg;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            _ClipCell(
              icon: CupertinoIcons.text_alignleft,
              iconTint: context.label2,
              source: 'Notes · iPad',
              time: '14m',
              bg: bg,
              isLast: false,
              child: Text(
                'Move the onboarding handoff to Thursday — keep Eng async on the API review.',
                style: TextStyle(
                  fontSize: 15,
                  color: context.label,
                  letterSpacing: -0.24,
                  height: 1.4,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            _SwipeCell(
              bg: bg,
              child: _ClipCell(
                icon: CupertinoIcons.text_alignleft,
                iconTint: context.label2,
                source: 'Messages',
                time: '1h',
                bg: bg,
                isLast: false,
                borderBottom: false,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 15,
                      color: context.label,
                      letterSpacing: -0.24,
                      height: 1.4,
                      decoration: TextDecoration.none,
                    ),
                    children: [
                      const TextSpan(text: 'Hotel confirmation: '),
                      TextSpan(
                        text: '#A2-7841-22B',
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 14,
                          color: context.label,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _ClipCell(
              icon: CupertinoIcons.photo,
              iconTint: context.green,
              source: 'Photos',
              time: '2h',
              bg: bg,
              isLast: true,
              child: Text(
                'IMG_4817.HEIC · 3024 × 4032',
                style: TextStyle(
                  fontSize: 15,
                  color: context.label,
                  letterSpacing: -0.24,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Pulsing live dot ──────────────────────────────────────────
class _PulseDot extends StatefulWidget {
  const _PulseDot();

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final blue = context.blue;
    return AnimatedBuilder(
      animation: _c,
      builder: (_, child) {
        final t = Curves.easeInOut.transform(_c.value);
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: blue,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: blue.withValues(alpha: 0.35 + 0.25 * t),
                blurRadius: 3 + 5 * t,
                spreadRadius: t,
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Plain clip cell ───────────────────────────────────────────
class _ClipCell extends StatelessWidget {
  final IconData icon;
  final Color iconTint;
  final String source;
  final String time;
  final Widget child;
  final bool pinned;
  final Color bg;
  final bool isLast;
  final bool borderBottom;

  const _ClipCell({
    required this.icon,
    required this.iconTint,
    required this.source,
    required this.time,
    required this.child,
    required this.bg,
    required this.isLast,
    this.pinned = false,
    this.borderBottom = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bg,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 13, color: iconTint),
              const SizedBox(width: 6),
              Text(
                source,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: context.label,
                  letterSpacing: -0.08,
                  decoration: TextDecoration.none,
                ),
              ),
              Text(
                ' · ',
                style: TextStyle(
                    fontSize: 13,
                    color: context.label2,
                    decoration: TextDecoration.none),
              ),
              Text(
                time,
                style: TextStyle(
                    fontSize: 13,
                    color: context.label2,
                    letterSpacing: -0.08,
                    decoration: TextDecoration.none),
              ),
              const Spacer(),
              if (pinned)
                Icon(CupertinoIcons.pin_fill,
                    size: 12, color: context.orange),
            ],
          ),
          const SizedBox(height: 6),
          child,
          if (!isLast && borderBottom)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(height: 0.33, color: context.sep),
            ),
        ],
      ),
    );
  }
}

// ── Swipe-to-reveal cell (Pin + Delete) ──────────────────────
class _SwipeCell extends StatefulWidget {
  final Widget child;
  final Color bg;

  const _SwipeCell({required this.child, required this.bg});

  @override
  State<_SwipeCell> createState() => _SwipeCellState();
}

class _SwipeCellState extends State<_SwipeCell>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 260),
  );
  Animation<double>? _snapAnim;
  double _offset = 0;
  static const double _reveal = 148.0;

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _snap(double target) {
    _c.stop();
    final start = _offset;
    _snapAnim = Tween<double>(begin: start, end: target)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeOut))
      ..addListener(() => setState(() => _offset = _snapAnim!.value));
    _c.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final orange = context.orange;
    final red = context.red;

    return GestureDetector(
      onHorizontalDragUpdate: (d) {
        _c.stop();
        setState(
            () => _offset = (_offset + d.delta.dx).clamp(-_reveal, 0.0));
      },
      onHorizontalDragEnd: (d) {
        final v = d.primaryVelocity ?? 0;
        _snap((_offset < -_reveal / 2 || v < -250) ? -_reveal : 0);
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () => _snap(0),
                  child: Container(
                    width: 74,
                    color: orange,
                    alignment: Alignment.center,
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(CupertinoIcons.pin_fill,
                            color: CupertinoColors.white, size: 20),
                        SizedBox(height: 4),
                        Text('Pin',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none,
                            )),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _snap(0),
                  child: Container(
                    width: 74,
                    color: red,
                    alignment: Alignment.center,
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(CupertinoIcons.trash,
                            color: CupertinoColors.white, size: 20),
                        SizedBox(height: 4),
                        Text('Delete',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(_offset, 0),
            child: Container(
              color: widget.bg,
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
