import 'dart:html';

import 'package:pikaday_datepicker/pikaday_datepicker.dart';

void main() {
  final inputElem = new InputElement()
    ..placeholder = "select a day";
  final outputElem = new DivElement();

  final params = new PikadayParams()
    ..defaultDay = new DateTime(2015, 2, 1)
    ..format = "DD-MM-YYYY"
    ..firstDay = "1"
    ..minDate = "2010-1-1"
    ..maxDate = "2025-12-31"
    ..showDayOnInit = "false";

  updateOutput(DateTime selectedDay) {
    // look into the intl package for advanced date formation
    var formatedDay =
        "${selectedDay.day}.${selectedDay.month}.${selectedDay.year}";

    outputElem.text = "selectedDay: $formatedDay";
  }
  // set an initial output to be completly equivalent with angular version
  updateOutput(params.defaultDay);

  // make the input a pikaday-datepicker
  upgradeInputToDatepicker(inputElem, updateOutput, params);

  // wire the elements to the page
  final appDiv = querySelector("#datepickerShowcase");
  appDiv.text = "";
  appDiv.children..add(inputElem)..add(outputElem);
}
