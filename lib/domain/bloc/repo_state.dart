import 'package:testovoecz/domain/models/repo_model.dart';

class RepoState {
  List<RepoModel>? loadedRepo;
  bool? isLoadind;

  RepoState({
    this.loadedRepo,
    this.isLoadind,
  });

  RepoState copyWith({
    List<RepoModel>? loadedRepo,
    bool? isLoadind,
  }) =>
      RepoState(
        loadedRepo: loadedRepo ?? this.loadedRepo,
        isLoadind: isLoadind ?? this.isLoadind,
      );

  static RepoState get initial {
    return RepoState(
      loadedRepo: [],
      isLoadind: false,
    );
  }
}
