import 'dart:convert';
import 'package:testovoecz/domain/models/repo_model.dart';
import 'package:http/http.dart' as http;

class Provider {
  Future<List<RepoModel>> getRepoHttp(String name) async {
    final response = await http.get(
      Uri.parse(
        'https://api.github.com/search/repositories?q=$name&per_page=15',
      ),
    );

    if (response.statusCode == 200) {
      print(response.statusCode);

      final Map<String, dynamic> responseBody = json.decode(response.body);
      final List<dynamic> repoJson = responseBody['items'];

      return repoJson.map((json) => RepoModel.fromJson(json)).toList();
    } else {
      throw Exception('Error');
    }
  }
}
