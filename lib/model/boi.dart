class Boi {
  int id; //
  int idArea;
  String etiqueta;
  double peso;
  bool morto; 

  Boi({
    required this.id,
    required this.idArea,
    required this.etiqueta,
    required this.peso,
    required this.morto,
  });

  factory Boi.fromMap(Map<String, dynamic> json) => Boi(
        id: json["id"],
        idArea: json["idArea"],
        etiqueta: json["etiqueta"],
        peso: json["peso"],
        morto: json["morto"] == 0 ? true : false,
      );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idArea": idArea,
      "etiqueta": etiqueta,
      "peso": peso,
      "morto": morto ? 0 : 1,
    };
  }
}
