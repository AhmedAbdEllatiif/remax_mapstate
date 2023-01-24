part of 'launch_apps_bloc.dart';

abstract class LaunchAppsEvent extends Equatable {
  const LaunchAppsEvent();

  @override
  List<Object?> get props => [];
}




/// open what's app
class OpenWhatsAppEvent extends LaunchAppsEvent {
  final WhatsappParams whatsappParams;

  const OpenWhatsAppEvent({required this.whatsappParams});

  @override
  List<Object?> get props => [whatsappParams];
}

/// open map
class OpenMapEvent extends LaunchAppsEvent {
  final OpenMapParams openMapParams;

  const OpenMapEvent({required this.openMapParams});

  @override
  List<Object?> get props => [openMapParams];
}

/// make a call
class MakeACallEvent extends LaunchAppsEvent {
  final MakeCallParams makeCallParams;

  const MakeACallEvent({required this.makeCallParams});

  @override
  List<Object?> get props => [makeCallParams];
}
