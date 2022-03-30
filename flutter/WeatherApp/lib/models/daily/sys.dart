class Sys {
  String? pod;

  Sys({
    this.pod,
  });

  factory Sys.fromJson(Map<String, dynamic> data) {
    final String? pod = data['pod'];

    return Sys(
      pod: pod,
    );
  }
}
