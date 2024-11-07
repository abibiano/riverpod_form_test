import 'package:freezed_annotation/freezed_annotation.dart';

part 'person.freezed.dart';
part 'person.g.dart';

@freezed
class Person with _$Person {
  const factory Person({
    int? id,
    required String firstName,
    required String lastName,
    required int? age,
  }) = _Customer;

  factory Person.fromJson(Map<String, Object?> json) => _$PersonFromJson(json);
}
