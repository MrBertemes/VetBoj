import 'package:flutter/material.dart';
import 'model/area.dart';
import 'model/boi.dart';
import 'main.dart';

class PaginaBoi extends StatefulWidget {
  const PaginaBoi();

  @override
  State<PaginaBoi> createState() => _PaginaBoiState();
}

class _PaginaBoiState extends State<PaginaBoi> {
  late final TextEditingController _brinco;
  late final TextEditingController _peso;

  criarNovoBoi(String brinco, String peso) {
    Boi boi = Boi(brinco: brinco, peso: double.parse(peso));
    listaBoisBrinco.add(brinco);
    setState(() {
      listaBois.add(boi);
    });
  }

  @override
  void initState() {
    _brinco = TextEditingController();
    _peso = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _brinco.dispose();
    _peso.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/main');
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/acoes');
            },
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
        ],
        title: const Text(
          "Gado",
          style: TextStyle(
            fontFamily: 'Opensans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(8.0),
        child: listaBois.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.all(2),
                itemCount: listaBois.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1.0,
                    child: ListTile(
                      leading: const Icon(Icons.arrow_right),
                      title: Text("${listaBois[index].brinco}"),
                      subtitle: Text("${listaBois[index].peso.toStringAsFixed(2)} Kg"),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              )
            : const Text('Não há bois cadastrados'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Resetando as strings que ficam nos controllers
          _brinco.text = '';
          _peso.text = '';
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
                        TextFormField(
                          controller: _brinco,
                          decoration: const InputDecoration(
                            labelText: 'Código Brinco',
                            icon: Icon(Icons.abc),
                          ),
                        ),
                        TextFormField(
                          controller: _peso,
                          decoration: const InputDecoration(
                            labelText: 'Peso inicial',
                            icon: Icon(Icons.monitor_weight_outlined),
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
                      criarNovoBoi(
                        _brinco.text,
                        _peso.text,
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
