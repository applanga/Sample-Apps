class Rain {
  Rain({
    required double threeHours,
  });

  factory Rain.fromJson(Map<String, dynamic> data) {
    final double threeHours = data['3h'];

    return Rain(
      threeHours: threeHours,
    );
  }
}
