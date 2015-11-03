@HtmlImport('task_statistic_period.html')
library dardo.lib.statistic.period;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

@PolymerRegister('task-statistic-period')
class TaskStatisticPeriod extends PolymerElement {

  TaskStatisticPeriod.created() : super.created();

  void ready() {
    print("$runtimeType::ready()");
  }
}