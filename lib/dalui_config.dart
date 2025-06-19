import 'package:dio/dio.dart';

class DaluiConfig {
  final String host;
  final String projectId;

  DaluiConfig._({required this.host, required this.projectId});

  static Future<DaluiConfig> fetchConfig() async {
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
        return DaluiConfig._(
          host: host.data as String,
          projectId: project.data as String,
        );
      } catch (e) {
        throw ArgumentError(
          'The environment variable DALUI_DS_PROJECT must be set or the /project endpoint must be available',
        );
      }
    }
    return DaluiConfig._(host: host, projectId: projectId);
  }
}
