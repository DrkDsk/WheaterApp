import 'package:clima_app/features/home/data/models/weather_response_model.dart';

abstract class SearchWeatherDataSource {
  Future<WeatherResponseModel> fetchSearchDataByLocation({required double lat, required double lon});
}