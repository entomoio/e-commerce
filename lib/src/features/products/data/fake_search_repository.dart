import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization_ecommerce/src/utils/in_memory_store.dart';

class FakeSearchRepository {
  final _searchState = InMemoryStore<String?>('');

  String? get currentQuery => _searchState.value;

  Future<void> createSearch(String query) async {
    // await Future.delayed(const Duration(seconds: 1));
    _createQuery(query);
  }

  Future<void> clearSearch() async {
    // await Future.delayed(const Duration(seconds: 2));
    // throw Exception('Connection failed');
    _searchState.value = null;
  }

  void dispose() => _searchState.close();

  void _createQuery(String query) {
    _searchState.value = query;
  }
}

final searchRepositoryProvider = Provider<FakeSearchRepository>((ref) {
  final search = FakeSearchRepository();
  ref.onDispose(() => search.dispose());
  return search;
});
