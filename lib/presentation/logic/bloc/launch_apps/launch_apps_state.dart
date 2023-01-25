part of 'launch_apps_bloc.dart';

abstract class LaunchAppsState extends Equatable {
  const LaunchAppsState();

  @override
  List<Object> get props => [];
}

/// initial
class LaunchAppsInitial extends LaunchAppsState {}

/// loading to launch facebook
class LoadingToOpenFacebook extends LaunchAppsState {}

/// loading to launch whatsapp
class LoadingToLaunchWhatsapp extends LaunchAppsState {}

/// loading to launch map
class LoadingToLaunchMap extends LaunchAppsState {}

/// loading to make a call
class LoadingToMakeACall extends LaunchAppsState {}

/// success
class SuccessToLaunchApp extends LaunchAppsState {}

/// error while open facebook
class ErrorWhileOpenFacebook extends LaunchAppsState {
  final OpenFaceBookParams openFaceBookParams;
  final AppError appError;

  const ErrorWhileOpenFacebook({
    required this.openFaceBookParams,
    required this.appError,
  });

  @override
  List<Object> get props => [openFaceBookParams];
}


/// error while whats app
class ErrorWhileOpenWhatsApp extends LaunchAppsState {
  final WhatsappParams whatsappParams;
  final AppError appError;

  const ErrorWhileOpenWhatsApp({
    required this.whatsappParams,
    required this.appError,
  });

  @override
  List<Object> get props => [whatsappParams];
}

/// error while open map
class ErrorWhileOpenMap extends LaunchAppsState {
  final OpenMapParams openMapParams;
  final AppError appError;

  const ErrorWhileOpenMap({
    required this.openMapParams,
    required this.appError,
  });

  @override
  List<Object> get props => [openMapParams];
}

/// error while make a call
class ErrorWhileMakeACall extends LaunchAppsState {
  final MakeCallParams makeCallParams;
  final AppError appError;

  const ErrorWhileMakeACall({
    required this.makeCallParams,
    required this.appError,
  });

  @override
  List<Object> get props => [makeCallParams];
}
