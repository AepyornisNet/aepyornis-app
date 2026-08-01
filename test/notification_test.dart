import 'package:flutter_test/flutter_test.dart';
import 'package:result_dart/result_dart.dart';
import 'package:aepyornis_app/data/repositories/notification/notification_repository.dart';
import 'package:aepyornis_app/domain/models/notification/app_notification.dart';
import 'package:aepyornis_app/ui/notification/view_models/notification_viewmodel.dart';

class MockNotificationRepository implements NotificationRepository {
  final List<AppNotification> items = [
    const AppNotification(
      id: 1,
      type: 'workout_like',
      subject: 'New Like',
      msg: 'User liked your workout',
    ),
    const AppNotification(
      id: 2,
      type: 'workout_reply',
      subject: 'New Comment',
      msg: 'Great job!',
    ),
  ];

  @override
  Future<Result<List<AppNotification>>> getNotifications() async {
    return Success(List.from(items));
  }

  @override
  Future<Result<void>> markAsRead({List<int>? ids}) async {
    if (ids == null || ids.isEmpty) {
      items.clear();
    } else {
      items.removeWhere((item) => ids.contains(item.id));
    }
    return Success(0);
  }
}

void main() {
  group('NotificationViewModel Tests', () {
    late MockNotificationRepository repository;
    late NotificationViewModel viewModel;

    setUp(() {
      repository = MockNotificationRepository();
      viewModel = NotificationViewModel(notificationRepository: repository);
    });

    test('loads notifications initially', () async {
      await viewModel.loadNotifications();
      expect(viewModel.notifications.length, 2);
      expect(viewModel.notifications.first.subject, 'New Like');
    });

    test('marks individual notification as read', () async {
      await viewModel.loadNotifications();
      final target = viewModel.notifications.first;
      await viewModel.markAsRead(target);
      expect(viewModel.notifications.length, 1);
      expect(viewModel.notifications.first.id, 2);
    });

    test('marks all notifications as read', () async {
      await viewModel.loadNotifications();
      await viewModel.markAllAsRead();
      expect(viewModel.notifications, isEmpty);
    });
  });
}
