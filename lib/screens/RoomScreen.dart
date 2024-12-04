// lib/screens/room_screen.dart

import 'package:flutter/material.dart';

import 'ApiService.dart';
import 'Room.dart';


class RoomScreen extends StatefulWidget {
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Room>> rooms;

  @override
  void initState() {
    super.initState();
    rooms = apiService.getRooms();
  }

  // Function to add a room (triggered from UI)
  void _addRoom() async {
    final newRoom = Room(
      roomId: 0,
      roomName: 'New Room',
      capacity: 30,
      building: 'Building A',
      floor: '1st',
    );
    await apiService.addRoom(newRoom);
    setState(() {
      rooms = apiService.getRooms(); // Refresh rooms list
    });
  }

  // Function to delete a room
  void _deleteRoom(int roomId) async {
    await apiService.deleteRoom(roomId);
    setState(() {
      rooms = apiService.getRooms(); // Refresh rooms list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rooms'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addRoom,
          ),
        ],
      ),
      body: FutureBuilder<List<Room>>(
        future: rooms,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No rooms available.'));
          } else {
            final rooms = snapshot.data!;
            return ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                final room = rooms[index];
                return ListTile(
                  title: Text(room.roomName),
                  subtitle: Text('Capacity: ${room.capacity}'),
                  onTap: () {
                    // Navigate or handle room details
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteRoom(room.roomId),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
