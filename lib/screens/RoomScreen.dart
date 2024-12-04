// lib/screens/room_screen.dart

import 'package:flutter/material.dart';

import '../models/Room.dart';


import 'package:flutter/material.dart';

import '../services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rooms App',
      home: RoomsScreen(),
    );
  }
}

class RoomsScreen extends StatefulWidget {
  @override
  _RoomsScreenState createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  late Future<List<Room>> futureRooms;

  @override
  void initState() {
    super.initState();
    futureRooms = ApiService().fetchRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rooms')),
      body: FutureBuilder<List<Room>>(
        future: futureRooms,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No rooms found.'));
          }

          List<Room> rooms = snapshot.data!;
          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(rooms[index].roomName),
                subtitle: Text('Capacity: ${rooms[index].capacity}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await ApiService().deleteRoom(rooms[index].roomId);
                    setState(() {
                      futureRooms = ApiService().fetchRooms();
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
