// ignore_for_file: inference_failure_on_instance_creation

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension OnNavigatorState on NavigatorState {
  // ignore: strict_raw_type
  Future pushLoading<B extends BlocBase<S>, S>({
    required B bloc,
    required void Function(BuildContext context, S state) listener,
    required VoidCallback trigger,
    bool Function(S previous, S current)? listenWhen,
  }) async {
    final route = PageRouteBuilder(
      pageBuilder: (_, __, ___) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            body: BlocListener<B, S>(
              bloc: bloc,
              listenWhen: listenWhen,
              listener: listener,
              child: const Center(
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(strokeWidth: 5),
                ),
              ),
            ),
          ),
        );
      },
      barrierColor: Colors.black45,
      fullscreenDialog: true,
      opaque: false,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );

    final future = push(route);

    // Wait 100ms to add the event to be sure that the route has been already
    // pushed successfully before.
    await Future.delayed(const Duration(milliseconds: 100), trigger);
    return future;

  }

  /// [B] and [S] are generic type related to the bloc who executes the
  /// trigger. e.g. auth bloc with login, sign-up, logout funtion.
  /// While [M] ans [MS] are generic type related to the main bloc, such
  /// as app bar, ecc. this bloc depends on the B bloc state, but is updated
  /// after the B bloc.
  Future<dynamic>
      pushAuthLoading<M extends BlocBase<MS>, MS, B extends BlocBase<S>, S>({
    required B innerbloc,
    required void Function(BuildContext context, S state) innerListener,
    required M bloc,
    required void Function(BuildContext context, MS state) listener,
    required VoidCallback trigger,
  }) async {
    final route = PageRouteBuilder(
      barrierColor: Colors.black45,
      fullscreenDialog: true,
      opaque: false,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      pageBuilder: (_, __, ___) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            body: BlocListener<M, MS>(
              listener: listener,
              bloc: bloc,
              child: BlocListener<B, S>(
                bloc: innerbloc,
                listener: innerListener,
                child: const Center(
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: CircularProgressIndicator(strokeWidth: 5),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    trigger();
    return push(route);
  }
}
