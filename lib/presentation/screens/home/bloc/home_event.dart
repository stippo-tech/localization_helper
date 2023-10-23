part of 'home_bloc.dart';

@immutable
abstract interface class HomeEvent {}

class HomeUploadFilePressed implements HomeEvent {}

class HomeGenerateFilesPressed implements HomeEvent {}

class HomeDartIndentChanged implements HomeEvent {
  final String value;

  HomeDartIndentChanged(this.value);
}

class HomeJsonIndentChanged implements HomeEvent {
  final String value;

  HomeJsonIndentChanged(this.value);
}

class HomeDartFileNameChanged implements HomeEvent {
  final String value;

  HomeDartFileNameChanged(this.value);
}
