import 'dart:io';

import 'package:gherkin/gherkin.dart';
import 'package:gherkin_widget_extension/reporters/widget_stdout_reporter.dart';
import 'package:gherkin_widget_extension/reporters/widget_test_run_summary_reporter.dart';
import 'package:gherkin_widget_extension/reporters/xml_reporter.dart';

import 'package:gherkin_widget_extension/world/widget_hooks.dart';

import 'step_definitions/steps.dart';

TestConfiguration testWidgetsConfiguration({
  String featurePath = '*.feature',
}) {
  var testConfiguration = TestConfiguration.DEFAULT(
    [
      givenAFreshApp(),
      whenButtonTapped(),
      thenCounterIsUpdated(),
    ],
    featurePath: featurePath,
  );
  testConfiguration
    ..hooks = [WidgetHooks(dumpFolderPath: 'widget_tests_report_folder')]
    ..reporters = [
      WidgetStdoutReporter(),
      WidgetTestRunSummaryReporter(),
      XmlReporter(dirRoot: Directory.current.path),
    ]
    ..defaultTimeout = const Duration(milliseconds: 60000 * 10);
  return testConfiguration;
}
