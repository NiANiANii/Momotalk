import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class CharacterService {
  static const String baseUrl =
      'https://api-blue-archive.vercel.app/api/characters'; // ganti dengan URL aslinya

  static Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse('$baseUrl/api/characters'));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);

      final List<dynamic> dataList = jsonBody['data'];
      return dataList.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch characters');
    }
  }
}
