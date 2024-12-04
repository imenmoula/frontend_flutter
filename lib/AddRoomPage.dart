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

      print('Données envoyées : $data'); // Vérification des données envoyées

      bool success;

      // Appel de la méthode d'ajout ou d'édition de salle
      if (widget.room == null) {
        success = await apiService.addRoom(roomId, roomName, capacity, building, floor);
      } else {
        success = await apiService.editRoom(roomId, data);
      }

      // Affichage du résultat
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Room saved successfully!')),
        );
        Navigator.pop(context);  // Retour à l'écran précédent
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
              TextFormField(
                initialValue: capacity.toString(),
                decoration: InputDecoration(labelText: 'Capacity'),
                keyboardType: TextInputType.number,
                onSaved: (value) => capacity = int.parse(value!),
                validator: (value) => value!.isEmpty ? 'Please enter Capacity' : null,
              ),
              TextFormField(
                initialValue: building,
                decoration: InputDecoration(labelText: 'Building'),
                onSaved: (value) => building = value!,
                validator: (value) => value!.isEmpty ? 'Please enter Building' : null,
              ),
              TextFormField(
                initialValue: floor.toString(),
                decoration: InputDecoration(labelText: 'Floor'),
                keyboardType: TextInputType.number,
                onSaved: (value) => floor = int.parse(value!),
                validator: (value) => value!.isEmpty ? 'Please enter Floor' : null,
              ),
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
