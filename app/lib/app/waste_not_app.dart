import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../boot/initialize_dependencies.dart';
import '../features/notifications/cubit/notification_payload_cubit.dart';
import '../l10n/l10n.dart';
import '../models/models.dart';
import '../router/router.dart';
import '../theme/theme.dart';

class WasteNotApp extends StatelessWidget {
  const WasteNotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationPayloadCubit(
        GetIt.I.get(instanceName: 'NotificationMessageHandler'),
      ),
      child: const WasteNotAppView(),
    );
  }
}

class WasteNotAppView extends StatelessWidget {
  const WasteNotAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationPayloadCubit, NotificationPayloadState>(
      listenWhen: (previous, current) => current.payload != null,
      listener: (context, state) {
        state.payload!.handle(context);
        GetIt.I
            .get<StreamControllerHandler<Map<String, dynamic>>>(
              instanceName: $notificationMessageHandlerInstanceName,
            )
            .add(null);
      },
      child: MaterialApp.router(
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
        routeInformationParser: $router.routeInformationParser,
        routerDelegate: $router.routerDelegate,
        routeInformationProvider: $router.routeInformationProvider,
      ),
    );
  }
}
