import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Model/Firebase/ClientConstantInfoFirestoreMethods.dart';

class ClientConstantInfoProvider with ChangeNotifier {
  final ClientConstantInfoFirestoreMethods
      _mClientConstantInfoFirestoreMethods =
      ClientConstantInfoFirestoreMethods();

  ClientConstantInfo? _mCurrentClientConstantInfo;
  List<ClientConstantInfo?> _mCachedClientConstantInfo = [];

  ClientConstantInfo? get currentClientConstantInfo =>
      _mCurrentClientConstantInfo;
  List<ClientConstantInfo?> get cachedClientConstantInfo =>
      _mCachedClientConstantInfo;
  ClientConstantInfoFirestoreMethods get clientConstantInfoFirestoreMethods =>
      _mClientConstantInfoFirestoreMethods;

  void createCurrentClientConstantInfo(ClientConstantInfo clientConstantInfo) {
    clientConstantInfo.clientConstantInfoId = clientConstantInfoFirestoreMethods
        .createClientConstantInfo(clientConstantInfo) as String;
    cachedClientConstantInfo.add(clientConstantInfo);
    notifyListeners();
  }

  Future<ClientConstantInfo?> getClientConstantInfoByClientId(
      String clientId) async {
    ClientConstantInfo? clientConstantInfo =
        cachedClientConstantInfo.firstWhere(
      (clientConstantInfo) => clientConstantInfo?.clientId == clientId,
      orElse: () => null,
    );

    clientConstantInfo ??= await clientConstantInfoFirestoreMethods
        .fetchClientConstantInfoByClientId(clientId);

    clientConstantInfo == null
        ? cachedClientConstantInfo.add(clientConstantInfo)
        : null;
    notifyListeners();
    return clientConstantInfo;
  }

  Future<ClientConstantInfo?> getClientConstantInfoById(
      String clientConstantInfoId) async {
    ClientConstantInfo? clientConstantInfo =
        cachedClientConstantInfo.firstWhere(
      (clientConstantInfo) =>
          clientConstantInfo?.clientConstantInfoId == clientConstantInfoId,
      orElse: () => null,
    );

    clientConstantInfo ??= await clientConstantInfoFirestoreMethods
        .fetchClientConstantInfoById(clientConstantInfoId);

    clientConstantInfo == null
        ? cachedClientConstantInfo.add(clientConstantInfo)
        : null;
    notifyListeners();
    return clientConstantInfo;
  }

  void updateCurrentClientConstantInfo(ClientConstantInfo clientConstantInfo) {
    clientConstantInfoFirestoreMethods
        .updateClientConstantInfo(clientConstantInfo);
    notifyListeners();
  }

  void setCurrentClientConstantInfo(ClientConstantInfo clientConstantInfo) {
    _mCurrentClientConstantInfo = clientConstantInfo;
    notifyListeners();
  }
}
