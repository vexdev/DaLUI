import 'package:dalui/main_router.dart';
import 'package:dalui/net/datastore_client.dart';
import 'package:dalui/repository/datastore_repository.dart';
import 'package:dio/dio.dart';
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
    return FutureBuilder(
      future: fetchConfig(),
      builder: (context, config) {
        if (config.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text(
                  'Error: ${config.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          );
        }
        if (!config.hasData) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (_) => DatastoreRepository(
                DatastoreClient(config.data!.host, config.data!.projectId),
              ),
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
      },
    );
  }

  Future<DaluiConfig> fetchConfig() async {
    final host = const String.fromEnvironment(
      'DALUI_HOST',
      defaultValue: 'localhost:8080',
    );
    final projectId = const String.fromEnvironment('DALUI_DS_PROJECT');
    if (projectId.isEmpty) {
      // Try fetching from nginx (Workaround for Docker setup)
      final dio = Dio(BaseOptions(baseUrl: Uri.base.resolve('/').toString()));
      try {
        final host = await dio.get('/dalui-host');
        final project = await dio.get('/dalui-ds-project');
        return DaluiConfig(
          host: host.data as String,
          projectId: project.data as String,
        );
      } catch (e) {
        throw ArgumentError(
          'The environment variable DALUI_DS_PROJECT must be set or the /project endpoint must be available',
        );
      }
    }
    return DaluiConfig(host: host, projectId: projectId);
  }
}

class DaluiConfig {
  final String host;
  final String projectId;
  const DaluiConfig({required this.host, required this.projectId});
}
