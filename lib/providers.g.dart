// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

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

String $getArticlesHash() => r'1812d3b16b17763112000761baa9b19d3fdab6c8';

/// See also [getArticles].
class GetArticlesProvider
    extends AutoDisposeFutureProvider<List<ArticleModel>> {
  GetArticlesProvider({
    required this.query,
  }) : super(
          (ref) => _getArticles(
            ref,
            query: query,
          ),
          from: getArticlesProvider,
          name: r'getArticlesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $getArticlesHash,
        );

  final String query;

  @override
  bool operator ==(Object other) {
    return other is GetArticlesProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef GetArticlesRef = AutoDisposeFutureProviderRef<List<ArticleModel>>;

/// See also [getArticles].
final getArticlesProvider = GetArticlesFamily();

class GetArticlesFamily extends Family<AsyncValue<List<ArticleModel>>> {
  GetArticlesFamily();

  GetArticlesProvider call({
    required String query,
  }) {
    return GetArticlesProvider(
      query: query,
    );
  }

  @override
  AutoDisposeFutureProvider<List<ArticleModel>> getProviderOverride(
    covariant GetArticlesProvider provider,
  ) {
    return call(
      query: provider.query,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'getArticlesProvider';
}
