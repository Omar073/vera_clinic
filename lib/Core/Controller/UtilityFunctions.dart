import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Model/Classes/Client.dart';
import '../Model/Classes/ClientConstantInfo.dart';
import '../View/PopUps/InvalidDataTypeSnackBar.dart';
import '../View/PopUps/MySnackBar.dart';

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
    case 'biWeeklyVisit':
      return SubscriptionType.biWeeklyVisit;
    case 'متابعة أسبوعين':
      return SubscriptionType.biWeeklyVisit;
    case 'monthlySubscription':
      return SubscriptionType.monthlySubscription;
    case 'اشتراك شهري':
      return SubscriptionType.monthlySubscription;
    case 'afterBreak':
      return SubscriptionType.afterBreak;
    case 'بعد انقطاع':
      return SubscriptionType.afterBreak;
    case 'inBody':
      return SubscriptionType.inBody;
    case 'انبدي':
      return SubscriptionType.inBody;
    case 'cavSess':
      return SubscriptionType.cavSess;
    case 'Cav جلسة':
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
    case 'injection':
      return SubscriptionType.injection;
    case 'حقن':
      return SubscriptionType.injection;
    case 'other':
      return SubscriptionType.other;
    case 'أخرى':
      return SubscriptionType.other;
    default:
      return SubscriptionType.none;
  }
}

String getSubscriptionTypeLabel(SubscriptionType type) {
  switch (type) {
    case SubscriptionType.none:
      return '';
    case SubscriptionType.newClient:
      return 'حالة جديدة';
    case SubscriptionType.singleVisit:
      return 'متابعة منفردة';
    case SubscriptionType.biWeeklyVisit:
      return 'متابعة أسبوعين';
    case SubscriptionType.monthlySubscription:
      return 'اشتراك شهري';
    case SubscriptionType.afterBreak:
      return 'بعد انقطاع';
    case SubscriptionType.inBody:
      return 'انبدي';
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
    case SubscriptionType.injection:
      return 'حقن';
    case SubscriptionType.other:
      return 'أخرى';
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

bool validateYear(BuildContext context, String yearType, String yearValue) {
  yearValue = yearValue.trim();

  // Check if input is numeric and does not contain a decimal point
  if (!isNumOnly(yearValue) ||
      yearValue.contains('.') ||
      !RegExp(r'^\d+$').hasMatch(yearValue)) {
    showInvalidDataTypeSnackBar(context, yearType);
    return false;
  }

  final int? year = int.tryParse(yearValue);

  if (year == null) {
    // Should ideally not be reached if _isNumOnly is robust
    showMySnackBar(context, '$yearType غير صالحة', Colors.red);
    return false;
  }

  final int currentYear = DateTime.now().year;
  if (year < 1900 || year > currentYear) {
    showMySnackBar(
        context, '$yearType يجب أن تكون بين 1900 و $currentYear', Colors.red);
    return false;
  }

  return true;
}
