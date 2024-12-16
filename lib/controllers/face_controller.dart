import 'dart:convert';
import 'dart:io';

import 'package:dis_app/models/face_model.dart';
import 'package:dis_app/utils/http/http_client.dart';
import 'package:http/http.dart' as http;

class FaceController {
  Future<Face> addFace(String filePath) async {
    try {
      print('Starting addFace method...');
      print('File path: $filePath');
      var request = await DisHttpClient.multipartRequest('face/', 'POST');
      print('Request created: $request');

      var file = File(filePath);
      if (!await file.exists()) {
        throw Exception('File does not exist at path: $filePath');
      }

      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      print('File added to request: $filePath');

      var response = await request.send();
      print('Response status code: ${response.statusCode}');

      var responseBody = await response.stream.bytesToString();
      print('Response body: $responseBody');

      if (response.statusCode == 201) {
        var jsonResponse = json.decode(responseBody);
        if (jsonResponse['data'] != null && jsonResponse['data'] is Map) {
          var face = Face.fromJson(jsonResponse['data']);
          return face;
        } else {
          throw Exception('No valid data found in the response');
        }
      } else if (response.statusCode == 400 &&
          responseBody.contains('No face detected')) {
        throw Exception('No face detected in the image');
      } else {
        throw Exception(
            'Failed to add face: ${response.statusCode}, $responseBody');
      }
    } catch (e) {
      print('Error in addFace method: $e');
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

  Future<Map<String, dynamic>> faceDetection(
      FaceDetectionRequest request) async {
    print(
        '===========================================================================');
    print(request);
    try {
      final multipartRequest =
          await DisHttpClient.multipartRequest('face/', 'POST');
      multipartRequest.files
          .add(await http.MultipartFile.fromPath('file', request.file.path));
      print(
          'dammmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
      final response = await multipartRequest.send();
      final responseData = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseData);
      if (jsonResponse['data'] == null) {
        throw jsonResponse['errors'];
      } else {
        return jsonResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
