import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testovoecz/domain/bloc/repo_event.dart';
import 'package:testovoecz/domain/bloc/repo_repository.dart';
import 'package:testovoecz/domain/bloc/repo_state.dart';
import 'package:testovoecz/domain/models/repo_model.dart';

class RepoBloc extends Bloc<RepoEvent, RepoState> {
  final RepoRepository repoRepository = RepoRepository();

  RepoBloc() : super(RepoState.initial) {
    on<RepoLoadEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            isLoadind: true,
          ),
        );

        final List<RepoModel> loadedRepo =
            await repoRepository.getAllRepo(event.name);

        emit(
          state.copyWith(
            loadedRepo: loadedRepo,
            isLoadind: false,
          ),
        );
      },
    );
    on<RepoClearEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            isLoadind: true,
          ),
        );

        emit(
          state.copyWith(
            loadedRepo: [],
            isLoadind: false,
          ),
        );
      },
    );
  }
}
