import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/radio_model.dart';

class RadioRepository {
  Future<List<RadioModel>> fetchRadios() async {
    final url = Uri.parse('https://www.mp3quran.net/api/v3/radios?language=ar');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List radios = data['radios'];
      return radios.map((e) => RadioModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load radios');
    }
  }
}
