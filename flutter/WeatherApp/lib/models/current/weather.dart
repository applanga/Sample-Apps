class WeatherModel {
  WeatherModel({
    required int id,
    required String main,
    required String description,
    required String icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as int;
    final main = data['main'] as String;
    final description = data['description'] as String;
    final icon = data['icon'] as String;

    return WeatherModel(
      id: id,
      main: main,
      description: description,
      icon: icon,
    );
  }
}
