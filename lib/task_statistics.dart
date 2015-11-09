@HtmlImport('task_statistics.html')
library dardo.lib.statistics;

import 'dardo.dart';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

@PolymerRegister('task-statistics')
class TaskStatistics extends PolymerElement {

  @property
  List<Statistic> statistics = [];

  TaskStatistics.created() : super.created();

  void ready() {
    print("$runtimeType::ready()");
  }
}