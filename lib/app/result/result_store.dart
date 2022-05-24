import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:imc/app/result/result_config_model.dart';
import 'package:imc/app/result/result_model.dart';

class ResultStore extends ChangeNotifier {
  final double imc;
  var resulConfig = <ResultConfigModel>[];
  var result;
  ResultStore({
    required this.imc,
  });
  void sentingsIMC(resulConfig) {
    int color = 0;
    double diference = 0.0;
    String desc = '';
    double startValueOK = 0.0;
    double endValueOk = 0.0;

    for (var i = 0; i < resulConfig.length; i++) {
      var element = resulConfig[i];
      if (imc >= element.startValue && imc <= element.endValue) {
        color = element.color;
        desc = element.desc;
      } else if (i == resulConfig.length - 1 && imc >= element.endValue) {
        color = element.color;
        desc = element.desc;
      }

      if (element.desc == 'Saudável') {
        startValueOK = element.startValue;
        endValueOk = element.endValue;
      }
    }
    diference = (startValueOK + endValueOk) / 2 - imc;
    result = ResultModel(
      desc: desc,
      diference: imc >= startValueOK && imc <= endValueOk
          ? '+' + (diference).toStringAsFixed(2)
          : diference < 1
              ? '+' + (diference * (-1)).toStringAsFixed(2)
              : (diference * (-1)).toStringAsFixed(2),
      color: color,
    );
    notifyListeners();
  }

  Future<List<ResultConfigModel>> listSfRadialGauge() async {
    final response =
        await rootBundle.loadString('lib/app/config/result_config.json');
    final jsonConfig = json.decode(response) as List;
    resulConfig = jsonConfig
        .map((e) => ResultConfigModel(
            startValue: e['startValue'],
            endValue: e['endValue'],
            color: int.parse(e['color']),
            desc: e['desc']))
        .toList();
    return resulConfig;
  }
}
