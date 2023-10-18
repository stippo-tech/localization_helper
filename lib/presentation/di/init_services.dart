part of 'init_di.dart';

void _initServices() {
  GetIt.I.registerSingleton<FileManager>(
    FileManagerImpl(),
  );
}
