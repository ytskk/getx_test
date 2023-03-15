import 'package:flutter/material.dart';
import 'package:getx_test/core/navigation/app_route_names.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar.large(
            title: const Text('Settings'),
          ),
        ],
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('Appearance'),
              onTap: () => context.pushNamed(AppRouteNames.appearance.name),
            ),
          ],
        ),
      ),
    );
  }
}
