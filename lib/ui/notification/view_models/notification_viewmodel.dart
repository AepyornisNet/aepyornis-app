import 'package:flutter/foundation.dart';
import 'package:aepyornis_app/data/repositories/notification/notification_repository.dart';
import 'package:aepyornis_app/domain/models/notification/app_notification.dart';

class NotificationViewModel extends ChangeNotifier {
  NotificationViewModel({
    required NotificationRepository notificationRepository,
  }) : _notificationRepository = notificationRepository {
    loadNotifications();
  }

  final NotificationRepository _notificationRepository;

  List<AppNotification> _notifications = [];
  List<AppNotification> get notifications => _notifications;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadNotifications() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _notificationRepository.getNotifications();
    result.fold(
      (list) {
        _notifications = list;
        _isLoading = false;
        notifyListeners();
      },
      (error) {
        _errorMessage = error.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> markAllAsRead() async {
    final result = await _notificationRepository.markAsRead();
    result.fold(
      (_) {
        _notifications = [];
        notifyListeners();
      },
      (error) {
        _errorMessage = error.toString();
        notifyListeners();
      },
    );
  }

  Future<void> markAsRead(AppNotification notification) async {
    final result =
        await _notificationRepository.markAsRead(ids: [notification.id]);
    result.fold(
      (_) {
        _notifications =
            _notifications.where((n) => n.id != notification.id).toList();
        notifyListeners();
      },
      (error) {},
    );
  }
}
