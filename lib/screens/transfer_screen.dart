import 'package:flutter/material.dart';
import '../models/transfer.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      value: activeTransfer.progress,
      duration: const Duration(seconds: 4),
    )..addListener(() => setState(() {}));
    _animateProgress();
  }

  void _animateProgress() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      _progressController.animateTo(1.0, duration: const Duration(seconds: 5));
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final progress = _progressController.value;
    final transferred = (activeTransfer.size.replaceAll(' MB', '').toDoubleOrNull() ?? 148.2) * progress;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Transfer'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1 active · 2.4 GB today',
                    style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                  ),
                  const SizedBox(height: 24),
                  // Active transfer card
                  _ActiveTransferCard(
                    transfer: activeTransfer,
                    progress: progress,
                    transferred: transferred,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'RECENT',
                    style: tt.labelSmall?.copyWith(
                      color: cs.onSurfaceVariant,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...recentTransfers.map(
                    (t) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _TransferCard(transfer: t),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.upload_outlined),
        label: const Text('Send'),
      ),
    );
  }
}

class _ActiveTransferCard extends StatelessWidget {
  final Transfer transfer;
  final double progress;
  final double transferred;

  const _ActiveTransferCard({
    required this.transfer,
    required this.progress,
    required this.transferred,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(28),
      ),
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
                style: tt.labelSmall?.copyWith(
                  color: cs.onPrimaryContainer,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            transfer.name,
            style: tt.titleLarge?.copyWith(
              color: cs.onPrimaryContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${transfer.size} · ${transfer.from} → ${transfer.to}',
            style: tt.bodySmall?.copyWith(
              color: cs.onPrimaryContainer.withValues(alpha: 0.75),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${transferred.toStringAsFixed(1)} / ${transfer.size}',
                style: tt.bodySmall?.copyWith(color: cs.onPrimaryContainer),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: tt.bodySmall?.copyWith(
                  color: cs.onPrimaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: cs.onPrimaryContainer.withValues(alpha: 0.15),
              valueColor: AlwaysStoppedAnimation(cs.primary),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                transfer.speed ?? '',
                style: tt.bodySmall?.copyWith(
                  color: cs.onPrimaryContainer.withValues(alpha: 0.7),
                ),
              ),
              Text(
                transfer.remaining ?? '',
                style: tt.bodySmall?.copyWith(
                  color: cs.onPrimaryContainer.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TransferCard extends StatelessWidget {
  final Transfer transfer;

  const _TransferCard({required this.transfer});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.insert_drive_file_outlined,
              size: 20,
              color: cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transfer.name,
                  style: tt.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: cs.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${transfer.size} · ${transfer.from} → ${transfer.to}',
                  style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                ),
                if (transfer.status == TransferStatus.paused) ...[
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: transfer.progress,
                      backgroundColor: cs.surfaceContainerHighest,
                      valueColor: AlwaysStoppedAnimation(cs.outline),
                      minHeight: 4,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          if (transfer.status == TransferStatus.done)
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                size: 16,
                color: cs.onPrimaryContainer,
              ),
            )
          else if (transfer.status == TransferStatus.paused)
            Icon(Icons.pause_circle_outline, color: cs.outline),
        ],
      ),
    );
  }
}

extension on String {
  double? toDoubleOrNull() => double.tryParse(this);
}
