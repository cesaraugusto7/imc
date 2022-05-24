import 'dart:math' as math;

import 'package:imc/app/person/person_model.dart';

class IMCStore {
  int _years = 0;
  double _weight = 0.0;
  double _height = 0.0;
  late PersonModel _person;

  PersonModel get result => _person;

  void setYears(String value) {
    _years = int.tryParse(value) ?? 0;
  }

  void setWeight(String value) {
    _weight = double.tryParse(value) ?? 0;
  }

  void setHeight(String value) {
    _height = double.tryParse(value) ?? 0;
  }

  PersonModel calculateIMC() {
    double imc = _weight / math.pow((_height / 100), 2);
    final person = PersonModel(_years, _height, _weight, imc);
    return person;
  }
}
