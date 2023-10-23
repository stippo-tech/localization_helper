import 'package:localization_helper/domain/app_constants.dart';

class GenerationParameters {
  final int jsonIndentInSpaces;
  final int dartIndentInSpaces;
  final String dartFileName;

  const GenerationParameters._(
    this.jsonIndentInSpaces,
    this.dartIndentInSpaces,
    this.dartFileName,
  );

  factory GenerationParameters.fromUserData({
    int? jsonIndentInSpaces,
    int? dartIndentInSpaces,
    String? dartFileName,
  }) =>
      GenerationParameters._(
        jsonIndentInSpaces ?? AppConstants.defaultJsonIndent,
        dartIndentInSpaces ?? AppConstants.defaultDartIndent,
        dartFileName ?? AppConstants.defaultDartFileName,
      );
}
