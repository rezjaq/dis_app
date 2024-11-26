import 'dart:convert';
import 'package:dis_app/utils/http/http_client.dart';
import 'package:dis_app/models/cart_model.dart';

class CartController {
  Future<Map<String, dynamic>> addToCart(AddToCartRequest request) async {
    try {
      final response = await DisHttpClient.post('cart', request.toJson());
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response['data'];
      }
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  Future<Map<String, dynamic>> removeFromCart(RemoveFromCartRequest request) async {
    try {
      final response = await DisHttpClient.delete('cart/${request.id}');
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response['data'];
      }
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }

  Future<Map<String, dynamic>> updateCart(UpdateCartRequest request) async {
    try {
      final response = await DisHttpClient.patch('cart/${request.id}', request.toJson());
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response['data'];
      }
    } catch (e) {
      throw Exception('Failed to update cart: $e');
    }
  }

  Future<Map<String, dynamic>> getCart(GetCartRequest request) async {
    try {
      final response = await DisHttpClient.get('cart/${request.userId}');
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response['data'];
      }
    } catch (e) {
      throw Exception('Failed to get cart: $e');
    }
  }

  Future<Map<String, dynamic>> listCartItems(ListCartRequest request) async {
    try {
      final queryParams = request.toQueryParams();
      final response = await DisHttpClient.get('cart?$queryParams');
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response;
      }
    } catch (e) {
      throw Exception('Failed to list cart items: $e');
    }
  }
}
