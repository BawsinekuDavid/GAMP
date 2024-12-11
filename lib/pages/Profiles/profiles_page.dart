import 'package:flutter/material.dart';

import '../../constant.dart';

class ProfilesPage extends StatelessWidget {
  const ProfilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: colors,
      body: const Center(child: Text("PROFILES")),
    );
  }
}