import 'package:result_dart/result_dart.dart';
import 'package:aepyornis_app/domain/models/notification/app_notification.dart';

abstract class NotificationRepository {
  Future<Result<List<AppNotification>>> getNotifications();
  Future<Result<void>> markAsRead({List<int>? ids});
}
