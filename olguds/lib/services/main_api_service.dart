import 'dart:convert';
import 'package:http/http.dart' as http;
import 'db_service.dart';

class ApiService {
  static const String _baseUrl = 'https://example.com/api'; // Replace with your API URL

  Future<void> fetchAndStoreTenants() async {
    final url = Uri.parse('$_baseUrl/tenants');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> tenantList = jsonDecode(response.body);

        // Store tenants in the local database
        final dbService = DbService();
        for (var tenant in tenantList) {
          await dbService.addTenant(
            tenant['name'],
            tenant['description'] ?? '',
            tenant['type'],
          );
        }
      } else {
        throw Exception('Failed to fetch tenants: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching tenants: $e');
    }
  }
}
