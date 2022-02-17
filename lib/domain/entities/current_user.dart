import 'package:remax_mapstate/common/enums/user_types.dart';


class CurrentUserEntity {

  CurrentUserEntity({
    required String currentUserStr,
  }) : _currentUserStr = currentUserStr;

  String _currentUserStr;



  /// return a userType according to _currentUserStr
  UserType get userType {
    switch(_currentUserStr){
      case "client":  return  UserType.client;
      case "broker":  return  UserType.broker;
      case "tour":  return  UserType.tour;
      case "ambassador":  return  UserType.ambassador;
      case "noUser":  return  UserType.noUser;
      default: return  UserType.noUser;
    }
  }


  /// To initialize  _currentUserStr
  set userType(UserType userType) => _currentUserStr = userType.toShortString();



}


/// This how to initiate private vars
/*
*  class Student{

    var _id;
    var _name;

    Student({this._id, this._name}); // error

    void set id(int id) => _id = id;
    void set name(String name) => _name = name;
  }*/

/*
>>>>>>>>>>>> The alternative <<<<<<<
*  class Student{

    var _id;
    var _name;

    Student({int id, String name}) : _id = id, _name = name;

    void set id(int id) => _id = id;
    void set name(String name) => _name = name;
  }*/
