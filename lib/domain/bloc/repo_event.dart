abstract class RepoEvent {}

class RepoLoadEvent extends RepoEvent {
  final String name;
  RepoLoadEvent({
    required this.name,
  });
}

class RepoClearEvent extends RepoEvent {}
