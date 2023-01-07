import 'dart:async';

import 'package:hive/hive.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/domain/entities/authorized_user_entity.dart';
import 'package:remax_mapstate/domain/entities/auto_login_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppSettingsLocalDataSource {
  //=============================>  Language   <==============================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\
  /// update current preferred language
  Future<void> updateLanguage(String languageCode);

  /// return the current preferred language
  Future<String> getPreferredLanguage();

  //=============================>  User Date   <=============================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\

  /// return UserEntity
  Future<AuthorizedUserEntity> getCurrentUser();

  /// save current user Entity
  Future<void> saveCurrentUser(AuthorizedUserEntity userEntity);

  /// to remove current user data
  Future<void> deleteCurrentUser();

  //============================>  Auto Login   <=============================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\

  /// return LoginStatus
  Future<AutoLoginEntity> getAutoLogin();

  /// return save LoginStatus
  Future<void> saveLoginStatus(AutoLoginEntity autoLoginEntity);

  /// to remove auto login
  Future<void> deleteAutoLogin();
}

class AppSettingsLocalDataSourceImpl extends AppSettingsLocalDataSource {
  //=============================>  Language   <==============================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\
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

  //=============================>  User Date   <=============================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\
  /// to remove current user data
  @override
  Future<void> deleteCurrentUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList("userData", []);
  }

  /// return UserEntity
  @override
  Future<AuthorizedUserEntity> getCurrentUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    // userId
    final userId = preferences.getString("userId") ?? "-1";

    // userData
    final data = preferences.getStringList("userData") ?? [];

    // return user data
    return data.isNotEmpty
        ? AuthorizedUserEntity(
            id: userId,
            firstName: data[0],
            lastName: data[1],
            email: data[2],
            phoneNum: data[3],
            userType: userTypeFromString(data[4]),
            //phoneNum: data[4],
            // acceptTerms: acceptTermsFromString(data[5]))
            // : AuthorizedUserEntity.empty()
          )
        : AuthorizedUserEntity.empty();
  }

  /// save current user Entity
  @override
  Future<void> saveCurrentUser(AuthorizedUserEntity userEntity) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("userId", userEntity.id);
    preferences.setStringList("userData", [
      userEntity.firstName,
      userEntity.lastName,
      userEntity.email,
      userEntity.phoneNum,
      userEntity.userType.toShortString(),
      //userEntity.phoneNum,
      //userEntity.acceptTerms.toShortString(),
    ]);
  }

  //===============================>  Token  <================================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\

  /// return LoginStatus
  @override
  Future<AutoLoginEntity> getAutoLogin() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final currentUserToken = preferences.getString("isLoggedIn") ?? "";
    return AutoLoginEntity(userToken: currentUserToken);
  }

  /// return save LoginStatus
  @override
  Future<void> saveLoginStatus(AutoLoginEntity autoLoginEntity) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("isLoggedIn", autoLoginEntity.userToken);
  }

  /// to remove auto login
  @override
  Future<void> deleteAutoLogin() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("isLoggedIn", "");
  }
}
