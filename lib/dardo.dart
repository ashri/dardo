library dardo.lib.models;

import 'package:polymer/polymer.dart';

class Task extends JsProxy {
  @reflectable DateTime timestamp;
  @reflectable String description;
  @reflectable List<String> tags;

  Task(this.timestamp, this.description, this.tags);
}

class Statistic extends JsProxy {
  @reflectable String label;
  @reflectable int count;
  @reflectable List<int> sequence;
  @reflectable String averageLabel;
  @reflectable String average;

  Statistic(this.label, this.count, this.sequence, this.averageLabel, this.average);

  @reflectable
  String sparkline() => 'http://www.kryogenix.org/random/sparkline.svg?${sequence.join(',')}';
}