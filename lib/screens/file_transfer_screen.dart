import 'package:flutter/cupertino.dart';
import '../theme/ios_colors.dart';

class FileTransferScreen extends StatelessWidget {
  const FileTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Transfer'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: const Text(
                'Send',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SliverToBoxAdapter(child: _buildHeroCard(context)),
          SliverToBoxAdapter(child: _buildSectionHeader(context, 'Recent')),
          SliverToBoxAdapter(child: _buildRecentList(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 6),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 13,
          color: context.label2,
          letterSpacing: -0.08,
        ),
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.cardBg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: context.fill2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    CupertinoIcons.arrow_up_doc_fill,
                    size: 24,
                    color: context.blue,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Keynote_Q2.sketch',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: context.label,
                          letterSpacing: -0.4,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '148.2 MB · MacBook Pro → iPhone',
                        style: TextStyle(
                          fontSize: 13,
                          color: context.label2,
                          letterSpacing: -0.08,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Progress numbers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '99.3 / 148.2 MB',
                  style: TextStyle(
                    fontSize: 13,
                    color: context.label,
                    fontFamily: 'Courier',
                    decoration: TextDecoration.none,
                  ),
                ),
                Text(
                  '67%',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: context.blue,
                    fontFamily: 'Courier',
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Animated progress bar
            _AnimatedProgressBar(value: 0.67),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '12.4 MB/s',
                  style: TextStyle(
                    fontSize: 12,
                    color: context.label2,
                    fontFamily: 'Courier',
                    decoration: TextDecoration.none,
                  ),
                ),
                Text(
                  '4s remaining',
                  style: TextStyle(
                    fontSize: 12,
                    color: context.label2,
                    fontFamily: 'Courier',
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _ActionBtn(
                    label: 'Pause',
                    color: context.blue,
                    bg: context.fill2,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionBtn(
                    label: 'Cancel',
                    color: context.red,
                    bg: context.fill2,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            _TransferRow(
              name: 'brand-guidelines.pdf',
              size: '4.2 MB',
              from: 'iPad',
              to: 'iPhone',
              status: _Status.done,
              progress: 1.0,
              isLast: false,
            ),
            _TransferRow(
              name: 'studio_shot_07.png',
              size: '12.8 MB',
              from: 'iPhone',
              to: 'MacBook',
              status: _Status.done,
              progress: 1.0,
              isLast: false,
            ),
            _TransferRow(
              name: 'onboarding.mov',
              size: '284 MB',
              from: 'MacBook',
              to: 'iPad',
              status: _Status.paused,
              progress: 0.42,
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Animated progress bar ─────────────────────────────────────
class _AnimatedProgressBar extends StatelessWidget {
  final double value;
  const _AnimatedProgressBar({required this.value});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: const Duration(milliseconds: 1100),
      curve: Curves.easeOut,
      builder: (ctx, v, _) {
        final blue = ctx.blue;
        final track = ctx.fill;
        return Container(
          height: 4,
          decoration: BoxDecoration(
            color: track,
            borderRadius: BorderRadius.circular(2),
          ),
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: v,
            child: Container(
              decoration: BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Action button ─────────────────────────────────────────────
class _ActionBtn extends StatelessWidget {
  final String label;
  final Color color;
  final Color bg;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.label,
    required this.color,
    required this.bg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: color,
            letterSpacing: -0.24,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

enum _Status { done, paused }

// ── Transfer row ──────────────────────────────────────────────
class _TransferRow extends StatelessWidget {
  final String name;
  final String size;
  final String from;
  final String to;
  final _Status status;
  final double progress;
  final bool isLast;

  const _TransferRow({
    required this.name,
    required this.size,
    required this.from,
    required this.to,
    required this.status,
    required this.progress,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final isDone = status == _Status.done;
    return Container(
      color: context.cardBg,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: context.fill2,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  CupertinoIcons.doc_fill,
                  size: 22,
                  color: context.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: context.label,
                        letterSpacing: -0.32,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$size · $from → $to',
                      style: TextStyle(
                        fontSize: 13,
                        color: context.label2,
                        letterSpacing: -0.08,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (isDone)
                Icon(CupertinoIcons.checkmark_circle_fill,
                    size: 22, color: context.green)
              else
                Icon(CupertinoIcons.pause_circle,
                    size: 22, color: context.blue),
            ],
          ),
          if (!isDone) ...[
            const SizedBox(height: 8),
            _AnimatedProgressBar(value: progress),
          ],
          if (!isLast)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(height: 0.33, color: context.sep),
            ),
        ],
      ),
    );
  }
}
