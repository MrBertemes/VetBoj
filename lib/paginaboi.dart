import 'package:flutter/material.dart';
import 'model/area.dart';
import 'model/boi.dart';

List<Boi> listaBois = [];

class PaginaBoi extends StatefulWidget {
  const PaginaBoi(List<Area> list);

  @override
  State<PaginaBoi> createState() => _PaginaBoiState();
}

class _PaginaBoiState extends State<PaginaBoi> {
  late final TextEditingController _brinco;
  late final TextEditingController _peso;

  criarNovoBoi(String brinco, String peso) {
    Boi boi = Boi(brinco: brinco, peso: double.parse(peso));
    listaBois.add(boi);
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
          "VetBoj",
          style: TextStyle(
            fontFamily: 'Opensans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: 
      const Center(
        child: Text('A'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Resetando as strings que ficam nos controllers
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
                            icon: Icon(Icons.account_box),
                          ),
                        ),
                        TextFormField(
                          controller: _peso,
                          decoration: const InputDecoration(
                            labelText: 'Peso inicial',
                            icon: Icon(Icons.email),
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
