import 'boi.dart';

class Area {
  int maxGado;
  String nome;
  double gmd;
  List<Boi> bois = [];

  Area({
    required this.maxGado,
    required this.nome,
    required this.gmd,
  });

  factory Area.fromMap(Map<String, dynamic> json) => Area(
        maxGado: json["maxGado"],
        nome: json["nome"],
        gmd: json["gmd"],
      );

  Map<String, dynamic> toMap() {
    return {
      "maxGado": maxGado,
      "nome": nome,
      "gmd": gmd,
      "bois":bois,
    };
  }
}
