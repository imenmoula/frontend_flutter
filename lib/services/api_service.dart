import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Room.dart';

class RoomService {
  final String baseUrl = 'http://10.0.2.2:3060/rooms';

  // Récupérer toutes les rooms
  Future<List<Room>> getRooms() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Room.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  // Ajouter une room
  Future<void> addRoom(Room room) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(room.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add room');
    }
  }

  // Mettre à jour une room
  Future<void> updateRoom(Room room) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${room.roomId}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(room.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update room');
    }
  }

  // Supprimer une room
  Future<void> deleteRoom(String roomId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$roomId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete room');
    }
  }
}
