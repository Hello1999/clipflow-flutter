import 'package:flutter/cupertino.dart';
import '../theme/ios_colors.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Devices'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.plus_circle_fill, size: 22),
              onPressed: () {},
            ),
          ),
          SliverToBoxAdapter(child: _buildStatsCard(context)),
          SliverToBoxAdapter(child: _buildSectionHeader(context)),
          SliverToBoxAdapter(child: _buildDeviceList(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 6),
      child: Text(
        'PAIRED',
        style: TextStyle(
          fontSize: 13,
          color: context.label2,
          letterSpacing: -0.08,
        ),
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.cardBg,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(CupertinoIcons.lock_fill,
                    size: 13, color: context.green),
                const SizedBox(width: 6),
                Text(
                  'End-to-end encrypted via iCloud',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: context.label2,
                    letterSpacing: -0.08,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _Stat(value: '1.2', unit: 'ms', label: 'Latency'),
                Container(width: 0.33, height: 44, color: context.sep),
                _Stat(value: '847', unit: 'kb', label: 'Today'),
                Container(width: 0.33, height: 44, color: context.sep),
                _Stat(value: '4', unit: '', label: 'Devices'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            _DeviceRow(
              icon: CupertinoIcons.device_phone_portrait,
              name: 'iPhone 15 Pro',
              meta: 'iOS 26.1 · syncing',
              status: _DeviceStatus.online,
              battery: 84,
              thisDevice: true,
              isLast: false,
            ),
            CupertinoContextMenu.builder(
              actions: [
                CupertinoContextMenuAction(
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                  trailingIcon: CupertinoIcons.doc_on_clipboard,
                  child: const Text('Push clipboard'),
                ),
                CupertinoContextMenuAction(
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                  trailingIcon: CupertinoIcons.arrow_up_doc,
                  child: const Text('Send file…'),
                ),
                CupertinoContextMenuAction(
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                  trailingIcon: CupertinoIcons.pencil,
                  child: const Text('Rename'),
                ),
                CupertinoContextMenuAction(
                  isDestructiveAction: true,
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                  trailingIcon: CupertinoIcons.xmark_circle,
                  child: const Text('Forget device'),
                ),
              ],
              builder: (ctx, anim) => _DeviceRow(
                icon: CupertinoIcons.desktopcomputer,
                name: 'MacBook Pro 16"',
                meta: 'macOS 16.0 · 4s ago',
                status: _DeviceStatus.online,
                battery: 62,
                isLast: false,
              ),
            ),
            _DeviceRow(
              icon: CupertinoIcons.rectangle,
              name: 'iPad Pro M4',
              meta: 'iPadOS 26.1 · 12s ago',
              status: _DeviceStatus.online,
              battery: 91,
              isLast: false,
            ),
            _DeviceRow(
              icon: CupertinoIcons.time,
              name: 'Apple Watch Ultra',
              meta: 'watchOS 12 · offline',
              status: _DeviceStatus.offline,
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Stat cell ─────────────────────────────────────────────────
class _Stat extends StatelessWidget {
  final String value;
  final String unit;
  final String label;

  const _Stat({required this.value, required this.unit, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: context.label,
                    letterSpacing: 0.3,
                    height: 1,
                    decoration: TextDecoration.none,
                  ),
                ),
                if (unit.isNotEmpty) ...[
                  const SizedBox(width: 1),
                  Text(
                    unit,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: context.label2,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: context.label2,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _DeviceStatus { online, offline }

// ── Device row ────────────────────────────────────────────────
class _DeviceRow extends StatelessWidget {
  final IconData icon;
  final String name;
  final String meta;
  final _DeviceStatus status;
  final int? battery;
  final bool thisDevice;
  final bool isLast;

  const _DeviceRow({
    required this.icon,
    required this.name,
    required this.meta,
    required this.status,
    this.battery,
    this.thisDevice = false,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final isOnline = status == _DeviceStatus.online;

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
                  color: isOnline ? context.blue : context.fill,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color:
                      isOnline ? CupertinoColors.white : context.label2,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: context.label,
                            letterSpacing: -0.4,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        if (thisDevice) ...[
                          const SizedBox(width: 6),
                          Text(
                            '· This iPhone',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: context.blue,
                              letterSpacing: 0.1,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      meta,
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
              if (battery != null) ...[
                Text(
                  '$battery%',
                  style: TextStyle(
                    fontSize: 15,
                    color: context.label2,
                    fontFamily: 'Courier',
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(width: 10),
              ],
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isOnline ? context.green : context.label3,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
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
