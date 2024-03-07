import 'package:flutter/material.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class SettingsPersonPage extends StatelessWidget {
  const SettingsPersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuraciones personales'),
      ),
      body: const Text('Configuración'),
      drawer: const SideMenu(),
    );
  }
}
