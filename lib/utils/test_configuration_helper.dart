import 'package:gherkin/gherkin.dart';

extension TestConfigurationHelper on TestConfiguration {
  TestConfiguration copyWith({
    Iterable<Pattern>? features,
    String? featureDefaultLanguage,
    String? tagExpression,
    Duration? defaultTimeout,
    ExecutionOrder? order,
    Iterable<StepDefinitionGeneric>? stepDefinitions,
    Iterable<CustomParameter<dynamic>>? customStepParameterDefinitions,
    Iterable<Hook>? hooks,
    Iterable<Reporter>? reporters,
    CreateWorld? createWorld,
    FeatureFileMatcher? featureFileMatcher,
    FeatureFileReader? featureFileReader,
    bool? stopAfterTestFailed,
  }) {
    this.features = features ?? this.features;
    this.featureDefaultLanguage =
        featureDefaultLanguage ?? this.featureDefaultLanguage;
    this.defaultTimeout = defaultTimeout ?? this.defaultTimeout;
    this.order = order ?? this.order;
    this.stepDefinitions = stepDefinitions ?? this.stepDefinitions;
    this.customStepParameterDefinitions =
        customStepParameterDefinitions ?? this.customStepParameterDefinitions;
    this.hooks = hooks ?? this.hooks;
    this.reporters = reporters ?? this.reporters;
    this.createWorld = createWorld ?? this.createWorld;
    this.featureFileMatcher = featureFileMatcher ?? this.featureFileMatcher;
    this.featureFileReader = featureFileReader ?? this.featureFileReader;
    this.stopAfterTestFailed = stopAfterTestFailed ?? this.stopAfterTestFailed;
    return this;
  }
}
