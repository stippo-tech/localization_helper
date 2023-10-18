import 'package:localization_helper/domain/model/file.dart';
import 'package:localization_helper/domain/model/text_file.dart';
import 'package:localization_helper/domain/services/file_picker.dart';
import 'package:localization_helper/domain/utils/json_generator.dart';

abstract interface class GetFilesInteractor {
  Future<void> getFiles(
    File data, {
    int? jsonIndentInSpaces,
    int? dartIndentInSpaces,
  });
}

class GetFilesInteractorImpl implements GetFilesInteractor {
  final FilesFromExelGenerator _jsonGenerator;
  final FileManager _fileManager;

  GetFilesInteractorImpl(
    this._jsonGenerator,
    this._fileManager,
  );

  @override
  Future<void> getFiles(
    File data, {
    int? jsonIndentInSpaces,
    int? dartIndentInSpaces,
  }) async {
    var files = <TextFile>[];
    files = await _jsonGenerator.generateFiles(
      data.bytes,
      jsonIndentInSpaces: jsonIndentInSpaces,
      dartIndentInSpaces: dartIndentInSpaces,
    );

    _fileManager.saveFilesInOneArchive(files);
  }
}
