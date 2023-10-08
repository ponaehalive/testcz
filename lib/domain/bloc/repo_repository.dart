// ignore_for_file: avoid_print

import 'package:testovoecz/domain/bloc/provider.dart';
import 'package:testovoecz/domain/models/repo_model.dart';

class RepoRepository {
  final Provider _provider = Provider();

  Future<List<RepoModel>> getAllRepo(String name) =>
      _provider.getRepoHttp(name);
}
