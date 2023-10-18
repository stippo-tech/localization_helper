import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:localization_helper/domain/app_constants.dart';
import 'package:localization_helper/domain/interactors/get_files_interactor.dart';
import 'package:localization_helper/domain/interactors/pick_file_interactor.dart';
import 'package:localization_helper/domain/model/file.dart';

part 'home_state.dart';
part 'home_event.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _pickFileInteractor = GetIt.I.get<PickFileInteractor>();
  final _getFilesInteractor = GetIt.I.get<GetFilesInteractor>();

  HomeBloc() : super(const HomeState()) {
    on<HomeUploadFilePressed>((event, emit) async {
      final result = await _pickFileInteractor.pickFile();
      if (result != null) {
        emit(state.copyWith(file: result));
      }
    });
    on<HomeGenerateFilesPressed>((event, emit) {
      final file = state.file;
      if (file != null) {
        _getFilesInteractor.getFiles(
          file,
          dartIndentInSpaces: state.dartIndent,
          jsonIndentInSpaces: state.jsonIndent,
        );
      }
    });
    on<HomeDartIndentChanged>((event, emit) {
      final value = int.tryParse(event.value);
      emit(state.copyWith(
        dartIndent: value,
        dartException: value == null
            ? 'Dart indent value not selected or incorrect. Default value will be used: ${AppConstants.defaultDartIndent}'
            : null,
      ));
    });
    on<HomeJsonIndentChanged>((event, emit) {
      final value = int.tryParse(event.value);
      emit(state.copyWith(
        dartIndent: value,
        dartException: value == null
            ? 'Json indent value not selected or incorrect. Default value will be used: ${AppConstants.defaultJsonIndent}'
            : null,
      ));
      emit(state.copyWith(jsonIndent: value));
    });
  }
}
