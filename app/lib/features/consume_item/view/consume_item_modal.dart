import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:items_repository/items_repository.dart';

import '../cubit/consume_item_cubit.dart';

class ConsumeItemModal extends StatelessWidget {
  const ConsumeItemModal({super.key});

  Future<void> show(BuildContext context, {required ItemEntity item}) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => BlocProvider(
        create: (context) => ConsumeItemCubit(item, ItemsRepository.I),
        child: this,
      ),
    );
  }

  void _onConsume(BuildContext context) {
    final cubit = context.read<ConsumeItemCubit>();
    context.navRoot.pushBlocListenerBarrier<ConsumeItemCubit, ConsumeItemState>(
      bloc: cubit,
      listener: (ctx, curr) {
        if (curr.status.isSuccess) {
          // Pop the loading screen
          ctx.navRoot.pop();
          // Pop the add/edit screen.
          context.router.pop();
        }
        if (curr.status.isFailure) {
          // Pop the loading screen
          ctx.navRoot.pop();
          GetIt.I.get<MessageHelper>().showMessage(
                context,
                message: curr.errorMessage!,
                type: MessageType.error,
              );
        }
      },
      trigger: cubit.onConsume,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('How many units did you consume?'),
      content: const _Content(),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => _onConsume(context),
          child: const Text('Consume'),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsumeItemCubit, ConsumeItemState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Btn(
              onPressed: state.isDecreaseEnabled
                  ? () {
                      context.read<ConsumeItemCubit>().onDecrease();
                    }
                  : null,
              iconData: Icons.remove_rounded,
              isEnabled: state.isDecreaseEnabled,
            ),
            Text(
              '${state.consumedAmount}',
              style: context.tt.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            _Btn(
              onPressed: state.isIncreaseEnabled
                  ? () {
                      context.read<ConsumeItemCubit>().onIncrease();
                    }
                  : null,
              iconData: Icons.add_rounded,
              isEnabled: state.isIncreaseEnabled,
            ),
          ],
        );
      },
    );
  }
}

class _Btn extends StatelessWidget {
  const _Btn({
    required this.onPressed,
    required this.iconData,
    required this.isEnabled,
  });

  final void Function()? onPressed;
  final IconData iconData;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        padding: EdgeInsets.all(const AppStyle().insets.xxs),
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: isEnabled
                ? context.col.primary
                : context.col.onSurface.withOpacity(0.38),
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          size: 28,
          color: isEnabled
              ? context.col.primary
              : context.col.onSurface.withOpacity(0.38),
        ),
      ),
    );
  }
}
