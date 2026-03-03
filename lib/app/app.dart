import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers/app_settings_provider.dart';
import '../l10n/gen/app_localizations.dart';
import 'routing/app_router.dart';
import 'theme/app_theme.dart';

class DispoApp extends ConsumerWidget {
  const DispoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Parameters listeners
    final settings = ref.watch(appSettingsProvider);

    return MaterialApp.router(
      title: 'Dispo',
      debugShowCheckedModeBanner: false,
      
      // Dynamic language management
      locale: settings.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

			// Dynamic theme management
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settings.themeMode,
      
			// Router
      routerConfig: AppRouter.router,
    );
  }
}
