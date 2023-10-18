import 'dart:convert';
import 'dart:typed_data';

import 'package:localization_helper/domain/model/file.dart';

class TextFile implements File {
  @override
  final String name;
  @override
  final String ext;
  final String text;

  const TextFile({
    required this.name,
    required this.ext,
    required this.text,
  });

  @override
  Uint8List get bytes => Uint8List.fromList(utf8.encode(text));
}
