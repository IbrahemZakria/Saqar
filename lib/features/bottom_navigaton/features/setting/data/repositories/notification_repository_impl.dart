import 'package:atrega/core/helper/functions/notification_services.dart';
import 'package:atrega/features/bottom_navigaton/features/setting/domain/repositories/notification_repository.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  @override
  void azkarNotification({required bool isActive}) {
    // TODO: implement azkarNotification
    List<String> azkarList = [
      "سُبْحَانَ اللهِ",
      "الْحَمْدُ لِلَّهِ",
      "اللَّهُ أَكْبَرُ",
      "لَا إِلَهَ إِلَّا اللهُ",
      "سُبْحَانَ اللهِ وَبِحَمْدِهِ",
      "سُبْحَانَ اللَّهِ الْعَظِيمِ",
      "لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ",
      "سُبْحَانَ رَبِّيَ الْأَعْلَى",
      "سُبْحَانَ رَبِّيَ الْعَظِيمِ",
      "اللَّهُ أَكْبَرُ كَبِيرًا",
      "الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ",
      "سُبْحَانَ اللَّهِ وَالْحَمْدُ لِلَّهِ وَاللَّهُ أَكْبَرُ",
      "رَبِّ لَا إِلٰهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي كُنْتُ مِنَ الظَّالِمِينَ",
      "رَبِّ إِنِّي مَسَّنِيَ الضُّرُّ وَأَنْتَ أَرْحَمُ الرَّاحِمِينَ",
      "اللَّهُمَّ آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ",
      "سُبْحَانَ اللهِ وَبِحَمْدِهِ، سُبْحَانَ رَبِّيَ الْعَظِيمِ",
      "اللَّهُمَّ اهْدِنَا لِلصِّرَاطِ الْمُسْتَقِيمِ",
    ];
  }

  @override
  void eveningAzkarNotification({
    required bool isActive,
    required Duration time,
  }) {
    // TODO: implement eveningAzkarNotification
    if (isActive) {
      NotificationServices().scheduleDailyNotification(
        id: 2,
        title: "أذكار الصباح",
        body: "أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ",
        hour: time.inHours,
        minute: time.inMinutes,
        payload: "أذكار الصباح",
      );
    }
    NotificationServices().cancelNotification(id: 2);
  }

  @override
  void morningAzkarNotification({
    required bool isActive,
    required Duration time,
  }) {
    // TODO: implement morningAzkarNotification
    if (isActive) {
      NotificationServices().scheduleDailyNotification(
        id: 3,
        title: "أذكار المساء",
        body: "أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ",
        hour: time.inHours,
        minute: time.inMinutes,
        payload: "أذكار المساء",
      );
    } else {
      NotificationServices().cancelNotification(id: 3);
    }
  }

  @override
  void prayNotification({required bool isActive}) {
    // TODO: implement prayNotification
  }
}
