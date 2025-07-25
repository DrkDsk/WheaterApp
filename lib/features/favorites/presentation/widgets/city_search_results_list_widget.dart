import 'package:clima_app/features/city/presentation/blocs/city_bloc.dart';
import 'package:clima_app/features/city/presentation/blocs/city_event.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/presentation/widgets/city_result_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CitySearchResultsListWidget extends StatelessWidget {
  const CitySearchResultsListWidget({
    super.key,
    required this.result,
  });

  final List<CityLocation> result;

  Future<void> getWeatherSelected({
    required CityLocation location,
    required BuildContext context
  }) async {
    final cityBloc = context.read<CityBloc>();
    Future.microtask(() {
      cityBloc.add(GetSelectedCityEvent(
          latitude: location.lat, longitude: location.lon));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => const SizedBox(height: 4),
        separatorBuilder: (context, index) {
          final currentLocationData = result[index];
          final cityName = currentLocationData.name;
          final state = currentLocationData.state;
          final country = currentLocationData.country;

          final query = "$cityName, $state, $country";

          return GestureDetector(
            onTap: () => getWeatherSelected(
                location: currentLocationData, context: context),
            child: CityResultItemCard(query: query),
          );
        },
        itemCount: result.length);
  }
}
