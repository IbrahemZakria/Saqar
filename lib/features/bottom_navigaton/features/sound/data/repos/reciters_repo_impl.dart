import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saqar/features/bottom_navigaton/features/sound/domain/entities/moshaf_entity.dart';
import 'package:saqar/features/bottom_navigaton/features/sound/domain/entities/reciter_entity.dart';

class RecitersRepoImpl {
  static const String _baseUrl =
      'https://www.mp3quran.net/api/v3/reciters?language=ar';

  /// Fetch all reciters from the API
  Future<List<ReciterEntity>> fetchReciters() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List recitersData = data['reciters'];

        return recitersData.map((e) {
          final moshafs = (e['moshaf'] as List)
              .map(
                (m) => MoshafEntity(
                  id: m['id'],
                  name: m['name'],
                  server: m['server'],
                  surahList: m['surah_list'],
                ),
              )
              .toList();

          return ReciterEntity(
            id: e['id'],
            name: e['name'],
            letter: e['letter'],
            moshaf: moshafs,
          );
        }).toList();
      } else {
        throw Exception('Failed to load reciters: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching reciters: $e');
    }
  }
}
