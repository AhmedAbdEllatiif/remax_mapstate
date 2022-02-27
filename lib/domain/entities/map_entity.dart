import 'package:equatable/equatable.dart';

class MapEntity extends Equatable{
  final double latitude;
  final double longitude;
  final String markerTitle;

  const MapEntity({
    required this.latitude,
    required this.longitude,
    required this.markerTitle,
  });


  @override
  List<Object?> get props => [latitude,longitude];
}