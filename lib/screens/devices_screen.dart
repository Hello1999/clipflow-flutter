import 'package:flutter/material.dart';
import '../widgets/m3_status_bar.dart';
import '../widgets/m3_header.dart';
import '../theme/m3_colors.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final surf1 = M3Colors.surface1(cs);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const M3StatusBar(),
        M3Header(
          title: 'Devices',
          meta: '3 online · 1 idle',
          trailing: IconButton(
            icon: Icon(Icons.add, color: cs.onSurfaceVariant),
            onPressed: () {},
          ),
        ),
        // Tertiary container hero card
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Material(
            color: cs.tertiaryContainer,
            borderRadius: BorderRadius.circular(28),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.shield_outlined, size: 16, color: cs.onTertiaryContainer),
                      const SizedBox(width: 6),
                      Text(
                        'END-TO-END ENCRYPTED',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: cs.onTertiaryContainer,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _StatItem(
                        value: '1.2',
                        unit: 'ms',
                        label: 'latency',
                        color: cs.onTertiaryContainer,
                      ),
                      const SizedBox(width: 32),
                      _StatItem(
                        value: '847',
                        unit: 'kb',
                        label: 'synced today',
                        color: cs.onTertiaryContainer,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // Section label
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Text(
            'PAIRED',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
              color: cs.onSurfaceVariant,
            ),
          ),
        ),
        // Device list
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            children: [
              _DeviceCard(
                name: 'Pixel 9 Pro',
                meta: 'Android 15 · syncing',
                status: _DevStatus.online,
                battery: 84,
                thisDevice: true,
                icon: Icons.phone_android_outlined,
                surf1: surf1,
                cs: cs,
              ),
              const SizedBox(height: 10),
              _DeviceCard(
                name: 'MacBook Pro',
                meta: 'macOS 16 · 4s ago',
                status: _DevStatus.online,
                battery: 62,
                icon: Icons.laptop_mac_outlined,
                surf1: surf1,
                cs: cs,
              ),
              const SizedBox(height: 10),
              _DeviceCard(
                name: 'Pixel Tablet',
                meta: 'Android 15 · 12s ago',
                status: _DevStatus.online,
                battery: 91,
                icon: Icons.tablet_android_outlined,
                surf1: surf1,
                cs: cs,
              ),
              const SizedBox(height: 10),
              _DeviceCard(
                name: 'Pixel Watch 3',
                meta: 'Wear OS · offline',
                status: _DevStatus.offline,
                icon: Icons.watch_outlined,
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

class _StatItem extends StatelessWidget {
  final String value;
  final String unit;
  final String label;
  final Color color;

  const _StatItem({
    required this.value,
    required this.unit,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: color,
                  letterSpacing: -0.3,
                ),
              ),
              TextSpan(
                text: unit,
                style: TextStyle(
                  fontSize: 14,
                  color: color.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color.withValues(alpha: 0.75),
          ),
        ),
      ],
    );
  }
}

enum _DevStatus { online, offline }

class _DeviceCard extends StatelessWidget {
  final String name;
  final String meta;
  final _DevStatus status;
  final int? battery;
  final bool thisDevice;
  final IconData icon;
  final Color surf1;
  final ColorScheme cs;

  const _DeviceCard({
    required this.name,
    required this.meta,
    required this.status,
    this.battery,
    this.thisDevice = false,
    required this.icon,
    required this.surf1,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    final isOnline = status == _DevStatus.online;

    return Material(
      color: surf1,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isOnline ? cs.primaryContainer : cs.surfaceVariant,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 22,
                      color: isOnline ? cs.onPrimaryContainer : cs.onSurfaceVariant,
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: isOnline ? const Color(0xFF30D158) : cs.outline,
                        shape: BoxShape.circle,
                        border: Border.all(color: cs.background, width: 2.5),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: cs.onSurface,
                          ),
                        ),
                        if (thisDevice) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: cs.primaryContainer,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'THIS DEVICE',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: cs.onPrimaryContainer,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      meta,
                      style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              if (battery != null)
                Text(
                  '$battery%',
                  style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
