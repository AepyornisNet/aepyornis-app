import 'package:result_dart/result_dart.dart';
import 'package:aepyornis_app/data/repositories/notification/notification_repository.dart';
import 'package:aepyornis_app/data/services/api/api_client.dart';
import 'package:aepyornis_app/domain/models/notification/app_notification.dart';

class NotificationRepositoryRemote implements NotificationRepository {
  NotificationRepositoryRemote({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<Result<List<AppNotification>>> getNotifications() {
    return _apiClient.getNotifications();
  }

  @override
  Future<Result<void>> markAsRead({List<int>? ids}) {
    return _apiClient.markNotificationsAsRead(ids);
  }
}
