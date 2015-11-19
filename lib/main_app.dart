@HtmlImport('main_app.html')
library dardo.lib.core;

import 'dart:convert';
import 'dart:html';

import 'package:dardo/dardo.dart';
import 'package:dardo/runnable_task.dart';
import 'package:dardo/task_history.dart';
import 'package:dardo/task_statistics.dart';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

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

  bool appReady = false;

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
    if (!appReady) {
      return;
    }
    updateStats();
    saveData();
  }

  void updateStats() {
    if (!appReady) {
      return;
    }
    print('$runtimeType::updateStats()');
    List<Statistic> newStats = calculateStatistics();
    set('statistics', newStats);
  }

  List<Statistic> calculateStatistics() {
    List<Statistic> stats = [];

    // Sequence is group by day and total counts
    Map<String, int> groupByDay = {};
    this.history.forEach((task) {
      var ts = task.timestamp;
      var day = formatDate(ts);
      groupByDay.putIfAbsent(day, () => 0);
      int total = groupByDay[day];
      groupByDay[day] = total + 1;
    });

    List<String> days = groupByDay.keys.toList(growable: false);
    days.sort((s1, s2) => s1.compareTo(s2));

    String today = formatDate(new DateTime.now());
    groupByDay.putIfAbsent(today, () => 0);

    // Today count is number by today
    List<int> daySequence = [];
    days.forEach((s) => daySequence.add(groupByDay[s]));

    int todayCount = 0;
    double average = 0.0;

    if (daySequence.isNotEmpty) {
      todayCount = daySequence.isNotEmpty ? daySequence.last : 0;
      average = daySequence.fold(0, (v, i) => v + i) / daySequence.length;
    }

    stats.add(new Statistic('Today', todayCount, daySequence, 'Daily', average.toStringAsFixed(1)));

    // Weekly average is group by 7 day slots and average
    //stats.add(new Statistic('This Week', 14, [33, 34, 55, 2, 12, 23], 'Weekly Average', 33.1));
    return stats;
  }

  String formatDate(DateTime ts) {
    return "${ts.year.toString()}/${ts.month.toString().padLeft(2, '0')}/${ts.day.toString().padLeft(2, '0')}";
  }

//  /// Called when main-app has been fully prepared (Shadow DOM created,
//  /// property observers set up, event listeners attached).
  ready() {
    print('$runtimeType::ready()');
    loadData();
    appReady = true;
    updateStats();
  }

  void loadData() {
    print('$runtimeType::loadData()');
    var json = window.localStorage['data'];
    if (json == null || json.isEmpty) {
      return;
    }
    var data = JSON.decode(json);
    List<Map> tasks = data['history'];
    List<Task> history = [];
    tasks.forEach((Map t) {
      DateTime timestamp = new DateTime.fromMillisecondsSinceEpoch(t['timestamp']);
      Task task = new Task(timestamp, t['description'], t['tags']);
      history.add(task);
    });
    set('history', history);
  }

  void saveData() {
    print('$runtimeType::saveData()');
    List<Map> tasks = [];
    history.forEach((t) {
      tasks.add({
        'timestamp': t.timestamp.millisecondsSinceEpoch,
        'description': t.description,
        'tags': t.tags
      });
    });
    Map data = {
      'history': tasks
    };
    var json = JSON.encode(data);
    window.localStorage['data'] = json;
  }
}