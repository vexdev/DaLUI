import 'package:auto_route/auto_route.dart';
import 'package:dalui/feature/kind/entity_button.dart';
import 'package:dalui/feature/kind/kind_cubit.dart';
import 'package:dalui/feature/kind/kind_state.dart';
import 'package:dalui/model/entity.dart';
import 'package:dalui/model/value.dart';
import 'package:dalui/widget/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class KindScreen extends StatefulWidget implements AutoRouteWrapper {
  const KindScreen({super.key});

  @override
  State<KindScreen> createState() => _KindScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => KindCubit(context.read(), context.read())..load(),
      child: this,
    );
  }
}

class _KindScreenState extends State<KindScreen> {
  String? selectedKind;
  final ScrollController _hScrollCtrl = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KindCubit, KindState>(
      builder: (context, state) {
        return Scaffold(
          body: (state.isLoading)
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text('Select a kind:'),
                          const SizedBox(width: 8),
                          DropdownButton<String>(
                            value: state.selectedKind,
                            items: state.kinds.map((kind) {
                              return DropdownMenuItem<String>(
                                value: kind,
                                child: Text(kind),
                              );
                            }).toList(),
                            onChanged: _selectKind,
                          ),
                          const SizedBox(width: 8),
                          const Text('Or search with a GQL query:'),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              onSubmitted: (query) {
                                if (query.isNotEmpty) {
                                  context.read<KindCubit>().runQuery(query);
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "GQL Query",
                                prefixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (state.error != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.red[100],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Error: ${state.error}',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    Expanded(child: _buildEntitiesTable(state)),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildEntitiesTable(KindState state) {
    if (state.entities.isEmpty) {
      return const Center(child: Text('No entities found.'));
    }
    final columns = (["key", "actions"].followedBy(state.columns)).toList();
    return SelectionArea(
      child: Scrollbar(
        controller: _hScrollCtrl,
        scrollbarOrientation: ScrollbarOrientation.bottom,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _hScrollCtrl,
          child: SingleChildScrollView(
            child: DataTable(
              columns: columns.map((column) {
                return DataColumn(
                  label: Text(
                    column,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
              rows: state.entities.map((entity) {
                return _buildEntityRow(columns, entity);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  DataRow _buildEntityRow(List<String> columns, Entity entity) {
    return DataRow(
      cells: columns.map((column) {
        if (column == 'key') return _buildKeyCell(entity);
        if (column == 'actions') return _buildActionsCell(entity);
        final value = entity.properties[column];
        if (value == null) return _buildNotSetCell();
        if (value is ValueEntity) return _buildEntityPropertyCell(value);
        return _buildOtherPropertyCell(value);
      }).toList(),
    );
  }

  DataCell _buildNotSetCell() {
    return const DataCell(
      Text('Not Set', style: TextStyle(fontStyle: FontStyle.italic)),
    );
  }

  DataCell _buildKeyCell(Entity entity) {
    final keyName = entity.key?.path.first.name ?? 'No Key';
    return DataCell(
      Text(keyName, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  DataCell _buildActionsCell(Entity entity) {
    return DataCell(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showConfirmationDialog(
                context,
                onConfirm: () {
                  context.read<KindCubit>().deleteEntity(entity.key!);
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: null, // TODO: Implement edit functionality
          ),
        ],
      ),
    );
  }

  DataCell _buildEntityPropertyCell(ValueEntity value) {
    return DataCell(EntityButton(value: value));
  }

  DataCell _buildOtherPropertyCell(Value value) {
    return DataCell(Text(value.readable));
  }

  void _selectKind(String? kind) {
    if (kind != null) {
      context.read<KindCubit>().selectKind(kind);
    }
  }
}
