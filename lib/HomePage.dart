import 'package:flutter/material.dart';
import 'package:timetable_app/services/api_service.dart';
import 'AddRoomPage.dart';
import 'models/Room.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  late Future<List<Room>> _rooms;

  @override
  void initState() {
    super.initState();
    _rooms = _apiService.fetchRooms(); // This should now return Future<List<Room>>
  }

  void _refreshRooms() {
    setState(() {
      _rooms = _apiService.fetchRooms();
    });
  }

  void _editRoom(Room room) async {
    final roomId = room.roomId;

    // Construct the data to update
    final roomData = {
      'room_name': room.roomName,
      'capacity': room.capacity,
      'building': room.building,
      'floor': room.floor,
    };

    // Call the ApiService editRoom function
    final success = await _apiService.editRoom(roomId, roomData);

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

  void _deleteRoom(String roomId) async {
    final success = await _apiService.deleteRoom(roomId);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Room deleted successfully!')),
      );
      _refreshRooms();  // Refresh the room list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete room.')),
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
                                onPressed: () => _editRoom(room),  // Edit Room
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteRoom(room.roomId),  // Delete Room
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
