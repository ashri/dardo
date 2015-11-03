@HtmlImport('main_app.html')
library dardo.lib.main_app;

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_input.dart';
import 'package:web_components/web_components.dart';

/// Uses [IronInput]
@PolymerRegister('main-app')
class MainApp extends PolymerElement {
  @property
  String text;

  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created();

  @reflectable
  String reverseText(String text) {
    return text
        .split('')
        .reversed
        .join('');
  }

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

//  /// Called when main-app has been fully prepared (Shadow DOM created,
//  /// property observers set up, event listeners attached).
  ready() {
    print('$runtimeType::ready()');
  }
}
