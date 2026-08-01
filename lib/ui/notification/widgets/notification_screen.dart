import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:aepyornis_app/domain/models/notification/app_notification.dart';
import 'package:aepyornis_app/l10n/app_localizations.dart';
import 'package:aepyornis_app/routing/routes.dart';
import 'package:aepyornis_app/ui/notification/view_models/notification_viewmodel.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key, required this.viewModel});

  final NotificationViewModel viewModel;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.notifications ?? 'Notifications'),
        actions: [
          ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, _) {
              if (widget.viewModel.notifications.isEmpty) {
                return const SizedBox.shrink();
              }
              return TextButton.icon(
                onPressed: () => widget.viewModel.markAllAsRead(),
                icon: const Icon(Icons.done_all, size: 18),
                label: Text(l10n?.markAllAsRead ?? 'Mark all as read'),
              );
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          final vm = widget.viewModel;

          if (vm.isLoading && vm.notifications.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.notifications.isEmpty) {
            return RefreshIndicator(
              onRefresh: vm.loadNotifications,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_none,
                              size: 64,
                              color: colorScheme.onSurfaceVariant
                                  .withValues(alpha: 0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              l10n?.noNotifications ?? 'No notifications',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l10n?.noNotificationsDescription ??
                                  "You're all caught up!",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant
                                    .withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: vm.loadNotifications,
            child: ListView.separated(
              itemCount: vm.notifications.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = vm.notifications[index];
                return _NotificationTile(
                  notification: item,
                  onTap: () {
                    vm.markAsRead(item);
                    _handleNotificationNavigation(context, item);
                  },
                  onDismiss: () => vm.markAsRead(item),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _handleNotificationNavigation(
      BuildContext context, AppNotification item) {
    if (item.meta != null) {
      final workoutId = item.meta!['workout_id'] ?? item.meta!['workoutId'];
      if (workoutId != null) {
        final id = int.tryParse(workoutId.toString());
        if (id != null) {
          context.push(Routes.workoutWithId(id));
        }
      }
    }
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.notification,
    required this.onTap,
    required this.onDismiss,
  });

  final AppNotification notification;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  IconData _getIcon() {
    switch (notification.type) {
      case 'workout_like':
        return Icons.favorite;
      case 'workout_reply':
        return Icons.chat_bubble;
      case 'follow_request':
        return Icons.person_add;
      default:
        return Icons.notifications;
    }
  }

  Color _getIconColor(ColorScheme colorScheme) {
    switch (notification.type) {
      case 'workout_like':
        return Colors.red;
      case 'workout_reply':
        return colorScheme.primary;
      case 'follow_request':
        return Colors.green;
      default:
        return colorScheme.secondary;
    }
  }

  String _formatTime(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final dt = DateTime.parse(dateStr).toLocal();
      final now = DateTime.now();
      final diff = now.difference(dt);

      if (diff.inMinutes < 1) {
        return 'Just now';
      } else if (diff.inHours < 1) {
        return '${diff.inMinutes}m ago';
      } else if (diff.inHours < 24) {
        return '${diff.inHours}h ago';
      } else {
        return DateFormat.MMMd().format(dt);
      }
    } catch (_) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dismissible(
      key: Key('notification_${notification.id}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16.0),
        color: colorScheme.errorContainer,
        child: Icon(Icons.done, color: colorScheme.onErrorContainer),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: CircleAvatar(
          backgroundColor: _getIconColor(colorScheme).withValues(alpha: 0.15),
          child: Icon(_getIcon(), color: _getIconColor(colorScheme), size: 20),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                notification.subject ?? 'Notification',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (notification.createdAt != null)
              Text(
                _formatTime(notification.createdAt),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
        subtitle: notification.msg != null
            ? Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  notification.msg!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
