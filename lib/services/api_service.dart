import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Room.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3060';

  // Fetch rooms from the API
  Future<List<Room>> fetchRooms() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/rooms'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((room) => Room.fromJson(room)).toList();
      } else {
        throw Exception('Failed to load rooms, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching rooms: $e');
    }
  }

  // Add a new room
  Future<bool> addRoom(String roomId, String roomName, int capacity, String building, int floor) async {
    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2:3060/rooms'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'room_id': roomId,
          'room_name': roomName,
          'capacity': capacity,
          'building': building,
          'floor': floor,
        }),
      );

      print('Réponse du serveur : ${response.body}');  // Affiche le corps de la réponse

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Erreur avec le statut ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erreur lors de l\'ajout de la salle : $e');
      return false;
    }
  }

  // Delete a room
  Future<bool> deleteRoom(String roomId) async {
    final response = await http.delete(Uri.parse('$baseUrl/rooms/$roomId'));

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Error deleting room: ${response.body}');
      return false;
    }
  }

  // Edit a room
  Future<bool> editRoom(String roomId, Map<String, dynamic> data) async {
    try {
      // Make an HTTP PUT request to edit the room (ensure your endpoint and data are correct)
      var response = await http.put(
        Uri.parse('http://10.0.2.2:3060/rooms/$roomId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error editing room: $e');
      return false;
    }
  }
}