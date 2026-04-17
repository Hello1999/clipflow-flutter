enum TransferStatus { active, done, paused }

class Transfer {
  final String id;
  final String name;
  final String size;
  final String from;
  final String to;
  final double progress;
  final TransferStatus status;
  final String? speed;
  final String? remaining;

  const Transfer({
    required this.id,
    required this.name,
    required this.size,
    required this.from,
    required this.to,
    required this.progress,
    required this.status,
    this.speed,
    this.remaining,
  });
}

final Transfer activeTransfer = const Transfer(
  id: 'active',
  name: 'Keynote_Q2.sketch',
  size: '148.2 MB',
  from: 'MacBook',
  to: 'iPhone',
  progress: 0.67,
  status: TransferStatus.active,
  speed: '12.4 MB/s',
  remaining: '4s remaining',
);

final List<Transfer> recentTransfers = [
  const Transfer(
    id: '1',
    name: 'brand-guidelines.pdf',
    size: '4.2 MB',
    from: 'iPad',
    to: 'iPhone',
    progress: 1.0,
    status: TransferStatus.done,
  ),
  const Transfer(
    id: '2',
    name: 'studio_shot.png',
    size: '12.8 MB',
    from: 'iPhone',
    to: 'MacBook',
    progress: 1.0,
    status: TransferStatus.done,
  ),
  const Transfer(
    id: '3',
    name: 'onboarding.mov',
    size: '284 MB',
    from: 'MacBook',
    to: 'iPad',
    progress: 0.42,
    status: TransferStatus.paused,
  ),
];
