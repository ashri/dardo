@HtmlImport('task_history.html')
library dardo.lib.history;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'dardo.dart';

@PolymerRegister('task-history')
class TaskHistory extends PolymerElement {

  @property
  List<Task> history;

  TaskHistory.created() : super.created();

  @reflectable
  String formatDate(DateTime ts) {
    return "${ts.day.toString().padLeft(2, '0')}/${ts.month.toString().padLeft(2, '0')}/${ts.year.toString()} ${ts.hour
        .toString().padLeft(2, '0')}:${ts.minute.toString().padLeft(2, '0')}";
  }

  void ready() {
    print("$runtimeType::ready()");
  }
}