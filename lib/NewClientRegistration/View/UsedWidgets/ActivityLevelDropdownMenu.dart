import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientConstantInfo.dart';

import '../../Controller/UtilityFunctions.dart';

class ActivityLevelDropdownMenu extends StatefulWidget {
  final TextEditingController activityLevelController;
  const ActivityLevelDropdownMenu(
      {super.key, required this.activityLevelController});

  @override
  State<ActivityLevelDropdownMenu> createState() =>
      _ActivityLevelDropdownMenuState();
}

class _ActivityLevelDropdownMenuState extends State<ActivityLevelDropdownMenu> {
  Activity? _selectedActivity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: DropdownButton<Activity>(
        value: _selectedActivity,
        onChanged: (Activity? newValue) {
          setState(() {
            _selectedActivity = newValue;
            widget.activityLevelController.text = newValue?.name ?? '';
          });
        },
        items: Activity.values.map((Activity activity) {
          return DropdownMenuItem<Activity>(
            value: activity,
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(getActivityLevelLabel(activity),
                    textAlign: TextAlign.start)),
          );
        }).toList(),
        hint: const Text('طبيعة الحركة و العمل', textAlign: TextAlign.start),
      ),
    );
  }
}
