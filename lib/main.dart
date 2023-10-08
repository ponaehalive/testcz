import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testovoecz/get_it_sl.dart';
import 'package:testovoecz/my_app.dart';

void main() async {
  setupGetIt();

  WidgetsFlutterBinding.ensureInitialized();
  await _initPrefs();

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  runApp(
    const MyApp(),
  );
}

Future<void> _initPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Инициализация SharedPreferences для дальнейшего использования
  // Можно также сохранить полученные SharedPreferences в глобальном объекте или GetIt для общего доступа в приложении
}

//
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:testovoecz/my_app.dart';
//
// class FavoritesManager {
//   List<String> _favorites = [];
//
//   List<String> get favorites => _favorites;
//
//   set favorites(List<String> value) {
//     _favorites = value;
//   }
//
//   void addToFavorites(String repositoryFullName) {
//     if (!_favorites.contains(repositoryFullName)) {
//       _favorites.add(repositoryFullName);
//     }
//   }
//
//   void removeFromFavorites(String repositoryFullName) {
//     _favorites.remove(repositoryFullName);
//   }
// }
//
//
//
// class RepositorySearchScreen extends StatefulWidget {
//   @override
//   _RepositorySearchScreenState createState() => _RepositorySearchScreenState();
// }
//
// class _RepositorySearchScreenState extends State<RepositorySearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   List<dynamic> _searchResults = [];
//   late FavoritesManager _favoritesManager;
//
//   @override
//   void initState() {
//     super.initState();
//     _favoritesManager = FavoritesManager();
//
//     _loadFavorites();
//     _searchController.clear();
//   }
//
//   Future<void> _loadFavorites() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? favoritesList = prefs.getStringList('favorites');
//     if (favoritesList != null) {
//       setState(() {
//         _favoritesManager.favorites = favoritesList;
//       });
//     }
//   }
//
//   Future<void> _saveFavorites() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setStringList('favorites', _favoritesManager.favorites);
//   }
//
//   Future<void> _searchRepositories(String query) async {
//     final String apiUrl = 'https://api.github.com/search/repositories?q=$query';
//
//     try {
//       final response = await http.get(Uri.parse(apiUrl));
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         setState(() {
//           _searchResults = data['items'];
//         });
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (error) {
//       print('Error: $error');
//     }
//   }
//
//   void _addToFavorites(String repositoryFullName) {
//     setState(() {
//       _favoritesManager.addToFavorites(repositoryFullName);
//       _saveFavorites();
//     });
//   }
//
//   void _removeFromFavorites(String repositoryFullName) {
//     setState(() {
//       _favoritesManager.removeFromFavorites(repositoryFullName);
//       _saveFavorites();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('GitHub Repository Search'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.favorite),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         FavoritesScreen(favoritesManager: _favoritesManager)),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _searchController,
//               onChanged: (value) {
//                 if (value.length > 2) {
//                   _searchRepositories(value);
//                 }
//               },
//               decoration: InputDecoration(
//                 hintText: 'Enter repository name',
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: () {
//                     String query = _searchController.text;
//                     if (query.isNotEmpty) {
//                       _searchRepositories(query);
//                     }
//                   },
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _searchResults.length,
//               itemBuilder: (context, index) {
//                 final repo = _searchResults[index];
//                 final repositoryFullName = repo['full_name'];
//
//                 bool isFavorite =
//                     _favoritesManager.favorites.contains(repositoryFullName);
//
//                 return ListTile(
//                   title: Text(repositoryFullName),
//                   subtitle: Text(repo['description'] ?? 'No description'),
//                   trailing: IconButton(
//                     icon: Icon(
//                       isFavorite ? Icons.favorite : Icons.favorite_border,
//                       color: isFavorite ? Colors.red : null,
//                     ),
//                     onPressed: () {
//                       if (isFavorite) {
//                         _removeFromFavorites(repositoryFullName);
//                       } else {
//                         _addToFavorites(repositoryFullName);
//                       }
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class FavoritesScreen extends StatefulWidget {
//   final FavoritesManager favoritesManager;
//
//   const FavoritesScreen({required this.favoritesManager});
//
//   @override
//   _FavoritesScreenState createState() => _FavoritesScreenState();
// }
//
// class _FavoritesScreenState extends State<FavoritesScreen> {
//   late FavoritesManager _favoritesManager;
//
//   @override
//   void initState() {
//     super.initState();
//     _favoritesManager = widget.favoritesManager;
//   }
//
//   void _toggleFavorite(String repositoryFullName) {
//     setState(() {
//       if (_favoritesManager.favorites.contains(repositoryFullName)) {
//         _favoritesManager.removeFromFavorites(repositoryFullName);
//       } else {
//         _favoritesManager.addToFavorites(repositoryFullName);
//       }
//       _saveFavorites();
//     });
//   }
//
//   Future<void> _saveFavorites() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setStringList('favorites', _favoritesManager.favorites);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorites'),
//       ),
//       body: ListView.builder(
//         itemCount: _favoritesManager.favorites.length,
//         itemBuilder: (context, index) {
//           final repositoryFullName = _favoritesManager.favorites[index];
//           return ListTile(
//             title: Text(repositoryFullName),
//             trailing: IconButton(
//               icon: Icon(
//                 Icons.favorite,
//                 color: Colors.red,
//               ),
//               onPressed: () {
//                 _toggleFavorite(repositoryFullName);
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
