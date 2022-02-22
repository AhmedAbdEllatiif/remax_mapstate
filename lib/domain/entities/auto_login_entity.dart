import 'package:remax_mapstate/common/enums/login_status.dart';

class AutoLoginEntity {

  AutoLoginEntity({
    required String currentLoginStatusStr,
  }) : _currentLoginStatusStr = currentLoginStatusStr;

  String _currentLoginStatusStr;



  /// return a userType according to _currentUserStr
  LoginStatus get loginStatus {
    switch(_currentLoginStatusStr){
      case "loggedIn":  return  LoginStatus.loggedIn;
      case "LoginStatus":  return  LoginStatus.notLoggedIn;
      default: return  LoginStatus.notLoggedIn;
    }
  }


  /// To initialize  _currentUserStr
  set loginStatus(LoginStatus loginStatus) => _currentLoginStatusStr = loginStatus.toShortString();



}