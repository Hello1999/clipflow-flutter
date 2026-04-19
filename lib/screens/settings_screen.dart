import 'package:flutter/material.dart';
import '../widgets/m3_status_bar.dart';
import '../widgets/m3_header.dart';
import '../theme/m3_colors.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const SettingsScreen({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _universalClipboard = true;
  bool _e2eEncryption = true;
  bool _excludePasswords = true;
  bool _localNetwork = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final surf1 = M3Colors.surface1(cs);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const M3StatusBar(),
        const M3Header(title: 'Settings', meta: 'v2.4.1 · build 8812'),
        // Profile card
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Material(
            color: cs.secondaryContainer,
            borderRadius: BorderRadius.circular(28),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: cs.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'MR',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: cs.onPrimary,
                        ),
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
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: cs.onSecondaryContainer,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'morgan@rivera.studio',
                          style: TextStyle(
                            fontSize: 13,
                            color: cs.onSecondaryContainer.withValues(alpha: 0.75),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: cs.tertiaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'PRO',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: cs.onTertiaryContainer,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Settings list
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 100),
            children: [
              _SettingsGroup(
                label: 'Sync',
                labelColor: cs.primary,
                surf1: surf1,
                children: [
                  _SettingsRow(
                    icon: Icons.bolt_outlined,
                    title: 'Universal Clipboard',
                    toggleValue: _universalClipboard,
                    onToggle: (v) => setState(() => _universalClipboard = v),
                    cs: cs,
                  ),
                  _SettingsRow(
                    icon: Icons.cloud_outlined,
                    title: 'Cloud Backup',
                    detail: 'Enabled',
                    cs: cs,
                  ),
                  _SettingsRow(
                    icon: Icons.history,
                    title: 'History',
                    detail: '30 days',
                    cs: cs,
                    isLast: true,
                  ),
                ],
              ),
              _SettingsGroup(
                label: 'Privacy',
                labelColor: cs.primary,
                surf1: surf1,
                children: [
                  _SettingsRow(
                    icon: Icons.lock_outline,
                    title: 'End-to-End Encryption',
                    toggleValue: _e2eEncryption,
                    onToggle: (v) => setState(() => _e2eEncryption = v),
                    cs: cs,
                  ),
                  _SettingsRow(
                    icon: Icons.shield_outlined,
                    title: 'Exclude Passwords',
                    toggleValue: _excludePasswords,
                    onToggle: (v) => setState(() => _excludePasswords = v),
                    cs: cs,
                  ),
                  _SettingsRow(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    detail: 'Silent',
                    cs: cs,
                    isLast: true,
                  ),
                ],
              ),
              _SettingsGroup(
                label: 'Advanced',
                labelColor: cs.primary,
                surf1: surf1,
                children: [
                  _SettingsRow(
                    icon: Icons.wifi_outlined,
                    title: 'Local Network Only',
                    toggleValue: _localNetwork,
                    onToggle: (v) => setState(() => _localNetwork = v),
                    cs: cs,
                  ),
                  _SettingsRow(
                    icon: widget.isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                    title: widget.isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                    cs: cs,
                    onTap: widget.onToggleTheme,
                    isLast: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final String label;
  final Color labelColor;
  final Color surf1;
  final List<Widget> children;

  const _SettingsGroup({
    required this.label,
    required this.labelColor,
    required this.surf1,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
            child: Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
                color: labelColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Material(
              color: surf1,
              borderRadius: BorderRadius.circular(28),
              clipBehavior: Clip.antiAlias,
              child: Column(children: children),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? detail;
  final bool? toggleValue;
  final ValueChanged<bool>? onToggle;
  final VoidCallback? onTap;
  final bool isLast;
  final ColorScheme cs;

  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.cs,
    this.detail,
    this.toggleValue,
    this.onToggle,
    this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleValue != null ? () => onToggle?.call(!toggleValue!) : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: cs.outlineVariant,
                    width: 0.5,
                  ),
                ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 22, color: cs.onSurfaceVariant),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: cs.onSurface,
                ),
              ),
            ),
            if (detail != null) ...[
              Text(
                detail!,
                style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
              ),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right, size: 18, color: cs.onSurfaceVariant),
            ],
            if (toggleValue != null)
              Switch(
                value: toggleValue!,
                onChanged: onToggle,
              ),
          ],
        ),
      ),
    );
  }
}
