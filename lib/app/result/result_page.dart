import 'package:flutter/material.dart';
import 'package:imc/app/components/c_button.dart';
/* import 'package:imc/app/components/c_button.dart'; */
import 'package:imc/app/person/person_model.dart';
import 'package:imc/app/result/result_config_model.dart';
import 'package:imc/app/result/result_store.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    final person = ModalRoute.of(context)?.settings.arguments as PersonModel;
    final resultStore = ResultStore(imc: person.imc);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resultado IMC',
        ),
        backgroundColor: const Color(0xFF40BB64),
      ),
      body: FutureBuilder(
        future: resultStore.listSfRadialGauge(),
        builder: (context, AsyncSnapshot snapshot) {
          var listGauge = <GaugeRange>[];
          var listaConfig = [];
          if (snapshot.hasData) {
            List<Widget> listaLegeda() {
              var legendas = <Widget>[];
              for (var i = 0; i < listaConfig.length; i++) {
                var model = snapshot.data[i];
                legendas.add(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Container(
                          height: 26,
                          width: 26,
                          color: Color(model.color),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          model.desc,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ]),
                      Text(
                          model.startValue == 0
                              ? ' < ' + model.endValue.toString()
                              : i == snapshot.data.length - 1
                                  ? ' > ' + (model.startValue - 0.1).toString()
                                  : model.startValue.toString() +
                                      ' - ' +
                                      model.endValue.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))
                    ],
                  ),
                );
                legendas
                    .add(const Padding(padding: EdgeInsets.only(bottom: 10)));
              }
              return legendas;
            }

            listaConfig = snapshot.data;
            resultStore.sentingsIMC(listaConfig);
            for (var model in snapshot.data) {
              listGauge.add(GaugeRange(
                  startValue: model.startValue,
                  endValue: model.endValue,
                  color: Color(model.color)));
            }
            return Padding(
              padding: const EdgeInsets.only(
                  left: 28, right: 28, top: 20, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        person.years.toString() + ' anos',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      Container(
                        height: 25,
                        width: 2,
                        color: const Color(0xFFABABAB),
                      ),
                      Text(
                        person.height.toStringAsFixed(1) + ' cm',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      Container(
                        height: 25,
                        width: 2,
                        color: const Color(0xFFABABAB),
                      ),
                      Text(
                        person.weight.toStringAsFixed(1) + ' kg',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          minimum: 0,
                          maximum: 45,
                          showTicks: false,
                          showLabels: false,
                          ranges: listGauge,
                          pointers: <GaugePointer>[
                            NeedlePointer(value: person.imc)
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                widget: Text(
                                  person.imc.toStringAsFixed(2),
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color(resultStore.result.color),
                                  ),
                                ),
                                angle: 90,
                                positionFactor: 0.7),
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        resultStore.result.desc,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(resultStore.result.color),
                        ),
                      ),
                      Text(
                        resultStore.result.diference,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(resultStore.result.color),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 2,
                    color: const Color(0xFFABABAB),
                  ),
                  Column(
                    children: listaLegeda(),
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
