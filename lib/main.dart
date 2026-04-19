import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/m3_theme.dart';
import 'theme/m3_colors.dart';
import 'screens/feed_screen.dart';
import 'screens/transfer_screen.dart';
import 'screens/devices_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  runApp(const ClipFlowApp());
}

class ClipFlowApp extends StatefulWidget {
  const ClipFlowApp({super.key});

  @override
  State<ClipFlowApp> createState() => _ClipFlowAppState();
}

class _ClipFlowAppState extends State<ClipFlowApp> {
  bool _isDark = false;

  void _toggleTheme() => setState(() => _isDark = !_isDark);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClipFlow',
      debugShowCheckedModeBanner: false,
      theme: M3Theme.light(),
      darkTheme: M3Theme.dark(),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: MainShell(isDark: _isDark, onToggleTheme: _toggleTheme),
    );
  }
}

class MainShell extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const MainShell({super.key, required this.isDark, required this.onToggleTheme});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  static const _fabDefs = [
    _FabDef(icon: Icons.add, label: 'New'),
    _FabDef(icon: Icons.upload_outlined, label: 'Send'),
    _FabDef(icon: Icons.add, label: 'Add'),
    null,
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final surf2 = M3Colors.surface2(cs);
    final fab = _fabDefs[_selectedIndex];

    return Scaffold(
      backgroundColor: cs.background,
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            const FeedScreen(),
            const TransferScreen(),
            const DevicesScreen(),
            SettingsScreen(
              isDark: widget.isDark,
              onToggleTheme: widget.onToggleTheme,
            ),
          ],
        ),
      ),
      floatingActionButton: fab == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () {},
              backgroundColor: cs.primaryContainer,
              foregroundColor: cs.onPrimaryContainer,
              elevation: 3,
              icon: Icon(fab.icon),
              label: Text(
                fab.label,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: surf2,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.content_paste_outlined),
            selectedIcon: Icon(Icons.content_paste),
            label: 'Feed',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined),
            selectedIcon: Icon(Icons.folder),
            label: 'Transfer',
          ),
          NavigationDestination(
            icon: Icon(Icons.devices_outlined),
            selectedIcon: Icon(Icons.devices),
            label: 'Devices',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class _FabDef {
  final IconData icon;
  final String label;
  const _FabDef({required this.icon, required this.label});
}
