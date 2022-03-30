class Coord {
  Coord({
    required double long,
    required double lat,
  });

  factory Coord.fromJson(Map<String, dynamic> data) {
    final double long = data['long'];
    final double lat = data['lat'];

    return Coord(
      long: long,
      lat: lat,
    );
  }
}
