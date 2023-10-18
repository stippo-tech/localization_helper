import 'package:localization_helper/domain/model/text_file.dart';

abstract interface class FileDownloader {
  void downloadTextFile(TextFile data);
}
