import 'package:flutter/material.dart';

class AdminConfirmScreen extends StatefulWidget {
  const AdminConfirmScreen({super.key});

  @override
  State<AdminConfirmScreen> createState() => _AdminConfirmScreenState();
}

class _AdminConfirmScreenState extends State<AdminConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard"), actions: const []),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: []),
      ),
    );
  }
}
