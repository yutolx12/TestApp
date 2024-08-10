import 'package:http/http.dart' as http;

class UserRepository {
  final String baseUrl = 'https://reqres.in/api';

  Future<http.Response> fetchUsers(
      {required int page, int perPage = 10}) async {
    final url = Uri.parse('$baseUrl/users?page=$page&per_page=$perPage');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load users');
    }
  }
}
