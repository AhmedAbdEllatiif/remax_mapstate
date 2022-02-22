part of 'change_login_view_cubit.dart';

enum LoginView {phoneNum , pinCode}


class ChangeLoginViewState extends Equatable {

  final LoginView loginView;

  const ChangeLoginViewState({
    required this.loginView,
  });

  @override

  List<Object?> get props =>[loginView];
}


