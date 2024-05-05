import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../l10n/l10n.dart';
import '../../../permissions/permissions.dart';

class AccountAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AccountAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.large(
      title: Text(
        context.l10n.accountAppBarTitle,
        style: const TextStyle().copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AccountView();
  }
}

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  Future<void> _showFakeNotification(BuildContext context) async {
    final notifService = GetIt.I.get<NotificationService>();
    final result = await A2FPermissions.notifications.request();
    if (result) {
      final notification = ReceivedNotification.fromLocal(
        title: 'Fake notification',
        payload: {
          'route': 'account',
        },
      );
      await notifService.showNotification(notification);
    }
  }

  Future<void> _scheduleFakeNotification(BuildContext context) async {
    final notifService = GetIt.I.get<NotificationService>();
    final result = await A2FPermissions.notifications.request();
    if (result) {
      final notification = ReceivedNotification.fromLocal(
        title: 'Scheduled notification',
        payload: {
          'route': 'account',
        },
      );
      await notifService.scheduleNotification(
        notification,
        scheduleAt: DateTime.now().add(const Duration(seconds: 15)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          title: Text(
            context.l10n.accountAppBarTitle,
            style: const TextStyle().copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => _showFakeNotification(context),
          child: const Text('Send notification'),
        ).asSliver,
        ElevatedButton(
          onPressed: () => _scheduleFakeNotification(context),
          child: const Text('Schedule notification'),
        ).asSliver,
        const Placeholder().asSliver,
      ],
    );
  }
}
