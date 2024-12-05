import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dis_app/models/photo_model.dart';
import 'package:dis_app/utils/http/http_client.dart';

class PhotoController {
  Future<Map<String, dynamic>> addSellPhoto(AddSellPhotoRequest request) async {
    try {
      final multipartRequest = await DisHttpClient.multipartRequest('photo/sell', 'POST');
      multipartRequest.fields['name'] = request.name;
      multipartRequest.fields['basePrice'] = request.basePrice.toString();
      multipartRequest.fields['sellPrice'] = request.sellPrice.toString();
      multipartRequest.fields['description'] = request.description;
      multipartRequest.files.add(await http.MultipartFile.fromPath('file', request.file.path));
      final response = await multipartRequest.send();
      final responseData = await response.stream.bytesToString();
      return json.decode(responseData);
    } catch (e) {
      throw Exception('Failed to add sell photo: $e');
    }
  }

  Future<Map<String, dynamic>> addPostPhoto(AddPostPhotoRequest request) async {
    try {
      final multipartRequest = await DisHttpClient.multipartRequest('photo/post', 'POST');
      multipartRequest.fields['description'] = request.description;
      multipartRequest.files.add(await http.MultipartFile.fromPath('file', request.file.path));
      final response = await multipartRequest.send();
      final responseData = await response.stream.bytesToString();
      final data = json.decode(responseData);
      if (data['data'] == null) {
        throw data['errors'];
      } else {
        return data['data'];
      }
    } catch (e) {
      throw Exception('Failed to add post photo: $e');
    }
  }

  Future<Map<String, dynamic>> get(GetPhotoRequest request) async {
    try {
      final response = await DisHttpClient.get('photo/${request.id}');
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response['data'];
      }
    } catch (e) {
      throw Exception('Failed to get photo: $e');
    }
  }

  Future<Map<String, dynamic>> list(ListPhotoRequest request) async {
    try {
      final queryParams = request.toQueryParams();
      final response = await DisHttpClient.get('photo?$queryParams');
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response;
      }
    } catch (e) {
      throw Exception('Failed to list photo: $e');
    }
  }

  Future<Map<String, dynamic>> updateSell(UpdateSellPhotoRequest request) async {
    try {
      final response = await DisHttpClient.patch('photo/sell/${request.id}', request.toJson());
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response['data'];
      }
    } catch (e) {
      throw Exception('Failed to update sell photo: $e');
    }
  }

  Future<Map<String, dynamic>> updatePost(UpdatePostPhotoRequest request) async {
    try {
      final response = await DisHttpClient.patch('photo/post/${request.id}', request.toJson());
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response['data'];
      }
    } catch (e) {
      throw Exception('Failed to update post photo: $e');
    }
  }

  Future<Map<String, dynamic>> likePost(LikePhotoPostRequest request) async {
    try {
      final response = await DisHttpClient.post('photo/like/${request.id}', request.toJson());
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response['data'];
      }
    } catch (e) {
      throw Exception('Failed to like post photo: $e');
    }
  }

  Future<Map<String, dynamic>> samplePost() async {
    try {
      final response = await DisHttpClient.get('photo/post/sample');
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response;
      }
    } catch (e) {
      throw Exception('Failed to sample post photo: $e');
    }
  }

  Future<Map<String, dynamic>> collectionPhoto(CollectionPhotoRequest request) async {
    try {
      final response = await DisHttpClient.get('photo/collection/');
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response;
      }
    } catch (e) {
      throw Exception('Failed to collection photo: $e');
    }
  }

  Future<Map<String, dynamic>> findmePhoto() async {
    try {
      final response = await DisHttpClient.get('photo/sell/findme');
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response;
      }
    } catch (e) {
      throw Exception('Failed to findme photo: $e');
    }
  }
}