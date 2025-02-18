import '../../Core/Model/Classes/Client.dart';

String getSubscriptionTypeLabel(SubscriptionType type) {
  switch (type) {
    case SubscriptionType.none:
      return '';
    case SubscriptionType.newClient:
      return 'حالة جديدة';
    case SubscriptionType.singleVisit:
      return 'متابعة منفردة';
    case SubscriptionType.weeklyVisit:
      return 'متابعة أسبوعية';
    case SubscriptionType.monthlyVisit:
      return 'متابعة شهرية';
    case SubscriptionType.afterBreak:
      return 'بعد انقطاع';
    case SubscriptionType.cavSess:
      return 'Cav جلسة';
    case SubscriptionType.cavSess6:
      return 'Cav جلسات 6';
    case SubscriptionType.miso:
      return 'ميزو';
    case SubscriptionType.punctureSess:
      return 'جلسة إبر';
    case SubscriptionType.punctureSess6:
      return 'جلسات إبر 6';
    case SubscriptionType.other:
      return 'أخرى';
    default:
      return '';
  }
}
