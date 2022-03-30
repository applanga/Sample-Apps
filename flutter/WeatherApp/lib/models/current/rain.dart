class Rain {
  Rain({
    required double oneHour,
  });

  factory Rain.fromJson(Map<String, dynamic> data) {
    final double oneHour = data['1h'];

    return Rain(
      oneHour: oneHour,
    );
  }
}
