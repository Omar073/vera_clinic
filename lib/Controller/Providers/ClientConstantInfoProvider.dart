import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Model/Firebase/ClientConstantInfoFirestoreMethods.dart';

class ClientConstantInfoProvider with ChangeNotifier {
  ClientConstantInfoFirestoreMethods _clientConstantInfoFirestoreMethods =
      ClientConstantInfoFirestoreMethods();

  ClientConstantInfo? _currentClientConstantInfo;
  List<ClientConstantInfo> _cachedClientConstantInfo = [];

  ClientConstantInfo? get currentClientConstantInfo =>
      _currentClientConstantInfo;
  List<ClientConstantInfo> get cachedClientConstantInfo =>
      _cachedClientConstantInfo;
  ClientConstantInfoFirestoreMethods get clientConstantInfoFirestoreMethods =>
      _clientConstantInfoFirestoreMethods;

  void createCurrentClientConstantInfo(ClientConstantInfo clientConstantInfo) {
    clientConstantInfo.clientConstantInfoId = clientConstantInfoFirestoreMethods
        .createClientConstantInfo(clientConstantInfo) as String;
    cachedClientConstantInfo.add(clientConstantInfo);
    notifyListeners();
  }

  ClientConstantInfo getClientConstantInfo(String clientPhoneNum) {
    return cachedClientConstantInfo.firstWhere(
      (clientConstantInfo) =>
          clientConstantInfo.clientPhoneNum == clientPhoneNum,
      orElse: () => clientConstantInfoFirestoreMethods
          .fetchClientConstantInfoByNum(clientPhoneNum),
    );
  }

  void setCurrentClientConstantInfo(ClientConstantInfo clientConstantInfo) {
    _currentClientConstantInfo = clientConstantInfo;
    notifyListeners();
  }
}
