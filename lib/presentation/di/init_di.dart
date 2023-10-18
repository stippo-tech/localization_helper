import 'package:get_it/get_it.dart';
import 'package:localization_helper/device/file_manager_impl.dart';
import 'package:localization_helper/domain/interactors/get_files_interactor.dart';
import 'package:localization_helper/domain/interactors/pick_file_interactor.dart';
import 'package:localization_helper/domain/services/file_picker.dart';
import 'package:localization_helper/domain/utils/json_generator.dart';
import 'package:localization_helper/presentation/router/router.dart';

part 'init_interactors.dart';
part 'init_services.dart';
part 'init_utils.dart';

void initDI() {
  GetIt.I.registerLazySingleton<AppRouter>(
    () => AppRouter(),
  );
  _initUtils();
  _initServices();
  _initInteractors();
}
