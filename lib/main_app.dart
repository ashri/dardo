@HtmlImport('main_app.html')
library dardo.lib.core;

import 'dart:html';


import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_input.dart';
import 'package:web_components/web_components.dart';

import 'dardo.dart';
import 'runnable_task.dart';
import 'task_history.dart';
import 'task_statistics.dart';

/// Uses [IronInput]
/// Uses [RunnableTask]
/// Uses [TaskHistory]
/// Uses [TaskStatistics]
@PolymerRegister('main-app')
class MainApp extends PolymerElement {

  @property
  bool running = false;

  @property
  List<Statistic> statistics = [];

  @property
  List<Task> history = [];

  @property
  bool hasHistory = false;

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

  @Observe('history.*')
  void historyChanged(Map changeRecord) {
    print('$runtimeType::historyChanged()');
    List<Statistic> newStats = calculateStatistics();
    set('statistics', newStats);
  }

  List<Statistic> calculateStatistics() {
    DateTime now = new DateTime.now();
    // Sequence is group by day and total counts

    // Today count is number by today

    // Average is group by date and average counts

    // Weekly count is group by last 7 days and count

    // Weekly average is group by 7 day slots and average

    List<Statistic> stats = [];
    stats.add(new Statistic('Today', 3, [3, 4, 3, 2, 4, 4, 2], 'Daily Average', 6.4));
    stats.add(new Statistic('This Week', 14, [33, 34, 55, 2, 12, 23], 'Weekly Average', 33.1));
    return stats;
  }

//  /// Called when main-app has been fully prepared (Shadow DOM created,
//  /// property observers set up, event listeners attached).
  ready() {
    print('$runtimeType::ready()');
  }
}