import 'package:angular2/platform/browser.dart';
import 'package:angular2/core.dart';

import 'package:pikaday_datepicker/pikaday_datepicker.dart';

void main() {
  bootstrap(AppComponent);
}

// example app to showcase the PikadayComponent.
@Component(
    selector: 'showcase-pikadate-component',
    template: '''<h1>AngularDart2-datepicker</h1>
                 <pikaday [(day)]="selectedDay" format="DD-MM-YYYY"
                          firstDay="1" minDate="2010-1-1" maxDate="2025-12-31">
                 </pikaday>
                 <div>selectedDay: {{selectedDay | date}}</div>''',
    directives: const [PikadayComponent])
class AppComponent {
  DateTime selectedDay = new DateTime(2015, 2, 1);
}