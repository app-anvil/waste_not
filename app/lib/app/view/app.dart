import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../../routes/routes.dart';
import '../../theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const isDark = true;
    return MaterialApp.router(
      theme: getTheme(
        isDark ? ThemeMode.dark : ThemeMode.light,
      ),
      //theme: AppTheme.dark().themeData,
      // theme: ThemeData(
      //   appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
      //   colorScheme: ColorScheme.fromSwatch(
      //     accentColor: const Color(0xFF13B9FF),
      //   ),
      // ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
