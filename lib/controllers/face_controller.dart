import 'package:dis_app/models/face_model.dart';
import 'package:dis_app/utils/http/http_client.dart';

class FaceController {
  Future<List<MatchedPhoto>> getMatchedPhotos(String userId) async {
    try {
      final response = await DisHttpClient.findMe(userId);
      final List<dynamic> matchedPhotosJson = response['data'];
      if (matchedPhotosJson is List) {
        return matchedPhotosJson
            .map((json) => MatchedPhoto.fromJson(json))
            .toList();
      } else {
        throw Exception('Unexpected data format: ${response['data']}');
      }
    } catch (e) {
      throw Exception('Error fetching matched photos: $e');
    }
  }
}
