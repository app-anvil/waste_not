import 'package:flutter/material.dart';

class PantryPage extends StatelessWidget {
  const PantryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PantryView();
  }
}

class PantryView extends StatelessWidget {
  const PantryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // FIXME: [text]
        title: const Text('Pantry'),
      ),
      body: const Placeholder(),
    );
  }
}
