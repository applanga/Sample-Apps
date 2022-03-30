class Sys {
  Sys({
    required int type,
    required int id,
    required double message,
    required String country,
    required int sunrise,
    required int sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> data) {
    final int type = data['type'];
    final int id = data['id'];
    final double message = data['message'];
    final String country = data['country'];
    final int sunrise = data['sunrise'];
    final int sunset = data['sunset'];

    return Sys(
      type: type,
      id: id,
      message: message,
      country: country,
      sunrise: sunrise,
      sunset: sunset,
    );
  }
}
