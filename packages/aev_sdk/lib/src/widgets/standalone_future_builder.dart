import 'package:flutter/material.dart';

class StandaloneFutureBuilder<T> extends StatefulWidget {
  final Future<T> Function() getFuture;
  final Widget Function(BuildContext context, T value) builder;
  final Widget Function(BuildContext context) loadingBuilder;
  final Widget Function(
    BuildContext context,
    Object error,
    Future<dynamic> Function() onReload,
  ) errorBuilder;

  const StandaloneFutureBuilder({
    required this.getFuture,
    required this.builder,
    required this.loadingBuilder,
    required this.errorBuilder,
    super.key,
  });

  @override
  State<StandaloneFutureBuilder<T>> createState() =>
      _StandaloneFutureBuilderState<T>();
}

class _StandaloneFutureBuilderState<T>
    extends State<StandaloneFutureBuilder<T>> {
  late Future<T> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.getFuture();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          // ignore: null_check_on_nullable_type_parameter
          return widget.builder(context, snapshot.data!);
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasError) {
          return widget.errorBuilder(
            context,
            snapshot.error!,
            () {
              setState(() => _future = widget.getFuture());
              return _future;
            },
          );
        } else {
          return widget.loadingBuilder(context);
        }
      },
    );
  }
}
