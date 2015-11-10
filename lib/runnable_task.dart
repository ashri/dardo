@HtmlImport('runnable_task.html')
library dardo.lib.runnable;

import 'dart:async';
import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

@PolymerRegister('runnable-task')
class RunnableTask extends PolymerElement {

  @Property(notify: true)
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
  String descriptionHelp;

  @property
  String descriptionClassName;

  @property
  List<String> tags;

  @property
  String inputTags;

  Stopwatch _timing = new Stopwatch();

  Timer _timer;

  AudioElement _taskCompleteSound;
  AudioElement _restCompleteSound;

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
    if (validToStart()) {
      List<String> t = inputTags != null ? inputTags.toLowerCase().split(' ') : [];
      start(false, new Duration(minutes: 25), t);
    }
  }

  @reflectable
  void startSmallRest([_, __]) {
    print('$runtimeType::startSmallRest()');
    set('description', 'Resting ...');
    start(true, new Duration(minutes: 5), []);
  }

  @reflectable
  void startLargeRest([_, __]) {
    print('$runtimeType::startLargeRest()');
    set('description', 'Resting ...');
    start(true, new Duration(minutes: 15), []);
  }

  void start(bool resting, Duration timeRequired, List<String> tags) {
    set('running', true);
    set('resting', resting);
    set('timeRequired', timeRequired);
    set('timePassed', new Duration(minutes: 0));
    set('tags', tags);
    _timing.start();
    _timer = new Timer.periodic(new Duration(seconds: 1), tick);
  }

  bool validToStart() {
    if (description == null || description.isEmpty) {
      set('descriptionHelp', 'A task description is required');
      set('descriptionError', true);
      set('descriptionClassName', 'has-error');
      return false;
    }
    set('descriptionHelp', null);
    set('descriptionClassName', null);
    set('descriptionError', false);
    return true;
  }

  @reflectable
  void cancelTask([_, __]) {
    print('$runtimeType::cancelTask()');
    set('running', false);
    set('resting', false);
    if (description.startsWith('Resting')) {
      set('description', null);
      set('inputTags', null);
    }
    _timer.cancel();
    _timing.stop();
    _timing.reset();
  }

  void tick(Timer t) {
    print('$runtimeType::tick()');
    set('timePassed', _timing.elapsed);
    if (_timing.elapsed >= timeRequired) {
      complete();
    }
  }

  void complete() {
    print('$runtimeType::complete()');
    playAlert();

    bool wasRest = resting;
    if (!wasRest) {
      print('$runtimeType::complete(): Completing task');
      Map data = {
        'description': this.description,
        'tags': this.tags
      };
      fire('complete', detail: data);
    }

    cancelTask();
    set('description', null);
    set('inputTags', null);
    set('tags', []);

    if (!wasRest) {
      startSmallRest();
    }
  }

  void playAlert() {
    print('$runtimeType::playAlert()');
    if (resting) {
      this._restCompleteSound.currentTime = 0;
      this._restCompleteSound.play();
    } else {
      this._taskCompleteSound.currentTime = 0;
      this._taskCompleteSound.play();
    }
  }

  @reflectable
  void ready() {
    print('$runtimeType::ready()');
    this._taskCompleteSound = new AudioElement('resources/audio/task-complete.wav')
      ..load();
    this._restCompleteSound = new AudioElement('resources/audio/rest-complete.wav')
      ..load();
  }
}