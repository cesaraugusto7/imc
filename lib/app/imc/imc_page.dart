import 'package:flutter/material.dart';
import 'package:imc/app/components/c_button.dart';
import 'package:imc/app/imc/imc_store.dart';

class IMCPage extends StatefulWidget {
  const IMCPage({Key? key}) : super(key: key);

  @override
  State<IMCPage> createState() => _IMCPageState();
}

class _IMCPageState extends State<IMCPage> {
  late var imcStore = IMCStore();

  final _textControllerYears = TextEditingController();
  final _textControllerWeight = TextEditingController();
  final _textControllerHeight = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Idade - Altura-Peso',
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color(0xFF40BB64),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _textControllerYears.clear();
                  _textControllerHeight.clear();
                  _textControllerWeight.clear();
                  imcStore = IMCStore();
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 28, right: 28, top: 74),
            child: Column(children: [
              const Text(
                'Qual é a sua idade ?',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              TextField(
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 20),
                onChanged: imcStore.setYears,
                controller: _textControllerYears,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 74),
              const Text(
                'Qual é a sua altura ?(cm)',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              TextField(
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 20),
                controller: _textControllerHeight,
                onChanged: imcStore.setHeight,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 74),
              const Text(
                'Qual  é o seu peso ?(kg)',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              TextField(
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 20),
                onChanged: imcStore.setWeight,
                controller: _textControllerWeight,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 74),
              CButton(
                height: 76,
                width: 302,
                onClick: () {
                  final person = imcStore.calculateIMC();
                  Navigator.pushNamed(context, '/resultIMC', arguments: person);
                },
                text: 'CALCULAR',
                colorButton: const Color(0xFF40BB64),
                colorText: Colors.white,
                fontSize: 24,
                borderRadius: 20,
              ),
              const SizedBox(height: 50),
            ]),
          ),
        ],
      ),
    );
  }
}
