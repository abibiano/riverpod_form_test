import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_routes.dart';
import 'person.dart';
import 'person_respository.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personList = ref.watch(personRepositoryGetAllProvider);
    final pendingDelete = useState<Future<void>?>(null);
    final snapshot = useFuture(pendingDelete.value);

    handleDelete(int personId) async {
      try {
        await ref.read(personRepositoryProvider).delete(personId);
        ref.invalidate(personRepositoryGetAllProvider);
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error deleting person: $e')));
        }
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints.tightFor(width: 800),
            padding: const EdgeInsets.all(16),
            child: switch (personList) {
              AsyncData(:final List<Person> value) => Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (_, __) => const Divider(),
                        itemCount: value.length,
                        itemBuilder: (_, index) {
                          final person = value[index];
                          return ListTile(
                            title:
                                Text('${person.firstName} ${person.lastName}'),
                            subtitle: Text('Age: ${person.age}'),
                            onTap: snapshot.connectionState !=
                                    ConnectionState.waiting
                                ? () async {
                                    final result =
                                        await PersonEditPageRoute(person.id!)
                                            .push(context);
                                    if (result != null) {
                                      ref.invalidate(
                                          personRepositoryGetAllProvider);
                                    }
                                  }
                                : null,
                            trailing: IconButton(
                              onPressed: snapshot.connectionState !=
                                      ConnectionState.waiting
                                  ? () => pendingDelete.value =
                                      handleDelete(person.id!)
                                  : null,
                              icon: Icon(Icons.delete,
                                  color: snapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? Theme.of(context).disabledColor
                                      : Theme.of(context).colorScheme.error),
                            ),
                          );
                        },
                      ),
                    ),
                    const Gap(16),
                    ElevatedButton(
                      onPressed: snapshot.connectionState !=
                              ConnectionState.waiting
                          ? () async {
                              final result =
                                  await PersonNewPageRoute().push(context);
                              if (result != null) {
                                ref.invalidate(personRepositoryGetAllProvider);
                              }
                            }
                          : null,
                      child: const Text('Add Person'),
                    ),
                  ],
                ),
              AsyncError() => Center(
                  child: const Text('Oops, something unexpected happened')),
              _ => const LinearProgressIndicator(),
            },
          ),
        ));
  }
}
