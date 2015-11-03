@HtmlImport('recent_tasks.html')
library dardo.lib.tasks;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

@PolymerRegister('recent-tasks')
class RecentTasks extends PolymerElement {

  RecentTasks.created() : super.created();

  void ready() {
    print("$runtimeType::ready()");
  }
}