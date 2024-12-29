import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/weatherModel.dart';
import 'package:http/http.dart' as http;

class HomeController extends ChangeNotifier {
  WeatherModel? responseData;

  Future fetchData(String city_name, context) async {
    responseData = null;
    print("City name: $city_name");

    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city_name&appid=86666cddd625e7cdd81533161bba41e2&units=metric');

    try {
      var response = await http.get(url);
      if (response.statusCode == 404) {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 100,
              width: double.infinity,
              child: Center(
                child: Text("Invalid city name! Please try again."),
              ),
            );
          },
        );
      } else if (response.statusCode == 200) {
        print("Response Body: ${response.body}");
        responseData = WeatherModel.fromJson(jsonDecode(response.body));
        print("Response Data: $responseData");
      } else {
        print(
            "Failed to load weather data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
    notifyListeners();
  }
}
