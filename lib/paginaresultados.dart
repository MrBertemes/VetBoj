import 'package:flutter/material.dart';
import 'package:vetboj/main.dart';

class PaginaResultados extends StatelessWidget {
  const PaginaResultados({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*leading: IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/acoes');
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),*/
        centerTitle: true,
        title: const Text(
          "Resultados",
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
                      title: Text(
                          "Boi ${listaBois[index].brinco}"),
                      subtitle: Text("Peso: ${listaBois[index].peso.toStringAsFixed(2)} Kg"),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              )
            : const Text('Não a bois cadastrados'),
      ),
    );
  }
}
