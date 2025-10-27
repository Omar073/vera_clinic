import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Core/Model/Firebase/ClientConstantInfoFirestoreMethods.dart';

class ClientConstantInfoProvider with ChangeNotifier {
  final ClientConstantInfoFirestoreMethods
      _mClientConstantInfoFirestoreMethods =
      ClientConstantInfoFirestoreMethods();

  List<ClientConstantInfo?> _mCachedClientConstantInfo = [];

  List<ClientConstantInfo?> get cachedClientConstantInfo =>
      _mCachedClientConstantInfo;
  ClientConstantInfoFirestoreMethods get clientConstantInfoFirestoreMethods =>
      _mClientConstantInfoFirestoreMethods;

  Future<void> createClientConstantInfo(
      ClientConstantInfo clientConstantInfo) async {
    clientConstantInfo.mClientConstantInfoId =
        await clientConstantInfoFirestoreMethods
            .createClientConstantInfo(clientConstantInfo);
    //! no need to update the firebase instance with the new ID as this already happens in the firebase method
    cachedClientConstantInfo.add(clientConstantInfo);
    notifyListeners();
  }

  Future<ClientConstantInfo?> getClientConstantInfoByClientId(
      String clientId) async {
    try {
      ClientConstantInfo? clientConstantInfo =
          cachedClientConstantInfo.firstWhere(
        (clientConstantInfo) => clientConstantInfo?.mClientId == clientId,
        orElse: () => null,
      );

      clientConstantInfo ??= await clientConstantInfoFirestoreMethods
          .fetchClientConstantInfoByClientId(clientId);

      if (clientConstantInfo != null) {
        cachedClientConstantInfo.add(clientConstantInfo);
        WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
      }
      return clientConstantInfo;
    } catch (e) {
      debugPrint('Error getting client constant info by client ID: $e');
      return null;
    }
  }

  Future<ClientConstantInfo?> getClientConstantInfoById(
      String clientConstantInfoId) async {
    ClientConstantInfo? clientConstantInfo =
        cachedClientConstantInfo.firstWhere(
      (clientConstantInfo) =>
          clientConstantInfo?.mClientConstantInfoId == clientConstantInfoId,
      orElse: () => null,
    );

    clientConstantInfo ??= await clientConstantInfoFirestoreMethods
        .fetchClientConstantInfoById(clientConstantInfoId);

    if (clientConstantInfo != null) {
      cachedClientConstantInfo.add(clientConstantInfo);
    }
    notifyListeners();
    return clientConstantInfo;
  }

  Future<bool> updateClientConstantInfo(
      ClientConstantInfo clientConstantInfo) async {
    try {
      await clientConstantInfoFirestoreMethods
          .updateClientConstantInfo(clientConstantInfo);
      int index = cachedClientConstantInfo.indexWhere((c) =>
          c?.mClientConstantInfoId == clientConstantInfo.mClientConstantInfoId);
      if (index != -1) {
        cachedClientConstantInfo[index] = clientConstantInfo;
      } else {
        cachedClientConstantInfo.add(clientConstantInfo);
      }
      notifyListeners();
      return true;
    } on Exception catch (e) {
      debugPrint("Failed to update client constant info: $e");
      return false;
    }
  }

  Future<bool> deleteClientConstantInfo(String clientConstantInfoId) async {
    try {
      await clientConstantInfoFirestoreMethods
          .deleteClientConstantInfo(clientConstantInfoId);
      cachedClientConstantInfo.removeWhere(
          (cci) => cci?.mClientConstantInfoId == clientConstantInfoId);
      notifyListeners();
      return true;
    } on Exception catch (e) {
      debugPrint("Failed to delete client constant info: $e");
      return false;
    }
  }
}
