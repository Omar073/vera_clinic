import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';

import '../../../Core/Model/Classes/ClientConstantInfo.dart';
import '../../../Core/Model/Classes/ClientMonthlyFollowUp.dart';
import '../../../Core/Model/Classes/Disease.dart';
import '../../../Core/Model/Classes/PreferredFoods.dart';
import '../../../Core/Model/Classes/WeightAreas.dart';
import '../../../Core/View/PopUps/MySnackBar.dart';
import '../../Controller/UpdateClient.dart';
import '../../Controller/UpdateClientDetailsTEC.dart';
import '../../Controller/UpdateClientDetailsUF.dart';

class ActionButtonsU extends StatefulWidget {
  final Client? client;
  final Disease? disease;
  final ClientMonthlyFollowUp? monthlyFollowUp;
  final ClientConstantInfo? constantInfo;
  final WeightAreas? weightAreas;
  final PreferredFoods? preferredFoods;
  final VoidCallback onUpdateSuccess;

  const ActionButtonsU({
    super.key,
    required this.client,
    required this.disease,
    required this.monthlyFollowUp,
    required this.constantInfo,
    required this.weightAreas,
    required this.preferredFoods,
    required this.onUpdateSuccess,
  });

  @override
  State<ActionButtonsU> createState() => _ActionButtonsUState();
}

class _ActionButtonsUState extends State<ActionButtonsU> {
  bool isUpdating = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _updateButton(),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {
              UpdateClientDetailsTEC.clear();
              showMySnackBar(context, 'تم مسح البيانات', Colors.blueAccent);
            },
            icon: const Icon(Icons.clear, color: Colors.white),
            label: const Text(
              "مسح",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[700],
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
              textStyle: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _updateButton() {
    return _buildButton(
      isLoading: isUpdating,
      onPressed: () async {
        await _handleUpdate();
      },
      icon: Icons.edit,
      loadingText: 'جاري الحفظ...',
      text: 'تحديث',
      backgroundColor: Colors.blueAccent,
    );
  }

  Future<void> _handleUpdate() async {
    if (!verifyRequiredFieldsU(context) || !verifyFieldsDataTypeU(context)) {
      return;
    }

    setState(() => isUpdating = true);
    try {
      bool success = await updateClient(
        context,
        widget.client!,
        widget.disease!,
        widget.monthlyFollowUp!,
        widget.constantInfo!,
        widget.weightAreas!,
        widget.preferredFoods!,
      );
      if (!mounted) {
        return; // Check if the widget is still mounted
      }
      showMySnackBar(context, success ? 'تم تحديث بنجاح' : 'فشل التحديث',
          success ? Colors.green : Colors.red);

      if (success) {
        widget.onUpdateSuccess();
      }
    } finally {
      setState(() => isUpdating = false);
    }
  }

  Widget _buildButton({
    required bool isLoading,
    required VoidCallback onPressed,
    required IconData icon,
    required String loadingText,
    required String text,
    required Color backgroundColor,
  }) {
    return ElevatedButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            )
          : Icon(icon, color: Colors.white),
      label: Text(
        isLoading ? loadingText : text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
        textStyle: const TextStyle(fontSize: 20),
      ),
    );
  }
}
