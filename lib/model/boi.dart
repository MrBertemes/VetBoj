class Boi {
  String brinco;
  double peso;

  Boi({
    required this.brinco,
    required this.peso,
  });

  factory Boi.fromMap(Map<String, dynamic> json) => Boi(
        brinco: json["brinco"],
        peso: json["peso"],
      );

  Map<String, dynamic> toMap() {
    return {
      "brinco": brinco,
      "peso": peso,
    };
  }
}
