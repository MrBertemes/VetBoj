import 'package:flutter/material.dart';
import 'package:vetboj/main.dart';
import 'package:vetboj/model/acao.dart';
import 'model/area.dart';
import 'model/boi.dart';

class PaginaAcoes extends StatefulWidget {
  const PaginaAcoes();

  @override
  State<PaginaAcoes> createState() => _PaginaAcoesState();
}

class _PaginaAcoesState extends State<PaginaAcoes> {
  final _areaEscolhida = ValueNotifier('');
  final _boiEscolhido = ValueNotifier('');
  late final TextEditingController _dias;

  void criaAcao(String area, String brinco, String dias) {
    int diasInt = int.parse(dias);
    Area a = buscarArea(area);
    Acao acaoCriada = Acao(area: area, brinco: brinco, dias: diasInt);
    setState(() {
      if (listaAcoes.isNotEmpty) {
        if (podeInserirMergeDias(acaoCriada)) {
          inserirMergeDias(acaoCriada);
        } else {
          moveAdicionaBoi(acaoCriada);
          listaAcoes.add(acaoCriada);
        }
      } else {
        moveAdicionaBoi(acaoCriada);
        listaAcoes.add(acaoCriada);
      }
    });
  }

  @override
  void initState() {
    _dias = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _dias.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/boi');
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: listaAcoes.isNotEmpty
                ? () {
                    finalizar();
                    Navigator.popAndPushNamed(context, '/resultados');
                  }
                : null,
            icon: const Icon(Icons.check_circle_rounded),
          ),
        ],
        title: const Text(
          "Movimentações",
          style: TextStyle(
            fontFamily: 'Opensans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(8.0),
        child: listaAcoes.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.all(2),
                itemCount: listaAcoes.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1.0,
                    child: ListTile(
                      leading: const Icon(Icons.arrow_right),
                      title: Text(
                          "Boi ${listaAcoes[index].brinco} em ${listaAcoes[index].area}"),
                      subtitle: Text("Dias: ${listaAcoes[index].dias}"),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              )
            : const Text('Ainda não há movimentações programadas'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _boiEscolhido.value = '';
          _areaEscolhida.value = '';
          _dias.text = '';
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                scrollable: true,
                title: const Text('Cadastrar novo boi'),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          child: ValueListenableBuilder(
                              valueListenable: _areaEscolhida,
                              builder: (BuildContext context, String value, _) {
                                return DropdownButton<String>(
                                  hint: const Text("Área"),
                                  value: (value.isEmpty ? null : value),
                                  onChanged: areasRestantes.isNotEmpty
                                      ? (escolha) => _areaEscolhida.value =
                                          escolha.toString()
                                      : null,
                                  items: areasRestantes
                                      .map(
                                        (op) => DropdownMenuItem(
                                          value: op,
                                          child: Text(op),
                                        ),
                                      )
                                      .toList(),
                                );
                              }),
                        ),
                        SizedBox(
                          child: ValueListenableBuilder(
                              valueListenable: _boiEscolhido,
                              builder: (BuildContext context, String value, _) {
                                return DropdownButton<String>(
                                  hint: const Text("Brinco"),
                                  value: (value.isEmpty ? null : value),
                                  onChanged: listaBoisBrinco.isNotEmpty
                                      ? (escolha) => _boiEscolhido.value =
                                          escolha.toString()
                                      : null,
                                  items: listaBoisBrinco
                                      .map(
                                        (op) => DropdownMenuItem(
                                          value: op,
                                          child: Text(op),
                                        ),
                                      )
                                      .toList(),
                                );
                              }),
                        ),
                        TextFormField(
                          controller: _dias,
                          decoration: const InputDecoration(
                            labelText: 'Dias',
                            icon: Icon(Icons.calendar_month_rounded),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar"),
                  ),
                  TextButton(
                    child: const Text("Criar"),
                    onPressed: () {
                      criaAcao(
                        _areaEscolhida.value,
                        _boiEscolhido.value,
                        _dias.text,
                      );
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}

dynamic buscarBoi(String brinco) {
  for (Boi boi in listaBois) {
    if (boi.brinco == brinco) {
      return boi;
    }
  }
}

dynamic buscarArea(String nome) {
  for (Area area in listaAreas) {
    if (area.nome == nome) {
      return area;
    }
  }
}

bool podeInserirMergeDias(Acao acao) {
  var ultimaAcao = listaAcoes.last;
  if (ultimaAcao.brinco == acao.brinco && ultimaAcao.area == acao.area) {
    return true;
  }

  return false;
}

void inserirMergeDias(Acao acao) {
  for (Acao a in listaAcoes) {
    if (a.brinco == acao.brinco && a.area == acao.area) {
      a.dias = a.dias + acao.dias;
    }
  }
}

void moveAdicionaBoi(Acao acao) {
  for (Area a in listaAreas) {
    if (acao.area != a.nome && a.bois.isNotEmpty) {
      // Area diferentes da entrada que podem ter o boi
      var removeBoi;
      for (var boi in a.bois) {
        if (boi.brinco == acao.brinco) {
          removeBoi=boi;
        }
      }
      a.bois.remove(removeBoi);
    }
    if (acao.area == a.nome) {
      // Adicona direto
      Boi boi = buscarBoi(acao.brinco);
      adicionaBoiArea(boi, acao);
    }
  }
}

void adicionaBoiArea(Boi boi, Acao acao) {
  for (var achada in listaAreas) {
    if (achada.nome == acao.area) {
      achada.bois.add(boi);
    }
  }
}

void finalizar() {
  for (var acao in listaAcoes) {
    Area area = buscarArea(acao.area);
    double ganhoDias = area.gmd * acao.dias;
    for (Boi boi in listaBois) {
      if (acao.brinco == boi.brinco) {
        boi.peso = boi.peso + ganhoDias;
      }
    }
  }
}

List<String> get areasRestantes {
  List<String> lst = [];
  for (var area in listaAreas) {
    if (area.bois.length < area.maxGado) {
      lst.add(area.nome);
    }
  }
  return lst;
}
