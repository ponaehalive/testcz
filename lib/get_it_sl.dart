import 'package:get_it/get_it.dart';
import 'package:testovoecz/domain/bloc/repo_bloc.dart';

void setupGetIt() {
  GetIt.instance.registerSingleton<RepoBloc>(RepoBloc());
}
