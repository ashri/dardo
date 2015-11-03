@HtmlImport('task_statistics.html')
library dardo.lib.statistics;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

@PolymerRegister('task-statistics')
class TaskStatistics extends PolymerElement {

  @property
  List statistics = [];

  TaskStatistics.created() : super.created();

  @reflectable
  bool hasStatistics() {
    return statistics != null && statistics.isNotEmpty;
  }

  void ready() {
    print("$runtimeType::ready()");
  }
}