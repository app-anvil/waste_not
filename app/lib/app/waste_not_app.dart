import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../router/router.dart';
import '../theme/theme.dart';

class WasteNotApp extends StatelessWidget {
  const WasteNotApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        theme: getTheme(ThemeMode.dark),
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
