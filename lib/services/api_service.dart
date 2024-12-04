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
    final url = Uri.parse('$baseUrl/rooms');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'room_id': roomId,
        'room_name': roomName,
        'capacity': capacity,
        'building': building,
        'floor': floor,
      }),
    );

    if (response.statusCode == 201) {
      return true; // Success
    } else {
      print('Error: ${response.body}');
      return false; // Failure
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
  Future<bool> editRoom(String roomId, Map<String, Object?> roomData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/rooms/$roomId'),
      body: jsonEncode(roomData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Error editing room: ${response.body}');
      return false;
    }
  }
}