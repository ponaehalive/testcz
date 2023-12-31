import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testovoecz/base/base_vm.dart';
import 'package:testovoecz/domain/bloc/repo_event.dart';
import 'package:testovoecz/domain/models/repo_model.dart';

import '../../domain/bloc/repo_bloc.dart';

class FavoritesScreenViewModel extends ChangeNotifier with BaseViewModel {
  final _repoBloc = GetIt.instance<RepoBloc>();
  SharedPreferences? _prefs;
  List<String>? favoriteRepoNames = [];

  StreamSubscription? _repoBlocSubscription;

  FavoritesScreenViewModel() {
    _repoBlocSubscription = _repoBloc.stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    super.dispose();
    _repoBlocSubscription?.cancel();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> removeFavorite(String favoriteItem) async {
    favoriteRepoNames?.remove(favoriteItem);

    await _saveFavorites();

    notifyListeners();
  }

  void clearRepositories() async {
    _repoBloc.add(
      RepoClearEvent(),
    );
  }

  Future<void> _saveFavorites() async {
    await _prefs?.setStringList('favoriteRepos', favoriteRepoNames!);
  }

  void init() async {
    await _initPrefs();
    // ignore: avoid_print
    await _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    favoriteRepoNames = _prefs?.getStringList('favoriteRepos');

    notifyListeners();
  }

  List<RepoModel> get allRepo => _repoBloc.state.loadedRepo ?? [];

  bool get isRepoLoading => _repoBloc.state.isLoadind ?? false;

  final TextEditingController searchController = TextEditingController();
  List<dynamic> searchResults = [];
}
