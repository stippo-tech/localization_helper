part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    File? file,
    @Default(AppConstants.defaultDartIndent) int? dartIndent,
    @Default(AppConstants.defaultJsonIndent) int? jsonIndent,
    String? dartException,
    String? jsonException,
  }) = _HomeState;
}
