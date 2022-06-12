import 'package:dio/dio.dart';
import 'package:flutter_zartek_test/core/model/restaurant_menu.dart';

class APIRepository {
  Future<List<RestaurantMenu>> getRestaurantMenu() async {
    List<RestaurantMenu> posts = [];
    Dio dio = Dio();
    Response response =
        await dio.get('https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad');

    if (response.statusCode == 200) {
      final jsonResponse = response.data;
      if (jsonResponse is List<dynamic> && jsonResponse.isNotEmpty) {
        for (dynamic element in jsonResponse) {
          posts.add(RestaurantMenu.fromJson(element));
        }
      }

      return posts;
    }

    return [];
  }
}
