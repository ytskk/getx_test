import 'package:flutter/material.dart';
import 'package:getx_test/core/navigation/app_route_names.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.pushNamed(AppRouteNames.settings.name),
          ),
        ],
        title: const Text('Home'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('Appearance'),
          onPressed: () => context.pushNamed(AppRouteNames.appearance.name),
        ),
      ),
    );
  }
}
