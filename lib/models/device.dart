enum DeviceType { phone, laptop, tablet, watch }
enum DeviceStatus { online, offline }

class Device {
  final String id;
  final String name;
  final String meta;
  final DeviceType type;
  final DeviceStatus status;
  final int? battery;
  final bool isThisDevice;

  const Device({
    required this.id,
    required this.name,
    required this.meta,
    required this.type,
    required this.status,
    this.battery,
    this.isThisDevice = false,
  });
}

final List<Device> mockDevices = [
  const Device(
    id: '1',
    name: 'Pixel 9 Pro',
    meta: 'Android 15 · syncing',
    type: DeviceType.phone,
    status: DeviceStatus.online,
    battery: 84,
    isThisDevice: true,
  ),
  const Device(
    id: '2',
    name: 'MacBook Pro',
    meta: 'macOS 16 · 4s ago',
    type: DeviceType.laptop,
    status: DeviceStatus.online,
    battery: 62,
  ),
  const Device(
    id: '3',
    name: 'Pixel Tablet',
    meta: 'Android 15 · 12s ago',
    type: DeviceType.tablet,
    status: DeviceStatus.online,
    battery: 91,
  ),
  const Device(
    id: '4',
    name: 'Pixel Watch 3',
    meta: 'Wear OS · offline',
    type: DeviceType.watch,
    status: DeviceStatus.offline,
  ),
];
