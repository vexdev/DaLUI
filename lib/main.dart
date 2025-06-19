import 'package:dalui/dalui_deps.dart';
import 'package:dalui/main_router.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = MainRouter();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DaluiDeps.buildDependencies(),
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
        return config.data!.provider(
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
}
