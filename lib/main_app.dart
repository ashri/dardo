@HtmlImport('main_app.html')
library dardo.lib.core;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_input.dart';
import 'package:web_components/web_components.dart';

import 'dardo.dart';
import 'runnable_task.dart';
import 'task_history.dart';
import 'task_statistic_period.dart';
import 'task_statistics.dart';

/// Uses [IronInput]
/// Uses [RunnableTask]
/// Uses [TaskHistory]
/// Uses [TaskStatistics]
/// Uses [TaskStatisticPeriod]
@PolymerRegister('main-app')
class MainApp extends PolymerElement {

  @property
  bool running = false;

  @property
  List statistics = [];

  @property
  List<Task> history = [];

  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created();

// Optional lifecycle methods - uncomment if needed.

//  /// Called when an instance of main-app is inserted into the DOM.
//  attached() {
//    super.attached();
//  }

//  /// Called when an instance of main-app is removed from the DOM.
//  detached() {
//    super.detached();
//  }

//  /// Called when an attribute (such as a class) of an instance of
//  /// main-app is added, changed, or removed.
//  attributeChanged(String name, String oldValue, String newValue) {
//    super.attributeChanged(name, oldValue, newValue);
//  }

  @reflectable
  void complete(Event e, var detail) {
    print('$runtimeType::complete(): Received ${detail['description']}');
    add('history', new Task(new DateTime.now(), detail['description'], detail['tags']));
  }

//  /// Called when main-app has been fully prepared (Shadow DOM created,
//  /// property observers set up, event listeners attached).
  ready() {
    print('$runtimeType::ready()');
  }
}