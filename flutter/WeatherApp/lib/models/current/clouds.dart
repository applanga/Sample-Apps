class Clouds {
  Clouds({
    required int clouds,
  });

  factory Clouds.fromJson(Map<String, dynamic> data) {
    final clouds = data['all'];

    return Clouds(clouds: clouds);
  }
}
