import 'package:localization_helper/domain/model/file.dart';

abstract interface class FileManager {
  Future<File?> pickFile();

  Future<void> saveFile(File file);

  Future<void> saveFilesInOneArchive(List<File> files);
}
