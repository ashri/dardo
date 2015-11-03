@HtmlImport('recent_task.html')
library dardo.lib.task;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

@PolymerRegister('recent-task')
class RecentTask extends PolymerElement {

  RecentTask.created() : super.created();

  void ready() {
    print("$runtimeType::ready()");
  }
}