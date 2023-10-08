class FavoritesManager {
  List<String> _favorites = [];

  List<String> get favorites => _favorites;

  set favorites(List<String> value) {
    _favorites = value;
  }

  void addToFavorites(String repositoryFullName) {
    if (!_favorites.contains(repositoryFullName)) {
      _favorites.add(repositoryFullName);
    }
  }

  void removeFromFavorites(String repositoryFullName) {
    _favorites.remove(repositoryFullName);
  }
}
