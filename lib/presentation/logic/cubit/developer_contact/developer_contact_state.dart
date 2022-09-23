part of 'developer_contact_cubit.dart';

abstract class DeveloperContactState extends Equatable {
  final ContactDeveloperEntity? contactDeveloperEntity;

  const DeveloperContactState({
    this.contactDeveloperEntity,
  });

  @override
  List<Object> get props => [];
}

/// Loading
class LoadingDeveloperContactState extends DeveloperContactState {}

/// With image
class DeveloperContactDataLoadedWithImage extends DeveloperContactState {
  final ContactDeveloperEntity contactDeveloperEntity;

  const DeveloperContactDataLoadedWithImage({
    required this.contactDeveloperEntity,
  }) : super(contactDeveloperEntity:contactDeveloperEntity);

  @override
  List<Object> get props => [contactDeveloperEntity];
}

/// Without image
class DeveloperContactDataWithOutImage extends DeveloperContactState {
  final ContactDeveloperEntity contactDeveloperEntity;

  const DeveloperContactDataWithOutImage({
    required this.contactDeveloperEntity,
  }) : super(contactDeveloperEntity:contactDeveloperEntity);

  @override
  List<Object> get props => [contactDeveloperEntity];
}

/// Error
class DeveloperContactErrorState extends DeveloperContactState {
  final AppError appError;

  const DeveloperContactErrorState({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}
