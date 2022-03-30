class Wind {
  Wind({
    required double speed,
    required int deg,
  });

  factory Wind.fromJson(Map<String, dynamic> data) {
    final double speed = data['speed'];
    final int deg = data['deg'];

    return Wind(
      speed: speed,
      deg: deg,
    );
  }
}
