import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'person.dart';
import 'person_respository.dart';

class PersonEditPage extends HookConsumerWidget {
  const PersonEditPage(this.personId, {super.key});
  final int? personId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final person = personId != null
        ? ref.watch(personRepositoryGetOneProvider(personId!))
        : AsyncData(Person(firstName: '', lastName: '', age: null));

    return Scaffold(
        appBar: AppBar(
          title: Text('Person Edit Page'),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints.tightFor(width: 800),
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: switch (person) {
                AsyncData(value: final Person? person) => person == null
                    ? Center(child: const Text('Person not found'))
                    : _PersonEditPageForm(
                        formKey: formKey,
                        initialPerson: person,
                      ),
                AsyncError() => Center(
                    child: const Text('Oops, something unexpected happened')),
                _ => const LinearProgressIndicator(),
              },
            ),
          ),
        ));
  }
}

class _PersonEditPageForm extends HookConsumerWidget {
  const _PersonEditPageForm({
    required this.formKey,
    required this.initialPerson,
  });

  final Person initialPerson;
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingSave = useState<Future<void>?>(null);
    final snapshot = useFuture(pendingSave.value);

    final firstName = useState('');
    final lastName = useState('');
    final ValueNotifier<int?> age = useState(null);

    Future<void> handleSubmit() async {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      final currentState = formKey.currentState;
      if (currentState != null && currentState.validate()) {
        currentState.save();

        final person = Person(
          firstName: firstName.value,
          lastName: lastName.value,
          age: age.value,
        );
        try {
          await ref.read(personRepositoryProvider).save(person);
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Form Saved')),
          );
          GoRouter.of(context).pop(true);
        } catch (e) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error saving person',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onError)),
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Form is not valid')),
        );
      }
    }

    return FormBuilder(
      key: formKey,
      enabled: snapshot.connectionState != ConnectionState.waiting,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FormBuilderTextField(
            name: 'firstName',
            onSaved: (value) => firstName.value = value ?? '',
            decoration: const InputDecoration(labelText: 'First Name'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
            initialValue: initialPerson.firstName,
          ),
          Gap(8),
          FormBuilderTextField(
            name: 'lastName',
            onSaved: (value) => lastName.value = value ?? '',
            decoration: const InputDecoration(labelText: 'Last Name'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
            initialValue: initialPerson.lastName,
          ),
          Gap(8),
          FormBuilderTextField(
            name: 'age',
            onSaved: (value) =>
                age.value = value != null ? int.tryParse(value) : null,
            decoration: const InputDecoration(labelText: 'Age'),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
            initialValue: initialPerson.age.toString(),
          ),
          Gap(16),
          OutlinedButton(
            onPressed: snapshot.connectionState != ConnectionState.waiting
                ? () => pendingSave.value = handleSubmit()
                : null,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
