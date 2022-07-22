class Acao {
  String area;
  String brinco;
  int dias;

  Acao({required this.area,required this.brinco,required this.dias});

    factory Acao.fromMap(Map<String, dynamic> json) => Acao(
        area: json["area"],
        brinco: json["brinco"],
        dias: json["dias"],
      );

  Map<String, dynamic> toMap() {
    return {
      "area": area,
      "brinco": brinco,
      "dias": dias,
    };
  }
}
