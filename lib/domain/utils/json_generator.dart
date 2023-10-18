import 'dart:convert';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:localization_helper/domain/app_constants.dart';
import 'package:localization_helper/domain/model/text_file.dart';

abstract interface class FilesFromExelGenerator {
  Future<List<TextFile>> generateFiles(
    Uint8List data, {
    int? jsonIndentInSpaces,
    int? dartIndentInSpaces,
  });
}

class FilesFromExelGeneratorImpl implements FilesFromExelGenerator {
  @override
  Future<List<TextFile>> generateFiles(
    Uint8List excelData, {
    int? jsonIndentInSpaces,
    int? dartIndentInSpaces,
  }) async {
    final excel = Excel.decodeBytes(excelData);
    final jsonIndent = jsonIndentInSpaces ?? AppConstants.defaultJsonIndent;
    final dartIndent = jsonIndentInSpaces ?? AppConstants.defaultJsonIndent;

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

    final jsonEncoder = JsonEncoder.withIndent(' ' * jsonIndent);

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
      name: 'language_constants',
      ext: 'dart',
      text: '''
class L {
${stringsKeysAndValues.entries.map((e) => '${' ' * dartIndent}static const ${e.key} = "${e.value}";').join('\n')}
}
''',
    ));
    return textFiles;
  }
}