import 'dart:convert';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:localization_helper/domain/app_constants.dart';
import 'package:localization_helper/domain/model/generation_parameters.dart';
import 'package:localization_helper/domain/model/text_file.dart';

abstract interface class FilesFromExelGenerator {
  Future<List<TextFile>> generateFiles(
    Uint8List data,
    GenerationParameters parameters,
  );
}

class FilesFromExelGeneratorImpl implements FilesFromExelGenerator {
  @override
  Future<List<TextFile>> generateFiles(
    Uint8List excelData,
    GenerationParameters parameters,
  ) async {
    final excel = Excel.decodeBytes(excelData);
    final filesToGenerate = <String, Map<String, String>>{};
    final localizationLangs = <int, String>{};

    final firstRowData = excel.tables.values.first.row(0);
    final rowLength = firstRowData.length;
    final stringsKeysAndValues = <String, String>{};

    for (var i = 2; i < rowLength; i++) {
      final value = firstRowData[i]?.value;
      if (value != null) {
        final strValue = value.toString();
        localizationLangs[i] = strValue;
        filesToGenerate[strValue] = {};
      }
    }
    final rows = excel.tables.values.first.rows;
    for (var i = 1; i < rows.length; i++) {
      final row = rows[i];
      final key = row[1]?.value.toString() ?? 'no key';
      for (var k = 2; k < rowLength; k++) {
        filesToGenerate[localizationLangs[k]]?[key] =
            row[k]?.value.toString() ?? 'no value';
      }
      stringsKeysAndValues[row[0]?.value.toString() ?? 'no key'] = key;
    }

    final textFiles = <TextFile>[];

    final jsonEncoder =
        JsonEncoder.withIndent(' ' * parameters.jsonIndentInSpaces);

    // Add .json files
    textFiles.addAll(filesToGenerate.entries.map(
      (e) => TextFile(
        name: e.key,
        ext: 'json',
        text: '${jsonEncoder.convert(e.value)}\n',
      ),
    ));

    // Add .dart file
    textFiles.add(TextFile(
      name: parameters.dartFileName.isNotEmpty
          ? parameters.dartFileName
          : AppConstants.defaultDartFileName,
      ext: 'dart',
      text: '''
class L {
${stringsKeysAndValues.entries.map((e) => '${' ' * parameters.dartIndentInSpaces}static const ${e.key} = "${e.value}";').join('\n')}
}
''',
    ));
    return textFiles;
  }
}
