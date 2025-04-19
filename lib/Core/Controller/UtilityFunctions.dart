import 'package:intl/intl.dart';

import '../Model/Classes/Client.dart';
import '../Model/Classes/ClientConstantInfo.dart';

int getWeekOfMonth(DateTime date) {
  final firstDayOfMonth = DateTime(date.year, date.month, 1);
  final daysSinceFirst = date.day + firstDayOfMonth.weekday - 1;
  return (daysSinceFirst / 7).ceil().clamp(1, 4);
}

String getDateText(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}

bool isNumOnly(String? value) {
  if (value == null || value.isEmpty || value == '') return true;
  return double.tryParse(value) != null;
}

SubscriptionType? getSubscriptionTypeFromString(String value) {
  switch (value) {
    case 'none':
      return SubscriptionType.none;
    case 'newClient':
      return SubscriptionType.newClient;
    case 'حالة جديدة':
      return SubscriptionType.newClient;
    case 'singleVisit':
      return SubscriptionType.singleVisit;
    case 'متابعة منفردة':
      return SubscriptionType.singleVisit;
    case 'weeklyVisit':
      return SubscriptionType.weeklyVisit;
    case 'متابعة أسبوعية':
      return SubscriptionType.weeklyVisit;
    case 'monthlyVisit':
      return SubscriptionType.monthlyVisit;
    case 'متابعة شهرية':
      return SubscriptionType.monthlyVisit;
    case 'afterBreak':
      return SubscriptionType.afterBreak;
    case 'بعد انقطاع':
      return SubscriptionType.afterBreak;
    case 'cavSess':
      return SubscriptionType.cavSess;
    case 'جلسة cav':
      return SubscriptionType.cavSess;
    case 'cavSess6':
      return SubscriptionType.cavSess6;
    case 'جلسة cav 6':
      return SubscriptionType.cavSess6;
    case 'miso':
      return SubscriptionType.miso;
    case 'ميسو':
      return SubscriptionType.miso;
    case 'punctureSess':
      return SubscriptionType.punctureSess;
    case 'جلسة إبر':
      return SubscriptionType.punctureSess;
    case 'punctureSess6':
      return SubscriptionType.punctureSess6;
    case 'جلسة إبر 6':
      return SubscriptionType.punctureSess6;
    case 'other':
      return SubscriptionType.other;
    case 'أخرى':
      return SubscriptionType.other;
    default:
      return null;
  }
}

Gender getGenderFromString(String value) {
  switch (value) {
    case 'male':
      return Gender.male;
    case 'female':
      return Gender.female;
    case 'ذكر':
      return Gender.male;
    case 'أنثي':
      return Gender.female;
    case 'none':
      return Gender.none;
    default:
      return Gender.none;
  }
}

Activity getActivityLevelFromString(String value) {
  // switch (value) {
  //   case 'sedentary':
  //     return Activity.sedentary;
  //   case 'mid':
  //     return Activity.mid;
  //   case 'high':
  //     return Activity.high;
  //   case 'none':
  //     return Activity.none;
  //   default:
  //     return Activity.none;
  // }
  // create a map to get the first instance of enum that has same name as given value
  //Gender.values.firstWhere(
  //         (e) => e.name == data['Gender'],
  //         orElse: () => Gender.none,
  return Activity.values.firstWhere(
    //todo: verify functionality
        (e) => e.name == value,
    orElse: () => Activity.none,
  );
}

String getGenderLabel(Gender g) {
  switch (g) {
    case Gender.male:
      return 'ذكر';
    case Gender.female:
      return 'أنثي';
    case Gender.none:
      return '';
    }
}

String getActivityLevelLabel(Activity a) {
  switch (a) {
    case Activity.sedentary:
      return 'ضعيف';
    case Activity.mid:
      return 'متوسط';
    case Activity.high:
      return 'عالي';
    case Activity.none:
      return '';
    }
}
