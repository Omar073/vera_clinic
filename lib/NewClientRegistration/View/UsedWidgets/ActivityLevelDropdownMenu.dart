import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientConstantInfo.dart';
import '../../Controller/UtilityFunctions.dart';

class ActivityLevelDropdownMenu extends StatefulWidget {
  final TextEditingController activityLevelController;
  final String? label;
  final double? width;

  const ActivityLevelDropdownMenu({
    super.key,
    required this.activityLevelController,
    this.label = 'طبيعة الحركة و العمل',
    this.width,
  });

  @override
  State<ActivityLevelDropdownMenu> createState() => _ActivityLevelDropdownMenuState();
}

class _ActivityLevelDropdownMenuState extends State<ActivityLevelDropdownMenu> {
  Activity? _selectedActivity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 200,
      child: InputDecorator(
        decoration: InputDecoration(
          label: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.label ?? 'طبيعة الحركة و العمل',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade400),
          ),
          // Add alignment for the input decorator
          alignLabelWithHint: true,
        ),
        textAlign: TextAlign.right, // Add text alignment for the decorator
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Activity>(
            value: _selectedActivity,
            isExpanded: true,
            alignment: AlignmentDirectional.centerEnd, // Align dropdown content
            icon: const Icon(Icons.arrow_drop_down),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            onChanged: (Activity? newValue) {
              setState(() {
                _selectedActivity = newValue;
                widget.activityLevelController.text = newValue?.name ?? '';
              });
            },
            items: Activity.values
                .where((activity) => activity != Activity.none)
                .map((Activity activity) {
              return DropdownMenuItem<Activity>(
                value: activity,
                alignment: AlignmentDirectional.centerEnd, // Align menu items
                child: Container(
                  width: double.infinity, // Ensure full width
                  child: Text(
                    getActivityLevelLabel(activity),
                    textAlign: TextAlign.right, // Align text within the item
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              );
            }).toList(),
            hint: Text(
              widget.label ?? 'طبيعة الحركة و العمل',
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