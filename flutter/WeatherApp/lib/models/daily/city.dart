import 'package:weather_sample/models/current/coord.dart';

class City {
  City({
    int? id,
    String? name,
    Coord? coord,
    String? country,
    int? population,
    int? timezone,
    int? sunrise,
    int? sunset,
  });

  factory City.fromJson(Map<String, dynamic> data) {
    final int id = data['id'];
    final String name = data['name'];
    final Coord coord = data['coord'];
    final String country = data['country'];
    final int population = data['population'];
    final int sunrise = data['sunrise'];
    final int sunset = data['sunset'];
    final int timezone = data['timezone'];

    return City(
      id: id,
      name: name,
      coord: coord,
      country: country,
      population: population,
      sunrise: sunrise,
      sunset: sunset,
      timezone: timezone,
    );
  }
}
