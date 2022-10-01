import 'dart:async';

import 'package:hive/hive.dart';
import 'package:remax_mapstate/common/enums/login_status.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/auto_login_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../tables/current_user_table.dart';

abstract class AppSettingsLocalDataSource {
  ///********************************** Language *********************************\\\\
  /// update current preferred language
  Future<void> updateLanguage(String languageCode);

  /// return the current preferred language
  Future<String> getPreferredLanguage();

  ///********************************** currentUser *********************************\\\\
  /// update current preferred language
  Future<void> updateCurrentUser(CurrentUserTable userType);

  /// return the current preferred language
  Future<CurrentUserTable> getCurrentUser();

  /// return LoginStatus
  Future<AutoLoginEntity> getAutoLogin();

  /// return save LoginStatus
  Future<void> saveLoginStatus(AutoLoginEntity autoLoginEntity);

  /// to remove auto login
  Future<void> deleteAutoLogin();
}

class AppSettingsLocalDataSourceImpl extends AppSettingsLocalDataSource {

  ///********************************** Language *********************************\\\\
  /// return the current preferred language
  /// return 'en' as default if no language box in local DB
  @override
  Future<String> getPreferredLanguage() async {
    final languageBox = await Hive.openBox('languageBox');
    return languageBox.get('preferred_language') ?? 'en';
  }

  /// update current preferred language
  @override
  Future<void> updateLanguage(String languageCode) async {
    final languageBox = await Hive.openBox('languageBox');
    unawaited(languageBox.put('preferred_language', languageCode));
  }


  ///********************************** currentUser *********************************\\\\

  /// update currentUser
  @override
  Future<void> updateCurrentUser(CurrentUserTable currentUser) async {
    final currentUserBox = await Hive.openBox('currentUserBox');
    await currentUserBox.put('currentUser', currentUser);
  }

  /// return the currentUser
  /// return 'noUser' as default if no currentUserBox in local DB
  @override
  Future<CurrentUserTable> getCurrentUser() async {
    final currentUserBox = await Hive.openBox('currentUserBox');
    return currentUserBox.get('currentUser') ??
        CurrentUserTable(currentUser: UserType.noUser.toShortString());
  }


  /// return LoginStatus
  @override
  Future<AutoLoginEntity> getAutoLogin() async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final currentLoginStatusStr =  preferences.getString("isLoggedIn") ??
        LoginStatus.notLoggedIn.toShortString();
    return AutoLoginEntity(currentLoginStatusStr: currentLoginStatusStr);
  }

  /// return save LoginStatus
  @override
  Future<void> saveLoginStatus(AutoLoginEntity autoLoginEntity) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("isLoggedIn", autoLoginEntity.loginStatus.toShortString());
  }

  /// to remove auto login
  @override
  Future<void> deleteAutoLogin() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("isLoggedIn", LoginStatus.notLoggedIn.toShortString());
  }


}
