import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_content_page.dart';
import '../../../wallet/presentation/pages/wallet_page.dart';
import '../../../stats/presentation/pages/stats_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../widgets/bottom_nav_bar.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeContentPage(),
    WalletPage(),
    StatsPage(),
    SettingsPage(),
  ];

  final List<String> _titles = [
    "Accueil",
    "Portefeuille",
    "Statistiques",
    "Paramètres",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo_padded.png', width: 40, height: 40),
        ),
        title: Text(
          _titles[_currentIndex],
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Action Notifications
            },
          )
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
