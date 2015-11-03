@HtmlImport('task_history.html')
library dardo.lib.history;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

@PolymerRegister('task-history')
class TaskHistory extends PolymerElement {

  @property
  List history;

  TaskHistory.created() : super.created();

  @reflectable
  bool hasHistory() {
    return history != null && history.isNotEmpty;
  }

  void ready() {
    print("$runtimeType::ready()");
  }
}