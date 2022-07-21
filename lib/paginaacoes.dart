import 'package:flutter/material.dart';
import 'model/area.dart';
import 'model/boi.dart';

class PaginaAcoes extends StatefulWidget {
  const PaginaAcoes(List<Boi> listBois, List<Area> listArea);

  @override
  State<PaginaAcoes> createState() => _PaginaAcoesState();
}

class _PaginaAcoesState extends State<PaginaAcoes> {
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
          "VetBoj",
          style: TextStyle(
            fontFamily: 'Opensans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Center(
        child: Text('data'),
      ),
    );
  }
}
