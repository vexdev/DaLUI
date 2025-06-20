import 'package:dalui/feature/kind/kind_state.dart';
import 'package:dalui/model/entity_key.dart';
import 'package:dalui/net/datastore_error.dart';
import 'package:dalui/repository/datastore_repository.dart';
import 'package:dalui/repository/localstore_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';

class KindCubit extends Cubit<KindState> {
  final DatastoreRepository _datastoreRepository;
  final LocalstoreRepository _localstoreRepository;
  Set<String> _kinds = {};
  final Logger _logger = Logger();

  KindCubit(this._datastoreRepository, this._localstoreRepository)
    : super(KindState.initial());

  void load() async {
    runOrError(() async {
      _kinds = await _datastoreRepository.getKinds();
      if (_kinds.isNotEmpty) {
        final storedKind = await _localstoreRepository.getSelectedKind();
        selectKind(storedKind ?? _kinds.first);
      } else {
        emit(KindState.empty());
      }
    });
  }

  void selectKind(String kind) async {
    if (!_kinds.contains(kind)) {
      _logger.w("Kind $kind not found in available kinds: $_kinds");
      return;
    }
    runOrError(() async {
      await _localstoreRepository.storeSelectedKind(kind);
      final entities = await _datastoreRepository.getAllEntities(kind);
      emit(
        KindState(
          kinds: _kinds.toList(),
          entities: entities.toList(),
          selectedKind: kind,
        ),
      );
    });
  }

  void runQuery(String query) async {
    runOrError(() async {
      final entities = await _datastoreRepository.query(query);
      emit(
        KindState(
          kinds: _kinds.toList(),
          entities: entities.toList(),
          selectedKind: state.selectedKind,
        ),
      );
    });
  }

  void runOrError(Function() action) async {
    try {
      await action();
    } catch (e, stackTrace) {
      var errorMessage = e.toString();
      if (e is DioException) {
        final errorResponseData = e.response?.data;
        if (errorResponseData != null) {
          final er = DatastoreErrorContainer.fromJson(errorResponseData);
          errorMessage =
              er.error?.message ?? e.message ?? 'DioException occurred';
        } else {
          errorMessage = e.message ?? 'DioException occurred';
        }
        _logger.w("DioException: $errorMessage");
      }
      _logger.f("Error querying db", error: e, stackTrace: stackTrace);
      emit(
        KindState(
          kinds: _kinds.toList(),
          entities: state.entities,
          selectedKind: state.selectedKind,
          error: errorMessage,
        ),
      );
    }
  }

  void deleteEntity(EntityKey entityKey) {
    runOrError(() async {
      await _datastoreRepository.delete([entityKey]);
      if (state.selectedKind != null) {
        selectKind(state.selectedKind!);
      }
    });
  }

  void deleteEntities(List<EntityKey> list) {
    runOrError(() async {
      await _datastoreRepository.delete(list);
      if (state.selectedKind != null) {
        selectKind(state.selectedKind!);
      }
    });
  }
}
