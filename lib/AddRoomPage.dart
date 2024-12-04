import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetable_app/services/api_service.dart';

class AddRoomPage extends StatefulWidget {
  final Map<String, dynamic>? room;

  AddRoomPage({this.room}); // Accept room data for editing

  @override
  _AddRoomPageState createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

  late String roomId;
  late String roomName;
  late int capacity;
  late String building;
  late int floor;

  @override
  void initState() {
    super.initState();
    if (widget.room != null) {
      roomId = widget.room!['room_id'];
      roomName = widget.room!['room_name'];
      capacity = widget.room!['capacity'];
      building = widget.room!['building'];
      floor = widget.room!['floor'];
    } else {
      roomId = '';
      roomName = '';
      capacity = 0;
      building = '';
      floor = 0;
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final data = {
        'room_id': roomId,
        'room_name': roomName,
        'capacity': capacity,
        'building': building,
        'floor': floor,
      };

      final success = widget.room == null
          ? await apiService.addRoom(roomId, roomName, capacity, building, floor)
          : await apiService.editRoom(roomId, data);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Room saved successfully!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save room.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.room == null ? 'Add Room' : 'Edit Room')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: roomName,
                decoration: InputDecoration(labelText: 'Room Name'),
                onSaved: (value) => roomName = value!,
                validator: (value) => value!.isEmpty ? 'Please enter Room Name' : null,
              ),
              // Add other form fields here...
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.room == null ? 'Add Room' : 'Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
