import 'package:clima_app/features/favorites/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/presentation/widgets/city_result_item_card.dart';
import 'package:clima_app/features/home/presentation/blocs/events/weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CitySearchResultsListWidget extends StatelessWidget {
  const CitySearchResultsListWidget({
    super.key,
    required this.result,
  });

  final List<CityLocation> result;

  Future<void> getWeatherSelected(
      {required CityLocation location,
        required BuildContext context}) async {
    final weatherBloc = context.read<WeatherBloc>();
    Future.microtask(() {
      weatherBloc.add(CurrentWeatherEvent(latitude: location.lat, longitude: location.lon));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) =>
        const SizedBox(height: 4),
        separatorBuilder: (context, index) {
          final currentLocationData = result[index];
          final cityName = currentLocationData.name;
          final state = currentLocationData.state;
          final country = currentLocationData.country;
          return GestureDetector(
            onTap: () => getWeatherSelected(
                location: currentLocationData,
                context: context),
            child: CityResultItemCard(cityName: cityName, state: state, country: country),
          );
        },
        itemCount: result.length);
  }
}

