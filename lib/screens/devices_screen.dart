import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/screen_header.dart';
import '../widgets/app_status_bar.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppStatusBar(),
          ScreenHeader(
            pretitle: 'NETWORK',
            title: 'Devices',
            sub: '3 online · 1 idle',
            trailing: GlassCard(
              borderRadius: BorderRadius.circular(18),
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.add, size: 16, color: Colors.white),
            ),
          ),
          // Mesh topology hero
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: GlassCard(
              strong: true,
              borderRadius: BorderRadius.circular(22),
              child: SizedBox(
                height: 160,
                child: Stack(
                  children: [
                    // Mesh painter
                    Positioned.fill(
                      child: CustomPaint(painter: _MeshPainter(teal: kTeal)),
                    ),
                    // Mesh label
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Text(
                        'Mesh',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: kWhite60,
                          letterSpacing: 1,
                          fontFamily: 'Courier',
                        ),
                      ),
                    ),
                    // E2E label
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Row(
                        children: [
                          Icon(Icons.shield_outlined, size: 12, color: kTeal),
                          const SizedBox(width: 4),
                          Text(
                            'E2E · iCloud',
                            style: TextStyle(
                              fontSize: 11,
                              color: kTeal,
                              fontFamily: 'Courier',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Stats
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: '1.2',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        letterSpacing: -0.6,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'ms',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: kWhite45,
                                        fontFamily: 'Courier',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'avg latency',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: kWhite45,
                                  fontFamily: 'Courier',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: '847',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        letterSpacing: -0.6,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'kb',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: kWhite45,
                                        fontFamily: 'Courier',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'today',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: kWhite45,
                                  fontFamily: 'Courier',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Paired devices header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Text(
              'PAIRED · 4',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: kWhite45,
                letterSpacing: 1,
                fontFamily: 'Courier',
              ),
            ),
          ),
          // Device list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
              children: const [
                _DeviceCard(
                  name: 'iPhone 17 Pro',
                  kind: 'iOS 26.1',
                  status: _DeviceStatus.online,
                  battery: 84,
                  thisDevice: true,
                  lastSync: 'syncing now',
                  icon: Icons.phone_iphone,
                ),
                SizedBox(height: 10),
                _DeviceCard(
                  name: 'MacBook Pro 16"',
                  kind: 'macOS 16.0',
                  status: _DeviceStatus.online,
                  battery: 62,
                  lastSync: 'synced 4s ago',
                  icon: Icons.laptop_mac,
                ),
                SizedBox(height: 10),
                _DeviceCard(
                  name: 'iPad Pro M4',
                  kind: 'iPadOS 26.1',
                  status: _DeviceStatus.online,
                  battery: 91,
                  lastSync: 'synced 12s ago',
                  icon: Icons.tablet_mac_outlined,
                ),
                SizedBox(height: 10),
                _DeviceCard(
                  name: 'Studio Display',
                  kind: 'Mac mini · Office',
                  status: _DeviceStatus.offline,
                  lastSync: '',
                  icon: Icons.computer_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MeshPainter extends CustomPainter {
  final Color teal;

  _MeshPainter({required this.teal});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h / 2;

    // Concentric rings
    final ringPaint = Paint()
      ..color = Colors.white.withOpacity(0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    for (final r in [30.0, 55.0, 80.0, 110.0]) {
      canvas.drawCircle(Offset(cx, cy), r, ringPaint);
    }

    // Connection lines - teal nodes
    final tealLinePaint = Paint()
      ..color = teal.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    _drawDashedLine(canvas, Offset(cx, cy), Offset(cx - 80, cy - 30), tealLinePaint);
    _drawDashedLine(canvas, Offset(cx, cy), Offset(cx + 80, cy - 40), tealLinePaint);
    _drawDashedLine(canvas, Offset(cx, cy), Offset(cx + 90, cy + 40), tealLinePaint);

    // Offline node line
    final dimLinePaint = Paint()
      ..color = Colors.white.withOpacity(0.28)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    _drawDashedLine(canvas, Offset(cx, cy), Offset(cx - 90, cy + 35), dimLinePaint);

    // Teal nodes
    final nodePaint = Paint()..color = teal;
    for (final pos in [
      Offset(cx - 80, cy - 30),
      Offset(cx + 80, cy - 40),
      Offset(cx + 90, cy + 40),
    ]) {
      canvas.drawCircle(pos, 4, nodePaint);
    }

    // Offline node
    final offlinePaint = Paint()..color = Colors.white.withOpacity(0.3);
    canvas.drawCircle(Offset(cx - 90, cy + 35), 3, offlinePaint);

    // Center node (this device)
    final centerGlow = Paint()
      ..color = teal.withOpacity(0.2);
    canvas.drawCircle(Offset(cx, cy), 12, centerGlow);
    canvas.drawCircle(Offset(cx, cy), 6, nodePaint);
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashLen = 2.0;
    const gapLen = 3.0;
    final total = (end - start).distance;
    final dir = (end - start) / total;
    double dist = 0;
    bool drawing = true;
    while (dist < total) {
      final segLen = drawing ? dashLen : gapLen;
      final next = dist + segLen;
      if (drawing) {
        canvas.drawLine(
          start + dir * dist,
          start + dir * next.clamp(0, total),
          paint,
        );
      }
      dist = next;
      drawing = !drawing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

enum _DeviceStatus { online, offline }

class _DeviceCard extends StatelessWidget {
  final String name;
  final String kind;
  final _DeviceStatus status;
  final int? battery;
  final bool thisDevice;
  final String lastSync;
  final IconData icon;

  const _DeviceCard({
    required this.name,
    required this.kind,
    required this.status,
    this.battery,
    this.thisDevice = false,
    required this.lastSync,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isOnline = status == _DeviceStatus.online;

    return GlassCard(
      borderRadius: BorderRadius.circular(18),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isOnline ? kTealDim : kWhite5,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.08),
                    width: 0.5,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: isOnline ? kTeal : kWhite45,
                ),
              ),
              Positioned(
                bottom: -2,
                right: -2,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isOnline ? kTeal : kWhite30,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF0B0B10), width: 2),
                    boxShadow: isOnline
                        ? [BoxShadow(color: kTeal, blurRadius: 6)]
                        : null,
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
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: -0.2,
                      ),
                    ),
                    if (thisDevice) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: kTealDim,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'THIS DEVICE',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: kTeal,
                            letterSpacing: 0.8,
                            fontFamily: 'Courier',
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  '$kind · ${isOnline ? lastSync : 'offline'}',
                  style: TextStyle(
                    fontSize: 11,
                    color: kWhite45,
                    fontFamily: 'Courier',
                  ),
                ),
              ],
            ),
          ),
          if (battery != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: kWhite5,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '$battery%',
                style: TextStyle(
                  fontSize: 11,
                  color: kWhite60,
                  fontFamily: 'Courier',
                ),
              ),
            ),
        ],
      ),
    );
  }
}
