import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientConstantInfo.dart';

import '../../Controller/UtilityFunctions.dart';

class ActivityLevelDropdownMenu extends StatefulWidget {
  final TextEditingController activityLevelController;
  Activity? selectedActivity;

  ActivityLevelDropdownMenu({
    super.key,
    required this.activityLevelController,
    this.selectedActivity,
  });

  @override
  State<ActivityLevelDropdownMenu> createState() =>
      _ActivityLevelDropdownMenuState();
}

class _ActivityLevelDropdownMenuState extends State<ActivityLevelDropdownMenu> {
  Activity? _selectedActivity;

  @override
  void initState() {
    super.initState();
    _selectedActivity = widget.selectedActivity;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: InputDecorator(
        decoration: InputDecoration(
          label: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'طبيعة الحركة و العمل',
                style: TextStyle(
                  fontSize: 16,
                  color: _selectedActivity != null
                      ? Colors.black
                      : Colors.transparent,
                ),
              ),
            ],
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
        ),
        // textAlign: TextAlign.right, // Add text alignment for the decorator
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Activity>(
            value: _selectedActivity,
            isExpanded: true,
            alignment: AlignmentDirectional.centerEnd, // Align dropdown content
            icon: const Icon(Icons.arrow_drop_down),
            style: const TextStyle(
              color: Colors.black,
            ),
            dropdownColor: Colors.blue[50]!,
            onChanged: (Activity? newValue) {
              setState(() {
                _selectedActivity = newValue;
                widget.activityLevelController.text = newValue?.name ?? '';
              });
            },
            items: Activity.values.map((Activity activity) {
              return DropdownMenuItem<Activity>(
                value: activity,
                alignment: AlignmentDirectional.centerEnd, // Align menu items
                child: Text(
                  getActivityLevelLabel(activity),
                  textAlign: TextAlign.right, // Align text within the item
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
            hint: Text(
              'طبيعة الحركة و العمل',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
