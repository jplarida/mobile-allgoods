import 'package:flutter/material.dart';
import 'package:multi_tenant_app/services/main_api_service.dart';
import 'package:multi_tenant_app/services/db_service.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Map<String, dynamic>> _tenants = [];

  @override
  void initState() {
    super.initState();
    _loadTenants();
  }

  Future<void> _loadTenants() async {
    final dbService = DbService();
    final tenants = await dbService.getTenants();

    if (tenants.isEmpty) {
      // Fetch from API if no tenants are found locally
      await ApiService().fetchAndStoreTenants();
      final updatedTenants = await dbService.getTenants();
      setState(() {
        _tenants = updatedTenants;
      });
    } else {
      setState(() {
        _tenants = tenants;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadTenants,
          ),
        ],
      ),
      body: _tenants.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _tenants.length,
              itemBuilder: (context, index) {
                final tenant = _tenants[index];
                return ListTile(
                  title: Text(tenant['name']),
                  subtitle: Text(tenant['description']),
                  trailing: Text(tenant['type']),
                  onTap: () {
                    // Placeholder for tenant details
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Selected: ${tenant['name']}')),
                    );
                  },
                );
              },
            ),
    );
  }
}
