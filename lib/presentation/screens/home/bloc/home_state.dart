part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    File? file,
    @Default(AppConstants.defaultDartIndent) int? dartIndent,
    @Default(AppConstants.defaultJsonIndent) int? jsonIndent,
    @Default(AppConstants.defaultDartFileName) String dartFileName,
    String? dartException,
    String? jsonException,
  }) = _HomeState;
}
