import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClinicProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';
import 'package:vera_clinic/Core/Controller/UtilityFunctions.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/View/PopUps/MySnackBar.dart';
import 'package:vera_clinic/HomePage/HomePage.dart';
import 'package:vera_clinic/NewVisit/View/NewVisit.dart';
import '../../Controller/ClientRegistrationTEC.dart';
import '../../Controller/ClientRegistrationUF.dart';
import '../../Controller/NewClientCreation.dart';

class ActionButtons extends StatefulWidget {
  const ActionButtons({super.key});

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  bool isSaving = false;
  bool isLoggingIn = false;
  final TextEditingController _subscriptionPriceController =
      TextEditingController();
  final TextEditingController _subscriptionTypeController =
      TextEditingController();

  @override
  void dispose() {
    _subscriptionPriceController.dispose();
    _subscriptionTypeController.dispose();
    super.dispose();
  }

  Future<void> _showSubscriptionDialog(Client client) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue[50]!,
          title: const Text(
            'إدخال بيانات الاشتراك',
            textAlign: TextAlign.end,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _subscriptionPriceController,
                textAlign: TextAlign.end,
                decoration: const InputDecoration(
                  labelText: 'سعر الاشتراك',
                  hintText: 'أدخل سعر الاشتراك',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _subscriptionTypeController,
                textAlign: TextAlign.end,
                decoration: const InputDecoration(
                  labelText: 'نوع الاشتراك',
                  hintText: 'أدخل نوع الاشتراك',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('إلغاء',
                  textAlign: TextAlign.end,
                  style: const TextStyle(color: Colors.blueAccent)),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final double subscriptionPrice =
                      double.parse(_subscriptionPriceController.text);

                  // Set the subscription type for the client
                  client.mSubscriptionType = getSubscriptionTypeFromString(
                      _subscriptionTypeController.text);

                  // Check if the client is already checked in
                  bool isCheckedIn = await context
                      .read<ClinicProvider>()
                      .isClientCheckedIn(client.mClientId);
                  if (!isCheckedIn) {
                    // Add the client to the checked-in clients list
                    await context.read<ClinicProvider>().checkInClient(client);
                    // Increment the daily patients count
                    await context
                        .read<ClinicProvider>()
                        .incrementDailyPatients();
                    // Update the daily income
                    await context
                        .read<ClinicProvider>()
                        .updateDailyIncome(subscriptionPrice);
                    // Update client info (mainly because the subscription type is changed)
                    await context.read<ClientProvider>().updateClient(client);

                    if (!mounted) return;
                    showMySnackBar(
                        context, 'تم تسجيل العميل بنجاح', Colors.green);

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  } else {
                    if (!mounted) return;
                    showMySnackBar(context, 'العميل مسجل بالفعل', Colors.red);
                  }
                } catch (e) {
                  if (!mounted) return;
                  showMySnackBar(context, 'الرجاء إدخال سعر الاشتراك بشكل صحيح',
                      Colors.red);
                }
              },
              child: const Text('تأكيد',
                  textAlign: TextAlign.end,
                  style: const TextStyle(color: Colors.blueAccent)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _saveButton(),
          const SizedBox(width: 16),
          _loginButton(),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewVisit()),
              );
            },
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              "تسجيل زيارة سابقة",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
              textStyle: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {
              ClientRegistrationTEC.clear();
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

  Widget _saveButton() {
    //todo: separate into different files
    return _buildButton(
      isLoading: isSaving,
      onPressed: () async {
        await _handleSave();
      },
      icon: Icons.save,
      loadingText: 'جاري الحفظ...',
      text: 'حفظ',
      backgroundColor: Colors.blueAccent,
    );
  }

  Widget _loginButton() {
    return _buildButton(
      isLoading: isLoggingIn,
      onPressed: () async {
        await _handleLogin();
      },
      icon: Icons.person_add,
      loadingText: 'جاري التسجيل...',
      text: 'تسجيل دخول',
      backgroundColor: Colors.teal,
    );
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

  Future<void> _handleSave() async {
    if (!verifyRequiredFields(context) || !verifyFieldsDataType(context)) {
      return;
    }

    setState(() => isSaving = true);
    try {
      Map<bool, Client?> result = await createClient(context);
      bool success = result.keys.first;
      Client? c = result.values.last;

      if (!mounted) return; // Check if the widget is still mounted

      showMySnackBar(
          context,
          (success && c != null) ? 'تم التسجيل بنجاح' : 'فشل التسجيل',
          (success && c != null) ? Colors.green : Colors.red);

      if (success) {
        Navigator.pop(context);
      }
    } finally {
      setState(() => isSaving = false);
    }
  }

  Future<void> _handleLogin() async {
    if (!verifyRequiredFields(context) || !verifyFieldsDataType(context)) {
      return;
    }

    setState(() => isLoggingIn = true);
    try {
      final Map<bool, Client?> result = await createClient(context);
      final bool success = result.keys.first;
      final Client? client = result.values.last;

      if (!mounted) return;

      if (success && client != null) {
        await _showSubscriptionDialog(client);
      } else {
        showMySnackBar(
            context, "فشل في تسجيل العميل. حاول مرة أخرى.", Colors.red);
      }
    } finally {
      if (mounted) {
        setState(() => isLoggingIn = false);
      }
    }
  }
}
