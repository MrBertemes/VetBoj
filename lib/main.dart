import 'package:flutter/material.dart';
import 'package:vetboj/model/area.dart';
import 'package:vetboj/paginaacoes.dart';
import 'package:vetboj/paginaboi.dart';
import 'model/acao.dart';
import 'model/boi.dart';
// import 'package:vetboj/databasehelper.dart';

List<Area> listaAreas = [];
List<String> listaAreasNome = [];
List<Boi> listaBois = [];
List<String> listaBoisBrinco = [];
List<Acao> listaAcoes = [];
List<Boi> listaDeBoiEscolhidos = [];
List<Area> listaDeAreasEscolhidas = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VetBoj',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        '/main': (context) => const MyApp(),
        '/boi': (context) => const PaginaBoi(),
        '/acoes': (context) => const PaginaAcoes()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController _nome;
  late final TextEditingController _maxGado;
  late final TextEditingController _gmd;

  void criarNovaArea(String maxGado, String nome, String gmd) {
    Area a = Area(
      maxGado: int.parse(maxGado),
      nome: nome,
      gmd: double.parse(gmd),
    );
    listaAreasNome.add(nome);
    setState(() {
      listaAreas.add(a);
    });
  }

  @override
  void initState() {
    _nome = TextEditingController();
    _maxGado = TextEditingController();
    _gmd = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nome.dispose();
    _maxGado.dispose();
    _gmd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/boi',
                  arguments: {"list": listaAreas});
            },
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
        ],
        title: const Text(
          "Áreas",
          style: TextStyle(
            fontFamily: 'Opensans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(8.0),
        child: listaAreas.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.all(2),
                itemCount: listaAreas.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1.0,
                    child: ListTile(
                      leading: const Icon(Icons.agriculture_sharp),
                      title: Text("Area ${listaAreas[index].nome}"),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              )
            : const Text('Não há áreas cadastradas'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Resetando as strings que ficam nos controllers
          _gmd.text = '';
          _maxGado.text = '';
          _nome.text = '';
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                scrollable: true,
                title: const Text('Cadastrar nova área'),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _nome,
                          decoration: const InputDecoration(
                            labelText: 'Nome da área',
                            icon: Icon(Icons.account_box),
                          ),
                        ),
                        TextFormField(
                          controller: _gmd,
                          decoration: const InputDecoration(
                            labelText: 'GMD',
                            icon: Icon(Icons.email),
                          ),
                        ),
                        TextFormField(
                          controller: _maxGado,
                          decoration: const InputDecoration(
                            labelText: 'Número máximo de bois',
                            icon: Icon(Icons.agriculture_sharp),
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
                      criarNovaArea(
                        _maxGado.text,
                        _nome.text,
                        _gmd.text,
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
