import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features.dart';

class OpenedItemsPage extends StatelessWidget {
  const OpenedItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<OpenedItemsCubit>(),
      child: const OpenedItemsView(),
    );
  }
}

class OpenedItemsView extends StatelessWidget {
  const OpenedItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
