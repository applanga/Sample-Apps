class CurrentWeatherModel {
  double? temp;
  double? feelsLike;
  double? minTemp;
  double? maxTemp;
  double? pressure;
  double? humidity;
  double? lon;
  double? lat;
  double? wind;
  String? icon;
  String? description;
  String? cityName;

  CurrentWeatherModel(
      {this.temp,
      this.feelsLike,
      this.minTemp,
      this.maxTemp,
      this.pressure,
      this.humidity,
      this.lon,
      this.lat,
      this.wind,
      this.icon,
      this.description,
      this.cityName});

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> data) {
    return CurrentWeatherModel(
      temp: data['main']['temp'].toDouble(),
      feelsLike: data['main']['feels_like'].toDouble(),
      minTemp: data['main']['temp_min'].toDouble(),
      maxTemp: data['main']['temp_max'].toDouble(),
      description: data['weather'][0]['description'],
      pressure: data['main']['pressure'].toDouble(),
      humidity: data['main']['humidity'].toDouble(),
      lon: data['coord']['lon'].toDouble(),
      lat: data['coord']['lat'].toDouble(),
      wind: data['wind']['speed'].toDouble(),
      icon: data['weather'][0]['icon'],
      cityName: data['name'],
    );
  }
}
