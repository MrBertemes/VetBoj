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

  criaAcao(String area, String brinco, String dias) {
    int diasInt = int.parse(dias);
    Acao acaoCriada = Acao(area: area, brinco: brinco, dias: diasInt);
    setState(() {
      listaAcoes.add(acaoCriada);
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
            onPressed: () {},
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
                      trailing: Text("Dias: ${listaAcoes[index].dias}"),
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
                                  onChanged: (escolha) =>
                                      _areaEscolhida.value = escolha.toString(),
                                  items: listaAreasNome
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
                                  onChanged: (escolha) =>
                                      _boiEscolhido.value = escolha.toString(),
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
