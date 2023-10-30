import 'package:archive/archive.dart';
import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:localization_helper/domain/model/file.dart';
import 'package:localization_helper/domain/services/file_picker.dart';

final class FileManagerImpl implements FileManager {
  final _picker = file_picker.FilePicker.platform;
  final _saver = FileSaver();

  @override
  Future<File?> pickFile() async {
    final sdf = await _picker.pickFiles(
      dialogTitle: 'Add exel file',
      allowMultiple: false,
      withData: true,
    );
    final file = sdf?.files.first;
    if (file == null) return null;
    return File.fromPlatformFile(file);
  }

  @override
  Future<void> saveFile(File file) async {
    if (kIsWeb) {
      await _saver.saveFile(
        name: file.name,
        ext: file.ext,
        bytes: file.bytes,
      );
    } else {
      await _saver.saveAs(
        name: file.name,
        ext: file.ext,
        bytes: file.bytes,
        mimeType: MimeType.zip,
      );
    }
  }

  @override
  Future<void> saveFilesInOneArchive(List<File> files) async {
    var encoder = ZipEncoder();
    final outputStream = OutputStream();
    final archive = Archive();
    for (final file in files) {
      archive.addFile(ArchiveFile(
        '${file.name}.${file.ext}',
        0,
        file.bytes,
      ));
    }
    final byteList = encoder.encode(
      archive,
      level: Deflate.BEST_COMPRESSION,
      output: outputStream,
    );
    if (byteList == null) return;

    saveFile(File(
      name: 'localization',
      ext: 'zip',
      bytes: Uint8List.fromList(byteList),
    ));
  }
}
