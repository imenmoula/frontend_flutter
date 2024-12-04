import 'package:flutter/material.dart';
import 'package:timetable_app/services/api_service.dart';
import 'AddRoomPage.dart';
import '../models/Room.dart'; // Ensure you import your Room model

class RoomListPage extends StatefulWidget {
  @override
  _RoomListPageState createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  final ApiService apiService = ApiService();
  late Future<List<Room>> _rooms; // Change to List<Room>

  @override
  void initState() {
    super.initState();
    _refreshRooms(); // Load rooms initially
  }

  void _refreshRooms() {
    setState(() {
      _rooms = apiService.fetchRooms(); // Fetch rooms again
    });
  }

  void _editRoom(Room room) async {
    final roomId = room.roomId; // Assuming roomId is a property of Room

    // Construct the data to update
    final roomData = {
      'room_name': room.roomName,
      'capacity': room.capacity,
      'building': room.building,
      'floor': room.floor,
    };

    print("Room data being sent to API: $roomData");  // Debugging line

    // Call the ApiService editRoom function
    final success = await apiService.editRoom(roomId, roomData);

    // Handle success/failure
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Room updated successfully!')),
      );
      _refreshRooms();  // Refresh the room list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update room.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rooms')),
      body: FutureBuilder<List<Room>>(
        future: _rooms,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No rooms found.'));
          }

          final rooms = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Room Name')),
                    DataColumn(label: Text('Capacity')),
                    DataColumn(label: Text('Building')),
                    DataColumn(label: Text('Floor')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: rooms.map((room) {
                    return DataRow(
                      cells: [
                        DataCell(Text(room.roomName)),
                        DataCell(Text(room.capacity.toString())),
                        DataCell(Text(room.building)),
                        DataCell(Text(room.floor.toString())),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _editRoom(room),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddRoomPage()),
                  ).then((_) => _refreshRooms());
                },
                child: Text('Add Room'),
              ),
            ],
          );
        },
      ),
    );
  }
}