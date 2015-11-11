# dardo - A Pomodoro timer written in Dart and Polymer

## What is this?

Dardo is a web-based [Pomodoro][pomodoro] timer and tracker.

It is written in [Dart][dart] using [Polymer][polymer] and was an exercise to
explore those techologies a little further.


## What does it do?

Dardo has a timer for the current task (25 minutes) which countsdown. After
completion it makes a history entry and you select to start a new task or rest.

Dardo also shows some basic statistics of daily counts.

The history of tasks is recorded to browser local storage.


## What planned bits are missing?

Although it does a daily statistic, it doesn't do a weekly as I hadn't yet
worked out how to calculate the week of the year using the Dart DateTime class.

It also doesn't show a sparkline of the daily totals as Polymer doesn't support
an unescaped bound attribute (the URL of the embedded SVG).


## What bits are broken?

Running in anything except Chrome doesn't work. That seems like a problem with
the [webcomponents][webcomponents] polyfils but the Polymer.dart documentation
and tutorials out there don't indicate to specifically add in a "platform.js"
or anything.


## Building and running it

```sh
pub build --mode=release
```

Then deploy it to a web server.

## License

Dardo is released under the [MIT License](http://www.opensource.org/licenses/MIT).

## Copyright

Copyright (c) 2015 Ashley Richardson.


[pomodoro]: https://en.wikipedia.org/wiki/Pomodoro_Technique
[dart]: https://www.dartlang.org
[polymer]: https://github.com/dart-lang/polymer-dart
[webcomponents]: https://github.com/WebComponents/webcomponentsjs
