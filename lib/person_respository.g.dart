// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_respository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$personRepositoryHash() => r'3bd4bc76573c422e18e6c6664d5119745384b4e2';

/// See also [personRepository].
@ProviderFor(personRepository)
final personRepositoryProvider = Provider<PersonRepository>.internal(
  personRepository,
  name: r'personRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$personRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PersonRepositoryRef = ProviderRef<PersonRepository>;
String _$personRepositoryGetOneHash() =>
    r'fbbbb119af77761f9d47836c41ea55116feb2c27';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [personRepositoryGetOne].
@ProviderFor(personRepositoryGetOne)
const personRepositoryGetOneProvider = PersonRepositoryGetOneFamily();

/// See also [personRepositoryGetOne].
class PersonRepositoryGetOneFamily extends Family<AsyncValue<Person?>> {
  /// See also [personRepositoryGetOne].
  const PersonRepositoryGetOneFamily();

  /// See also [personRepositoryGetOne].
  PersonRepositoryGetOneProvider call(
    int id,
  ) {
    return PersonRepositoryGetOneProvider(
      id,
    );
  }

  @override
  PersonRepositoryGetOneProvider getProviderOverride(
    covariant PersonRepositoryGetOneProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'personRepositoryGetOneProvider';
}

/// See also [personRepositoryGetOne].
class PersonRepositoryGetOneProvider
    extends AutoDisposeFutureProvider<Person?> {
  /// See also [personRepositoryGetOne].
  PersonRepositoryGetOneProvider(
    int id,
  ) : this._internal(
          (ref) => personRepositoryGetOne(
            ref as PersonRepositoryGetOneRef,
            id,
          ),
          from: personRepositoryGetOneProvider,
          name: r'personRepositoryGetOneProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$personRepositoryGetOneHash,
          dependencies: PersonRepositoryGetOneFamily._dependencies,
          allTransitiveDependencies:
              PersonRepositoryGetOneFamily._allTransitiveDependencies,
          id: id,
        );

  PersonRepositoryGetOneProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<Person?> Function(PersonRepositoryGetOneRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PersonRepositoryGetOneProvider._internal(
        (ref) => create(ref as PersonRepositoryGetOneRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Person?> createElement() {
    return _PersonRepositoryGetOneProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PersonRepositoryGetOneProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PersonRepositoryGetOneRef on AutoDisposeFutureProviderRef<Person?> {
  /// The parameter `id` of this provider.
  int get id;
}

class _PersonRepositoryGetOneProviderElement
    extends AutoDisposeFutureProviderElement<Person?>
    with PersonRepositoryGetOneRef {
  _PersonRepositoryGetOneProviderElement(super.provider);

  @override
  int get id => (origin as PersonRepositoryGetOneProvider).id;
}

String _$personRepositoryGetAllHash() =>
    r'fa1c65ecf10f85b10dece55735c341510b687fc9';

/// See also [personRepositoryGetAll].
@ProviderFor(personRepositoryGetAll)
final personRepositoryGetAllProvider =
    AutoDisposeFutureProvider<List<Person>>.internal(
  personRepositoryGetAll,
  name: r'personRepositoryGetAllProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$personRepositoryGetAllHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PersonRepositoryGetAllRef = AutoDisposeFutureProviderRef<List<Person>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
