import 'package:dalui/dalui_config.dart';
import 'package:dalui/net/datastore_client.dart';
import 'package:dalui/repository/datastore_repository.dart';
import 'package:dalui/repository/localstore_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DaluiDeps {
  final List<SingleChildWidget> _providers;

  DaluiDeps._({required List<SingleChildWidget> providers})
    : _providers = providers;

  static Future<DaluiDeps> buildDependencies() async {
    final config = await DaluiConfig.fetchConfig();
    final client = DatastoreClient(config.host, config.projectId);
    final sharedPreferences = await SharedPreferences.getInstance();

    return DaluiDeps._(
      providers: [
        RepositoryProvider.value(value: config),
        RepositoryProvider.value(value: DatastoreRepository(client)),
        RepositoryProvider.value(
          value: LocalstoreRepository(sharedPreferences),
        ),
      ],
    );
  }

  MultiRepositoryProvider provider({required Widget child}) {
    return MultiRepositoryProvider(providers: _providers, child: child);
  }
}
