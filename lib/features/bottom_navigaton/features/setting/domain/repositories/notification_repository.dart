abstract class NotificationRepository {
  void azkarNotification({required bool isActive});
  void morningAzkarNotification({
    required bool isActive,
    required Duration time,
  });
  void eveningAzkarNotification({
    required bool isActive,
    required Duration time,
  });
  void prayNotification({required bool isActive});
}
