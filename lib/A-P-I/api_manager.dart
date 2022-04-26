import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tenor_gifs/constants/string_urls.dart';
import 'package:tenor_gifs/models/tenor_moddel.dart';

class ApiManager {
  static Future<ApIjson> getGifs(String query) async {
    var client = http.Client();
    ApIjson gif_model;
    try {
      var response = await client.get(Uri.parse(
          'https://g.tenor.com/v1/search?q=+""+$query+&key=KMI4ETZYJ511'));
      if (response.statusCode == 200) {
        print(response.body);
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        gif_model = ApIjson.fromJson(jsonMap);
        print(gif_model.next);
        return gif_model;
      }
    } catch (Exception) {
      return gif_model;
    }

    return gif_model;
  }
}
