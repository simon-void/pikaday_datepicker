import 'dart:html';

import 'package:intl/intl.dart';

import 'package:pikaday_datepicker/pikaday_wrapper.dart';

void main() {
  final inputElem = new InputElement() ..placeholder="select a day";
  final outputElem = new DivElement();

  final params = new PikadayParams()
    ..defaultDay = new DateTime(2015, 2, 1)
    ..format="DD-MM-YYYY"
    ..firstDay="1"
    ..minDate="2010-1-1"
    ..maxDate="2025-12-31"
    ..showDayOnInit="false";

  final dayFormatter = new DateFormat('MMM dd, yyyy');
  updateOutput(DateTime selectedDay){
    outputElem.text = "selectedDay: ${dayFormatter.format(selectedDay)}";
  }
  // set an initial output to be completly equivalent with angular version
  updateOutput(params.defaultDay);

  // make the input a pikaday-datepicker
  upgradeInputToDatepicker(inputElem, updateOutput, params);

  // wire the elements to the page
  final appDiv = querySelector("#datepickerShowcase");
  appDiv.text = "";
  appDiv.children
    ..add(inputElem)
    ..add(outputElem);
}
