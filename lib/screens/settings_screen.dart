import 'package:flutter/cupertino.dart';
import '../theme/ios_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _universalClipboard = true;
  bool _e2eEncryption = true;
  bool _excludePasswords = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Settings'),
          ),
          SliverToBoxAdapter(child: _buildProfile(context)),
          SliverToBoxAdapter(
            child: _buildGroup(
              context,
              header: 'Sync',
              footer: null,
              rows: [
                _IOSRow(
                  icon: CupertinoIcons.bolt_horizontal_circle_fill,
                  iconBg: context.blue,
                  title: 'Universal Clipboard',
                  toggle: _universalClipboard,
                  onToggle: (v) =>
                      setState(() => _universalClipboard = v),
                  isLast: false,
                ),
                _IOSRow(
                  icon: CupertinoIcons.cloud_fill,
                  iconBg: const Color(0xFF5AC8FA),
                  title: 'iCloud',
                  detail: 'On',
                  chev: true,
                  isLast: false,
                ),
                _IOSRow(
                  icon: CupertinoIcons.clock_fill,
                  iconBg: context.orange,
                  title: 'History',
                  detail: '30 Days',
                  chev: true,
                  isLast: true,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: _buildGroup(
              context,
              header: 'Privacy & Security',
              footer:
                  'Only this device can decrypt synced clipboard items. Apple never has access.',
              rows: [
                _IOSRow(
                  icon: CupertinoIcons.lock_fill,
                  iconBg: context.green,
                  title: 'End-to-End Encryption',
                  toggle: _e2eEncryption,
                  onToggle: (v) =>
                      setState(() => _e2eEncryption = v),
                  isLast: false,
                ),
                _IOSRow(
                  icon: CupertinoIcons.shield_lefthalf_fill,
                  iconBg: context.purple,
                  title: 'Exclude Passwords',
                  toggle: _excludePasswords,
                  onToggle: (v) =>
                      setState(() => _excludePasswords = v),
                  isLast: false,
                ),
                _IOSRow(
                  icon: CupertinoIcons.bell_fill,
                  iconBg: context.red,
                  title: 'Notifications',
                  detail: 'Silent',
                  chev: true,
                  isLast: true,
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  Widget _buildProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        decoration: BoxDecoration(
          color: context.cardBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [context.blue, const Color(0xFF5856D6)],
                ),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Text(
                'MR',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Morgan Rivera',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: context.label,
                      letterSpacing: 0.3,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Apple ID, iCloud, Media & Purchases',
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
            Icon(
              CupertinoIcons.chevron_right,
              size: 13,
              color: context.label3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroup(
    BuildContext context, {
    required String header,
    required String? footer,
    required List<Widget> rows,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 22, 32, 6),
            child: Text(
              header.toUpperCase(),
              style: TextStyle(
                fontSize: 13,
                color: context.label2,
                letterSpacing: -0.08,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(children: rows),
            ),
          ),
          if (footer != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 8, 32, 0),
              child: Text(
                footer,
                style: TextStyle(
                  fontSize: 13,
                  color: context.label2,
                  letterSpacing: -0.08,
                  height: 1.3,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── iOS inset grouped row ─────────────────────────────────────
class _IOSRow extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String? detail;
  final bool? toggle;
  final ValueChanged<bool>? onToggle;
  final bool chev;
  final bool isLast;

  const _IOSRow({
    required this.icon,
    required this.iconBg,
    required this.title,
    this.detail,
    this.toggle,
    this.onToggle,
    this.chev = false,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle != null
          ? () => onToggle?.call(!(toggle!))
          : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: context.cardBg,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          children: [
            SizedBox(
              height: 44,
              child: Row(
                children: [
                  Container(
                    width: 29,
                    height: 29,
                    decoration: BoxDecoration(
                      color: iconBg,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Icon(icon, size: 17, color: CupertinoColors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 17,
                        color: context.label,
                        letterSpacing: -0.43,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  if (detail != null) ...[
                    Text(
                      detail!,
                      style: TextStyle(
                        fontSize: 17,
                        color: context.label2,
                        letterSpacing: -0.43,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                  if (toggle != null)
                    CupertinoSwitch(
                      value: toggle!,
                      onChanged: onToggle,
                    )
                  else if (chev)
                    Icon(
                      CupertinoIcons.chevron_right,
                      size: 13,
                      color: context.label3,
                    ),
                ],
              ),
            ),
            if (!isLast)
              Container(
                height: 0.33,
                margin: const EdgeInsets.only(left: 57),
                color: context.sep,
              ),
          ],
        ),
      ),
    );
  }
}
