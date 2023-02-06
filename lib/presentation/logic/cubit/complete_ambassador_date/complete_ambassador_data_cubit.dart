import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/app_error.dart';

part 'complete_ambassador_data_state.dart';

class CompleteAmbassadorDataCubit extends Cubit<CompleteAmbassadorDataState> {
  CompleteAmbassadorDataCubit() : super(CompleteAmbassadorDataInitial());
}
