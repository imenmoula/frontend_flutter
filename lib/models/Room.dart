class Room {
  final int roomId;
  final String roomName;
  final int capacity;
  final String building;
  final String floor;

  Room({required this.roomId, required this.roomName, required this.capacity, required this.building, required this.floor});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomId: json['room_id'],
      roomName: json['room_name'],
      capacity: json['capacity'],
      building: json['building'],
      floor: json['floor'],
    );
  }
}
