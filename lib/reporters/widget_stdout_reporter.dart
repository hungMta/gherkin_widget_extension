import 'package:gherkin/gherkin.dart';
import 'package:logger/logger.dart';

import 'monochrome_printer.dart';

class WidgetStdoutReporter extends StdoutReporter {
  /// https://talyian.github.io/ansicolors/
  final AnsiColor neutralColor = AnsiColor.none();
  final AnsiColor debugColor = AnsiColor.fg(7); // gray
  final AnsiColor failColor = AnsiColor.fg(9);
  final AnsiColor warnColor = AnsiColor.fg(208);
  final AnsiColor passColor = AnsiColor.fg(10);
  final AnsiColor coolColor = AnsiColor.fg(45);

  final logger = Logger(printer: MonochromePrinter());

  @override
  Future<void> dispose() async {}

  @override
  Future<void> onScenarioStarted(StartedMessage message) {
    logger.i(coolColor("\n${"-" * 100}\n"));
    logger.i(coolColor(
        '${DateTime.now()} - Running scenario: ${message.name + _getContext(message.context)}'));
    return super.onScenarioStarted(message);
  }

  @override
  Future<void> onScenarioFinished(ScenarioFinishedMessage message) {
    var scenarioColor = message.passed ? passColor : failColor;
    var scenarioStatus = message.passed ? "PASSED" : "FAILED";
    logger.i("${scenarioColor(scenarioStatus)}: Scenario ${message.name}");
    return super.onScenarioFinished(message);
  }

  @override
  Future<void> onStepFinished(StepFinishedMessage message) {
    var stepColor = message.result.result == StepExecutionResult.pass
        ? passColor
        : failColor;
    String printMessage;
    if (message.result is ErroredStepResult) {
      var errorMessage = (message.result as ErroredStepResult);
      printMessage =
          failColor('${errorMessage.exception}\n${errorMessage.stackTrace}');
    } else {
      printMessage = [
        stepColor('  '),
        stepColor(_getStatePrefixIcon(message.result.result)),
        stepColor(message.name),
        neutralColor(_getExecutionDuration(message.result)),
        stepColor(_getReasonMessage(message.result)),
        stepColor(_getErrorMessage(message.result))
      ].join((' ')).trimRight();
    }
    logger.i(printMessage);
    return super.onStepFinished(message);
  }

  String _getReasonMessage(StepResult stepResult) =>
      (stepResult.resultReason != null && stepResult.resultReason!.isNotEmpty)
          ? '\n      ${stepResult.resultReason}'
          : '';

  String _getErrorMessage(StepResult stepResult) =>
      stepResult is ErroredStepResult
          ? '\n${stepResult.exception}\n${stepResult.stackTrace}'
          : '';

  String _getContext(RunnableDebugInformation? context) => neutralColor(
      "\t# ${_getFeatureFilePath(context)}:${context?.lineNumber}");

  String _getFeatureFilePath(RunnableDebugInformation? context) =>
      context?.filePath.replaceAll(RegExp(r'\.\\'), '') ?? '';

  String _getExecutionDuration(StepResult stepResult) =>
      ' (${stepResult.elapsedMilliseconds}ms)';

  String _getStatePrefixIcon(StepExecutionResult result) {
    switch (result) {
      case StepExecutionResult.pass:
        return '√';
      case StepExecutionResult.error:
      case StepExecutionResult.fail:
      case StepExecutionResult.timeout:
        return '×';
      case StepExecutionResult.skipped:
        return '-';
    }
  }
}
