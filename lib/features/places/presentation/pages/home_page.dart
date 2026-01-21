import 'package:flutter/material.dart';
import '../../../../app_home_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // This just wraps the AppHomePage which has the bottom navigation
    return const AppHomePage();
  }
}