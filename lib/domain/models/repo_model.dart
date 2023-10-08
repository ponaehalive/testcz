class RepoModel {
  String? repoName;
  bool isFavorite = false;

  RepoModel({
    this.repoName,
  });

  RepoModel.fromJson(Map<String, dynamic> json) {
    repoName = json['full_name'];
  }
}
