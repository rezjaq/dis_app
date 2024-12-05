import 'dart:convert';
import 'dart:io';

import 'package:dis_app/models/face_model.dart';
import 'package:dis_app/utils/http/http_client.dart';
import 'package:http/http.dart' as http; // Needed for multipart

class FaceController {
  Future<Face> addFace(String userId, String filePath) async {
    try {
      var request = await DisHttpClient.multipartRequest('face/add', 'POST');
      request.fields['user_id'] = userId;
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();
      if (response.statusCode == 200) {
        var jsonResponse = await response.stream.bytesToString();
        return Face.fromJson(json.decode(jsonResponse));
      } else {
        throw Exception('Failed to add face: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding face: $e');
    }
  }

  // List faces with pagination
  Future<List<Face>> listFaces(String userId,
      {int page = 1, int size = 10}) async {
    try {
      final response = await DisHttpClient.get(
          'face/list?user_id=$userId&page=$page&size=$size');
      final List<dynamic> jsonResponse = response['data'];

      return jsonResponse.map((face) => Face.fromJson(face)).toList();
    } catch (e) {
      throw Exception('Error fetching face list: $e');
    }
  }

  // Delete a specific face
  Future<void> deleteFace(String faceId, String userId) async {
    try {
      final response = await DisHttpClient.delete('face/delete');
      final body = {'id': faceId, 'user_id': userId};

      await DisHttpClient.delete('face/delete');
      if (response['success'] == true) {
        return;
      } else {
        throw Exception('Failed to delete face');
      }
    } catch (e) {
      throw Exception('Error deleting face: $e');
    }
  }

  Future<Map<String, dynamic>> faceDetection(FaceDetectionRequest request) async {
    try {
      final multipartRequest = await DisHttpClient.multipartRequest('face/detect', 'POST');
      multipartRequest.files.add(await http.MultipartFile.fromPath('file', request.file.path));
      final response = await multipartRequest.send();
      final responseData = await response.stream.bytesToString();
      return json.decode(responseData);
    } catch (e) {
      throw Exception('Error detecting face: $e');
    }
  }
}
