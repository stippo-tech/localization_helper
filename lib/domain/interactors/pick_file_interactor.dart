import 'package:localization_helper/domain/model/file.dart';
import 'package:localization_helper/domain/services/file_picker.dart';

abstract interface class PickFileInteractor {
  Future<File?> pickFile();
}

final class PickFileInteractorImpl implements PickFileInteractor {
  final FileManager _filePicker;

  PickFileInteractorImpl(this._filePicker);

  @override
  Future<File?> pickFile() {
    return _filePicker.pickFile();
  }
}
