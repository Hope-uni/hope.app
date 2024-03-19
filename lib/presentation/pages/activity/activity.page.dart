import 'package:flutter/material.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Actividades'),
      ),
      body: const DataTableDynamic(
        data: [],
        headersRows: [],
      ),
      drawer: const SideMenu(),
    );
  }
}
