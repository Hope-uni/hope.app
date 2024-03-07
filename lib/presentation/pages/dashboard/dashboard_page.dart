import 'package:flutter/material.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('hope - Niños'),
      ),
      drawer: const SideMenu(),
    );
  }
}
