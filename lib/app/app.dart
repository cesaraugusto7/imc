import 'package:flutter/material.dart';
import 'package:imc/app/imc/imc_page.dart';
import 'package:imc/app/result/result_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => const IMCPage(),
        '/resultIMC': (context) => const ResultPage()
      },
    );
  }
}
