import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

part 'components/indent_settings_field.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _bloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Localization files generator',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: _bloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width / 5,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Upload excel file. First column should contain keys for dart file with constant strings. '
                        'Second column should contain keys for json localization files. '
                        'Values from columns after second will be used in localization files. '
                        'First value in this columns will be used in json file names. For example for "en" it will "en.json. "'
                        'Bellow you can see example of an excel file.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        child: Image.asset(
                          'assets/images/example.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.file?.name ?? '',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(width: 24),
                    TextButton(
                      onPressed: () => _bloc.add(HomeUploadFilePressed()),
                      child: Text(
                        'upload file',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _IndentSetting(
                  name: 'Dart file name',
                  value: state.dartFileName,
                  exceptionText: null,
                  onChanged: (value) =>
                      _bloc.add(HomeDartFileNameChanged(value)),
                ),
                const SizedBox(height: 8),
                _IndentSetting(
                  name: 'Dart file indent',
                  value: state.dartIndent.toString(),
                  exceptionText: state.dartException,
                  onChanged: (value) => _bloc.add(HomeDartIndentChanged(value)),
                ),
                const SizedBox(height: 8),
                _IndentSetting(
                  name: 'Json file indent',
                  value: state.jsonIndent.toString(),
                  exceptionText: state.jsonException,
                  onChanged: (value) => _bloc.add(HomeJsonIndentChanged(value)),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: state.file == null
                      ? null
                      : () => _bloc.add(HomeGenerateFilesPressed()),
                  child: Text(
                    'generate files',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
