part of 'init_di.dart';

void _initUtils() {
  GetIt.I.registerSingleton<FilesFromExelGenerator>(
    FilesFromExelGeneratorImpl(),
  );
}
