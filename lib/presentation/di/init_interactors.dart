part of 'init_di.dart';

void _initInteractors() {
  GetIt.I.registerSingleton<GetFilesInteractor>(
    GetFilesInteractorImpl(
      GetIt.I.get(),
      GetIt.I.get(),
    ),
  );
  GetIt.I.registerSingleton<PickFileInteractor>(
    PickFileInteractorImpl(
      GetIt.I.get(),
    ),
  );
}
