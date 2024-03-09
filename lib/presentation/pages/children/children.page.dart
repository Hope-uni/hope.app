import 'package:flutter/material.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ChildrenPage extends StatelessWidget {
  const ChildrenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Niños asignados'),
      ),
      body: const Text('Niños'),
      drawer: const SideMenu(),
    );
  }
}
