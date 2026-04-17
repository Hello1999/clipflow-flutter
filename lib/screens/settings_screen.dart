import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;

  const SettingsScreen({
    super.key,
    required this.onToggleTheme,
    required this.themeMode,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _universalClipboard = true;
  bool _e2eEncryption = true;
  bool _excludePasswords = true;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final isDark = widget.themeMode == ThemeMode.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Settings'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'v2.4.1 · build 8812',
                    style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                  ),
                  const SizedBox(height: 24),
                  // Profile card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cs.secondaryContainer,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: cs.primary,
                          child: Text(
                            'MR',
                            style: tt.titleMedium?.copyWith(
                              color: cs.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Morgan Rivera',
                                style: tt.titleMedium?.copyWith(
                                  color: cs.onSecondaryContainer,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'morgan@rivera.studio',
                                style: tt.bodySmall?.copyWith(
                                  color: cs.onSecondaryContainer.withValues(alpha: 0.75),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: cs.tertiaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'PRO',
                            style: tt.labelSmall?.copyWith(
                              color: cs.onTertiaryContainer,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Sync group
                  _SettingsGroup(
                    label: 'SYNC',
                    children: [
                      _SettingsRow(
                        icon: Icons.bolt_outlined,
                        title: 'Universal Clipboard',
                        trailing: Switch(
                          value: _universalClipboard,
                          onChanged: (v) => setState(() => _universalClipboard = v),
                        ),
                      ),
                      _SettingsRow(
                        icon: Icons.cloud_outlined,
                        title: 'Cloud Backup',
                        detail: 'Enabled',
                        onTap: () {},
                      ),
                      _SettingsRow(
                        icon: Icons.history,
                        title: 'History',
                        detail: '30 days',
                        onTap: () => _showHistoryPicker(context),
                        isLast: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Privacy group
                  _SettingsGroup(
                    label: 'PRIVACY',
                    children: [
                      _SettingsRow(
                        icon: Icons.lock_outline,
                        title: 'End-to-End Encryption',
                        trailing: Switch(
                          value: _e2eEncryption,
                          onChanged: (v) => setState(() => _e2eEncryption = v),
                        ),
                      ),
                      _SettingsRow(
                        icon: Icons.security_outlined,
                        title: 'Exclude Passwords',
                        trailing: Switch(
                          value: _excludePasswords,
                          onChanged: (v) => setState(() => _excludePasswords = v),
                        ),
                      ),
                      _SettingsRow(
                        icon: Icons.notifications_outlined,
                        title: 'Notifications',
                        detail: 'Silent',
                        onTap: () {},
                        isLast: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Appearance group
                  _SettingsGroup(
                    label: 'APPEARANCE',
                    children: [
                      _SettingsRow(
                        icon: isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                        title: 'Dark Mode',
                        trailing: Switch(
                          value: isDark,
                          onChanged: (_) => widget.onToggleTheme(),
                        ),
                        isLast: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // About group
                  _SettingsGroup(
                    label: 'ABOUT',
                    children: [
                      _SettingsRow(
                        icon: Icons.info_outline,
                        title: 'Version',
                        detail: '2.4.1 (8812)',
                        onTap: () {},
                      ),
                      _SettingsRow(
                        icon: Icons.privacy_tip_outlined,
                        title: 'Privacy Policy',
                        onTap: () {},
                      ),
                      _SettingsRow(
                        icon: Icons.logout,
                        title: 'Sign Out',
                        onTap: () => _confirmSignOut(context),
                        isLast: true,
                        destructive: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showHistoryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        final options = ['7 days', '14 days', '30 days', '90 days', 'Unlimited'];
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text('History Duration',
                      style: Theme.of(ctx).textTheme.titleMedium),
                ),
                ...options.map(
                  (o) => ListTile(
                    title: Text(o),
                    trailing: o == '30 days'
                        ? Icon(Icons.check, color: cs.primary)
                        : null,
                    onTap: () => Navigator.pop(ctx),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmSignOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out? Your clipboard history will be cleared.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
            ),
            child: const Text('Sign Out'),
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
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            label,
            style: tt.labelSmall?.copyWith(
              color: cs.primary,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: cs.surfaceContainerLow,
            borderRadius: BorderRadius.circular(28),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? detail;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isLast;
  final bool destructive;

  const _SettingsRow({
    required this.icon,
    required this.title,
    this.detail,
    this.trailing,
    this.onTap,
    this.isLast = false,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final color = destructive ? cs.error : cs.onSurface;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              children: [
                Icon(icon, size: 22, color: destructive ? cs.error : cs.onSurfaceVariant),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: tt.bodyLarge?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                if (detail != null)
                  Text(
                    detail!,
                    style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ?trailing,
                if (onTap != null && trailing == null && detail == null)
                  Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
              ],
            ),
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            indent: 56,
            color: cs.outlineVariant.withValues(alpha: 0.5),
          ),
      ],
    );
  }
}
