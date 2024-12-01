import 'dart:convert';
import 'package:dis_app/utils/http/http_client.dart';
import 'package:dis_app/models/cart_model.dart';

class CartController {
  Future<Map<String, dynamic>> addToCart(AddItemRequest request) async {
    try {
      final response = await DisHttpClient.post('cart', request.toJson());
      if (response['data'] == null) {
        throw Exception(response['errors'] ?? 'Unknown error occurred');
      }
      return response['data'];
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  Future<Map<String, dynamic>> removeFromCart(RemoveItemRequest request) async {
    try {
      final response = await DisHttpClient.delete('cart/${request.photoId}');
      if (response['data'] == null) {
        throw Exception(response['errors'] ?? 'Unknown error occurred');
      }
      return response['data'];
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }

  Future<Map<String, dynamic>> listCartItems(ListItemsRequest request) async {
    try {
      final queryParams = request.toQueryParams();
      final response = await DisHttpClient.get('cart?$queryParams');
      if (response['data'] == null) {
        throw Exception(response['errors'] ?? 'Unknown error occurred');
      }
      return response;
    } catch (e) {
      throw Exception('Failed to list cart items: $e');
    }
  }
}
