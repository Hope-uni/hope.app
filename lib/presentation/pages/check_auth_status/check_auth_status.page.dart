import 'package:flutter/material.dart';

class CheckAuthStatusPage extends StatelessWidget {
  const CheckAuthStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 4,
        ),
      ),
    );
  }
}
