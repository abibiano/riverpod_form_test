import 'dart:math';

import 'package:faker/faker.dart' as fake;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'person.dart';

part 'person_respository.g.dart';

@Riverpod(keepAlive: true)
PersonRepository personRepository(Ref ref) => PersonRepository();

@riverpod
Future<Person?> personRepositoryGetOne(Ref ref, int id) async =>
    ref.watch(personRepositoryProvider).getOne(id);

@riverpod
Future<List<Person>> personRepositoryGetAll(Ref ref) async =>
    ref.watch(personRepositoryProvider).getAll();

final List<Person> personList = [];

class PersonRepository {
  PersonRepository() {
    personList.addAll(_generatePersonList());
  }

  static List<Person> _generatePersonList() {
    var faker = fake.Faker();
    return List.generate(5, (index) {
      return Person.fromJson({
        'id': index,
        'firstName': faker.person.firstName(),
        'lastName': faker.person.lastName(),
        'age': faker.randomGenerator.integer(100, min: 18)
      });
    });
  }

  Future<List<Person>> getAll() async {
    await Future.delayed(Duration(seconds: 1));
    return personList;
  }

  Future<Person?> getOne(int id) async {
    await Future.delayed(Duration(seconds: 1));

    return personList.firstWhere((element) => element.id == id);
  }

  Future<void> save(Person person) async {
    await Future.delayed(Duration(seconds: 1));
    final random = Random();
    if (random.nextInt(5) == 0) {
      throw Exception('Error saving person');
    }
    if (person.id == null) {
      personList.add(person.copyWith(id: personList.length));
    } else {
      final index = personList.indexWhere((element) => element.id == person.id);
      personList[index] = person;
    }
  }

  Future<void> delete(int id) async {
    await Future.delayed(Duration(seconds: 1));
    final random = Random();
    if (random.nextInt(2) == 0) {
      throw Exception('Error deleting person');
    }
    final index = personList.indexWhere((element) => element.id == id);
    if (index != -1) {
      personList.removeAt(index);
    }
  }
}
