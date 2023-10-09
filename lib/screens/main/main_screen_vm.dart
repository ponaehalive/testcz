import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testovoecz/base/base_vm.dart';
import 'package:testovoecz/domain/bloc/repo_event.dart';
import 'package:testovoecz/domain/models/repo_model.dart';

import '../../domain/bloc/repo_bloc.dart';

class MainScreenViewModel extends ChangeNotifier with BaseViewModel {
  final _repoBloc = GetIt.instance<RepoBloc>();
  SharedPreferences? _prefs;
  List<String>? favoriteRepoNames = [];

  List<String>? history = [];

  StreamSubscription? _repoBlocSubscription;

  MainScreenViewModel() {
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

  Future<void> toggleFavorite(RepoModel repo) async {
    repo.isFavorite = !repo.isFavorite;
    print(repo.isFavorite);

    await _saveFavorites();

    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final favoriteRepos = allRepo.where((repo) => repo.isFavorite).toList();

    favoriteRepoNames = favoriteRepos.map((repo) => repo.repoName!).toList();

    await _prefs?.setStringList('favoriteRepos', favoriteRepoNames!);

    await _prefs?.setStringList('history', favoriteRepoNames!);
  }

  void init() async {
    await _initPrefs();

    await _loadFavorites();
    await _loadHistory();
  }

  Future<void> _loadHistory() async {
    history = _prefs?.getStringList('history');
    Future.delayed(const Duration(milliseconds: 3000), () async {});
  }

  Future<void> _loadFavorites() async {
    favoriteRepoNames = _prefs?.getStringList('favoriteRepos');

    Future.delayed(const Duration(milliseconds: 3000), () async {
      if (favoriteRepoNames != null) {
        for (var repo in allRepo) {
          if (favoriteRepoNames!.contains(repo.repoName)) {
            repo.isFavorite = true;

            notifyListeners();
          } else {
            repo.isFavorite = false;
            notifyListeners();
          }
        }
      }
    });

    notifyListeners();
  }

  List<RepoModel> get allRepo => _repoBloc.state.loadedRepo ?? [];

  bool get isRepoLoading => _repoBloc.state.isLoadind ?? false;

  final TextEditingController searchController = TextEditingController();
  List<dynamic> searchResults = [];

  void searchRepositories(String name) async {
    if (searchController.text.length > 3) {
      _repoBloc.add(
        RepoLoadEvent(name: name),
      );
    }
  }

  void clearRepositories() async {
    _repoBloc.add(
      RepoClearEvent(),
    );
  }
}
