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
                    _buildEntitiesList(state),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildEntitiesList(KindState state) {
    if (state.entities.isEmpty) {
      return const Center(child: Text('No entities found.'));
    }
    final columns = (["key", "actions"].followedBy(state.columns)).toList();
    return Expanded(
      child: SelectionArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              border: TableBorder.all(
                borderRadius: BorderRadius.circular(8.0),
                color: Theme.of(context).dividerColor,
              ),
              defaultColumnWidth: const IntrinsicColumnWidth(),
              children: [
                _buildHeaderRow(columns),
                ...state.entities.map((entity) {
                  return _buildEntityRow(columns, entity);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow _buildHeaderRow(List<String> columns) {
    return TableRow(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      children: columns.map((column) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              column,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  TableRow _buildEntityRow(List<String> columns, Entity entity) {
    return TableRow(
      children: columns.map((column) {
        if (column == 'key') return _buildKeyCell(entity);
        if (column == 'actions') return _buildActionsCell(entity);
        final value = entity.properties[column];
        if (value == null) {
          return Text(
            'Not Set',
            style: const TextStyle(fontStyle: FontStyle.italic),
          );
        }
        if (value is ValueEntity) return _buildEntityPropertyCell(value);
        return _buildOtherPropertyCell(value);
      }).toList(),
    );
  }

  Widget _buildKeyCell(Entity entity) {
    final keyName = entity.key?.path.first.name;
    if (keyName == null) return const Text('No Key');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(keyName, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildActionsCell(Entity entity) {
    return Row(
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
    );
  }

  Widget _buildEntityPropertyCell(ValueEntity value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: EntityButton(value: value),
    );
  }

  Widget _buildOtherPropertyCell(Value value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(value.readable),
    );
  }

  void _selectKind(String? kind) {
    if (kind != null) {
      context.read<KindCubit>().selectKind(kind);
    }
  }
}
