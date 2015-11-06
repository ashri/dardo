library dardo.lib.models;

import 'package:polymer/polymer.dart';

class Task extends JsProxy {
  @reflectable DateTime timestamp;
  @reflectable String description;
  @reflectable List<String> tags;

  Task(this.timestamp, this.description, this.tags);
}