import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:clima_app/features/favorites/data/models/favorite_location_hive_model.dart';
import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:dartz/dartz.dart';

class FavoriteWeatherRepositoryImpl implements FavoriteWeatherRepository {

  final FavoriteWeatherDataSource dataSource;

  const FavoriteWeatherRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, bool>> storeCity({required FavoriteLocation location}) async {
    try {
      final city = FavoriteLocationHiveModel.fromEntity(location);
      final result = await dataSource.storeCity(city: city);

      return result ? const Right(true) : Left(GenericFailure());
    } catch (e) {
      return Left(GenericFailure());
    }
  }
}