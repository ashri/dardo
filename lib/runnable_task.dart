@HtmlImport('runnable_task.html')
library dardo.lib.runnable;

import 'dart:async';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

@PolymerRegister('runnable-task')
class RunnableTask extends PolymerElement {

  @property
  bool running;

  @property
  bool resting;

  @property
  Duration timeRequired;

  @property
  Duration timePassed;

  @Property(computed: 'computeCountdown(timePassed)')
  String countdown;

  @property
  String description;

  @property
  List<String> tags;

  @property
  String inputTags;

  Stopwatch timing = new Stopwatch();

  Timer timer;

  RunnableTask.created() : super.created();

  @reflectable
  String computeCountdown(Duration timePassed) {
    Duration d = timeRequired - timePassed;
    var minutes = d.inMinutes;
    var seconds = (d - new Duration(minutes: minutes)).inSeconds;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(
        2, '0')}';
  }

  @reflectable
  void startTask([_, __]) {
    print('$runtimeType::startTask()');
    start(false, new Duration(minutes: 20), inputTags.toLowerCase().split(' '));
  }

  @reflectable
  void startSmallRest([_, __]) {
    print('$runtimeType::startSmallRest()');
    start(true, new Duration(minutes: 5), []);
  }

  @reflectable
  void startLargeRest([_, __]) {
    print('$runtimeType::startLargeRest()');
    start(true, new Duration(minutes: 15), []);
  }

  void start(bool resting, Duration timeRequired, List<String> tags) {
    set('running', true);
    set('resting', resting);
    set('timeRequired', timeRequired);
    set('timePassed', new Duration(minutes: 0));
    set('tags', tags);
    timing.start();
    timer = new Timer.periodic(new Duration(seconds: 1), tick);
  }

  @reflectable
  void cancelTask([_, __]) {
    print('$runtimeType::cancelTask()');
    set('running', false);
    set('resting', false);
    timer.cancel();
    timing.stop();
    timing.reset();
  }

  void tick(Timer t) {
    print('$runtimeType::tick()');
    set('timePassed', timing.elapsed);
  }

  @reflectable
  void ready() {
    print('$runtimeType::ready()');
  }
}