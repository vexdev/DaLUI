import 'package:dalui/main_router.dart';
import 'package:dalui/net/datastore_client.dart';
import 'package:dalui/repository/datastore_repository.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = MainRouter();

  @override
  Widget build(BuildContext context) {
    final host = const String.fromEnvironment(
      'HOST',
      defaultValue: 'localhost',
    );
    final port = const int.fromEnvironment('PORT', defaultValue: 8080);
    final projectId = const String.fromEnvironment('PROJECT_ID');
    if (projectId.isEmpty) {
      throw ArgumentError('The environment variable PROJECT_ID must be set');
    }
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) =>
              DatastoreRepository(DatastoreClient(host, port, projectId)),
        ),
      ],
      child: MaterialApp.router(
        title: 'DaLUI',
        theme: FlexThemeData.light(
          scheme: FlexScheme.mandyRed,
          useMaterial3: true,
          typography: Typography.material2021(),
        ),
        darkTheme: FlexThemeData.dark(
          scheme: FlexScheme.mandyRed,
          useMaterial3: true,
          typography: Typography.material2021(),
        ),
        themeMode: ThemeMode.system,
        routerConfig: _router.config(includePrefixMatches: true),
      ),
    );
  }
}
