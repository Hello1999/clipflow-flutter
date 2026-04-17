enum ClipType { text, link, code, image }

class ClipItem {
  final String id;
  final ClipType type;
  final String content;
  final String source;
  final String time;
  final bool isPinned;

  const ClipItem({
    required this.id,
    required this.type,
    required this.content,
    required this.source,
    required this.time,
    this.isPinned = false,
  });
}

final List<ClipItem> mockClips = [
  const ClipItem(
    id: '1',
    type: ClipType.link,
    content: 'figma.com/file/k3Mx9/ClipFlow',
    source: 'Safari · iPhone',
    time: 'just now',
    isPinned: true,
  ),
  const ClipItem(
    id: '2',
    type: ClipType.code,
    content: 'git checkout -b feat/share-sheet',
    source: 'Terminal · MacBook',
    time: '1m',
  ),
  const ClipItem(
    id: '3',
    type: ClipType.text,
    content: 'Move onboarding handoff to Thursday.',
    source: 'Notes · iPad',
    time: '14m',
  ),
  const ClipItem(
    id: '4',
    type: ClipType.text,
    content: 'Hotel confirmation: #A2-7841-22B',
    source: 'Messages',
    time: '1h',
  ),
  const ClipItem(
    id: '5',
    type: ClipType.link,
    content: 'https://linear.app/clipflow/issue/CLF-219',
    source: 'Safari · MacBook',
    time: '2h',
  ),
  const ClipItem(
    id: '6',
    type: ClipType.code,
    content: 'npx create-flutter-app my-app --template=material3',
    source: 'VS Code · MacBook',
    time: '3h',
  ),
  const ClipItem(
    id: '7',
    type: ClipType.text,
    content: 'Password reset PIN: 847291',
    source: 'Messages',
    time: '4h',
  ),
];
