import 'package:gherkin/gherkin.dart';
import 'package:gherkin_widget_extension/gherkin_widget_extension.dart';

import '../buckets/example_bucket.dart';
import '../counter_widget_object.dart';

final counterWidgetObject = CounterWidgetObject();

StepDefinitionGeneric<WidgetCucumberWorld> givenAFreshApp() {
  return given<WidgetCucumberWorld>('I launch the counter application',
      (context) async {
    currentWorld.bucket = ExampleBucket();
    counterWidgetObject.pumpItUp();
  });
}

StepDefinitionGeneric<WidgetCucumberWorld> whenButtonTapped() {
  return when2<String, int, WidgetCucumberWorld>(
      'I tap the {string} button {int} times', (key, count, context) async {
    currentWorld.readBucket<ExampleBucket>().nbActions = count;
    counterWidgetObject.tapTheButton(key, count);
  });
}

StepDefinitionGeneric<WidgetCucumberWorld> thenCounterIsUpdated() {
  return given2<String, String, WidgetCucumberWorld>(
      'I expect the {string} to be {string}', (key, count, context) async {
    counterWidgetObject.checkDisplayedNumber(count);
  });
}
