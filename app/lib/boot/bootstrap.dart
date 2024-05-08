import 'dart:async';

import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_bloc_observer.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    const NthLogger('main').e(
      details.exceptionAsString(),
      details.exception,
      details.stack,
    );
  };

  Bloc.observer = AppBlocObserver();

  // Add cross-flavor configuration here
  runApp(await builder());
}
