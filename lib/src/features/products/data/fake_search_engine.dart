import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization_ecommerce/src/utils/in_memory_store.dart';

class FakeSearchEngine {
  final _searchState = InMemoryStore<String?>('');
  Stream<String?> authStateChanges() => _searchState.stream;
  String? get queryHistory => _searchState.value;
  Stream<String?> get currentQuery => _searchState.stream;

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

final searchEngineProvider = Provider<FakeSearchEngine>((ref) {
  final search = FakeSearchEngine();
  ref.onDispose(() => search.dispose());
  return search;
});

final searchStateChangeProvider = StreamProvider.autoDispose<String?>((ref) {
  final searchEngine = ref.watch(searchEngineProvider);
  return searchEngine.authStateChanges();
});
