import 'package:flutter/cupertino.dart';
import 'screens/clipboard_feed_screen.dart';
import 'screens/file_transfer_screen.dart';
import 'screens/devices_screen.dart';
import 'screens/settings_screen.dart';

void main() => runApp(const ClipFlowApp());

class ClipFlowApp extends StatelessWidget {
  const ClipFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'ClipFlow',
      debugShowCheckedModeBanner: false,
      home: _Shell(),
    );
  }
}

class _Shell extends StatelessWidget {
  const _Shell();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.doc_on_clipboard),
            activeIcon: Icon(CupertinoIcons.doc_on_clipboard_fill),
            label: 'Clipboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.arrow_up_arrow_down_circle),
            activeIcon: Icon(CupertinoIcons.arrow_up_arrow_down_circle_fill),
            label: 'Transfer',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.desktopcomputer),
            label: 'Devices',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.gear_alt),
            activeIcon: Icon(CupertinoIcons.gear_alt_fill),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (ctx, i) {
        switch (i) {
          case 0:
            return CupertinoTabView(builder: (_) => const ClipboardFeedScreen());
          case 1:
            return CupertinoTabView(builder: (_) => const FileTransferScreen());
          case 2:
            return CupertinoTabView(builder: (_) => const DevicesScreen());
          default:
            return CupertinoTabView(builder: (_) => const SettingsScreen());
        }
      },
    );
  }
}
