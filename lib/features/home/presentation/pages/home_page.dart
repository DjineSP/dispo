import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/app_settings_provider.dart';
import '../../../../l10n/gen/app_localizations.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Écouter les paramètres (langue, thème)
    final settings = ref.watch(appSettingsProvider);
    final notifier = ref.read(appSettingsProvider.notifier);

    // Accéder aux traductions
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.app_name ?? "Dispo"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Paramètres (Langue & Thème)
            Card(
              elevation: 0,
              color: theme.colorScheme.surface,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: theme.dividerTheme.color ?? Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Paramètres de langue',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(value: 'fr', label: Text('Français')),
                        ButtonSegment(value: 'en', label: Text('English')),
                      ],
                      selected: {settings.locale.languageCode},
                      onSelectionChanged: (Set<String> newSelection) {
                        notifier.updateLocale(Locale(newSelection.first));
                      },
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),
                    Text(
                      'Paramètres du thème',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    SegmentedButton<ThemeMode>(
                      segments: const [
                        ButtonSegment(value: ThemeMode.system, label: Text('Système')),
                        ButtonSegment(value: ThemeMode.light, label: Text('Clair')),
                        ButtonSegment(value: ThemeMode.dark, label: Text('Sombre')),
                      ],
                      selected: {settings.themeMode},
                      onSelectionChanged: (Set<ThemeMode> newSelection) {
                        notifier.updateTheme(newSelection.first);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Section Typography
            Text(
              'Typographie & Couleurs',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border.all(color: theme.dividerTheme.color ?? Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Display Large', style: theme.textTheme.displayLarge),
                  const SizedBox(height: 8),
                  Text('Title Large', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text('Body Large - Style principal pour paragraphes', style: theme.textTheme.bodyLarge),
                  const SizedBox(height: 8),
                  Text('Body Medium - Style pour texte secondaire', style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  Text('Label - Muted text', style: theme.textTheme.labelLarge),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section Composants (Boutons, etc...)
            Text(
              'Composants UI',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Bouton appuyé!')),
                );
              },
              child: const Text('Bouton Principal (Elevated)'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Bouton Secondaire (Outlined)'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              child: const Text('Lien texte (TextButton)'),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            
            // Colors Display
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _ColorBox(color: theme.colorScheme.primary, label: 'Primary'),
                _ColorBox(color: theme.colorScheme.secondary, label: 'Secondary'),
                _ColorBox(color: theme.colorScheme.error, label: 'Error'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ColorBox extends StatelessWidget {
  final Color color;
  final String label;

  const _ColorBox({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
