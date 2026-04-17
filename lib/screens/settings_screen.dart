import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/screen_header.dart';
import '../widgets/app_status_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _universalClipboard = true;
  bool _e2eEncryption = true;
  bool _excludePasswords = true;
  bool _localNetworkOnly = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppStatusBar(),
          const ScreenHeader(
            pretitle: 'ACCOUNT',
            title: 'Settings',
            sub: 'v2.4.1 · build 8812',
          ),
          // Profile card
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: GlassCard(
              strong: true,
              borderRadius: BorderRadius.circular(22),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [kTeal, kBlue],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'MR',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: kTealDark,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Morgan Rivera',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'morgan@rivera.studio',
                          style: TextStyle(
                            fontSize: 12,
                            color: kWhite45,
                            fontFamily: 'Courier',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: kTealDim,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'PRO',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: kTeal,
                        fontFamily: 'Courier',
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Settings groups
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 120),
              children: [
                _SettingsGroup(
                  label: 'Sync',
                  children: [
                    _SettingsRow(
                      icon: Icons.bolt_outlined,
                      iconColor: const Color(0xFF22E0C8).withOpacity(0.15),
                      title: 'Universal Clipboard',
                      toggleValue: _universalClipboard,
                      onToggle: (v) => setState(() => _universalClipboard = v),
                    ),
                    _SettingsRow(
                      icon: Icons.cloud_outlined,
                      iconColor: Colors.white.withOpacity(0.08),
                      title: 'iCloud Backup',
                      detail: 'Enabled',
                    ),
                    _SettingsRow(
                      icon: Icons.history,
                      iconColor: Colors.white.withOpacity(0.08),
                      title: 'History Retention',
                      detail: '30 days',
                      isLast: true,
                    ),
                  ],
                ),
                _SettingsGroup(
                  label: 'Privacy',
                  children: [
                    _SettingsRow(
                      icon: Icons.lock_outline,
                      iconColor: Colors.white.withOpacity(0.08),
                      title: 'End-to-End Encryption',
                      toggleValue: _e2eEncryption,
                      onToggle: (v) => setState(() => _e2eEncryption = v),
                    ),
                    _SettingsRow(
                      icon: Icons.shield_outlined,
                      iconColor: Colors.white.withOpacity(0.08),
                      title: 'Exclude Passwords',
                      toggleValue: _excludePasswords,
                      onToggle: (v) => setState(() => _excludePasswords = v),
                    ),
                    _SettingsRow(
                      icon: Icons.notifications_outlined,
                      iconColor: Colors.white.withOpacity(0.08),
                      title: 'Sync Notifications',
                      detail: 'Silent',
                      isLast: true,
                    ),
                  ],
                ),
                _SettingsGroup(
                  label: 'Advanced',
                  children: [
                    _SettingsRow(
                      icon: Icons.wifi,
                      iconColor: Colors.white.withOpacity(0.08),
                      title: 'Local Network Only',
                      toggleValue: _localNetworkOnly,
                      onToggle: (v) => setState(() => _localNetworkOnly = v),
                      isLast: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final String label;
  final List<Widget> children;

  const _SettingsGroup({required this.label, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
            child: Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: kWhite45,
                letterSpacing: 1,
                fontFamily: 'Courier',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GlassCard(
              borderRadius: BorderRadius.circular(18),
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
  final Color iconColor;
  final String title;
  final String? detail;
  final bool? toggleValue;
  final ValueChanged<bool>? onToggle;
  final bool isLast;

  const _SettingsRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.detail,
    this.toggleValue,
    this.onToggle,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleValue != null ? () => onToggle?.call(!toggleValue!) : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(0.06),
                    width: 0.5,
                  ),
                ),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.white.withOpacity(0.06),
                  width: 0.5,
                ),
              ),
              child: Icon(icon, size: 15, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  letterSpacing: -0.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (detail != null) ...[
              Text(
                detail!,
                style: TextStyle(
                  fontSize: 13,
                  color: kWhite45,
                  fontFamily: 'Courier',
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right, size: 14, color: kWhite30),
            ],
            if (toggleValue != null)
              _Toggle(value: toggleValue!, onChanged: onToggle ?? (_) {}),
          ],
        ),
      ),
    );
  }
}

class _Toggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _Toggle({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 42,
        height: 24,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: value ? kTeal : Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
