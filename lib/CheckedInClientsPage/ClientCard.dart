import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/View/Pages/FollowUpNav.dart';

import '../Core/Controller/Providers/ClinicProvider.dart';
import '../Core/Controller/UtilityFunctions.dart';
import '../Core/Model/Classes/Client.dart';

class ClientCard extends StatefulWidget {
  final Client? client;
  final int index;
  final VoidCallback onClientCheckedOut;
  const ClientCard({
    super.key, 
    required this.client, 
    required this.index,
    required this.onClientCheckedOut,
  });

  @override
  State<ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard> {
  bool _isCheckingOut = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        child: ListTile(
          title: Wrap(
            spacing: 30,
            children: [
              Text('عميل: ' '${widget.index + 1}'),
              Text('الاسم: ${widget.client?.mName ?? 'غير معروف'}'),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'نوع الاشتراك: '
              '${getSubscriptionTypeLabel(widget.client?.mSubscriptionType
                  ?? SubscriptionType.none)}',
            ),
          ),
          trailing: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: _isCheckingOut ? Colors.grey : Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
            icon: _isCheckingOut 
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Icon(Icons.delete),
            onPressed: _isCheckingOut ? null : () async {
              setState(() {
                _isCheckingOut = true;
              });
              try {
                await context.read<ClinicProvider>().checkOutClient(widget.client!);
                widget.onClientCheckedOut();
              } finally {
                if (mounted) {
                  setState(() {
                    _isCheckingOut = false;
                  });
                }
              }
            },
            label: Text(
              _isCheckingOut ? 'جاري تسجيل الخروج...' : 'تسجيل خروج',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => FollowUpNav(client: widget.client!)),
            );
          },
        ),
      ),
    );
  }
}
