import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/fetch_buyer_user_params.dart';
import '../../../../domain/entities/users/user_entity.dart';
import '../../../../domain/use_cases/get_buyer_by_id.dart';

part 'get_buyer_by_id_state.dart';

class GetBuyerByIdCubit extends Cubit<GetBuyerByIdState> {
  GetBuyerByIdCubit() : super(GetBuyerByIdInitial());

  /// getBuyerById
  void getBuyerById({
    required String buyerId,
  }) async {
    //==> convert BuyerId from string to int
    final id = int.tryParse(buyerId);

    //==> check if id is null
    if (id == null) {
      _emitIfNotClosed(NotABuyerBeforeGettingBuyerById());
    }

    //==> check if id is -1
    else if (id == -1) {
      _emitIfNotClosed(NotABuyerBeforeGettingBuyerById());
    }

    //==> else start loading the user data
    else {
      //=> loading
      _emitIfNotClosed(LoadingGetBuyerById());

      // init params
      final params = FetchBuyerUserParams(
        buyerId: id,
      );

      // init useCase
      final useCase = getItInstance<GetBuyerByIdCase>();

      // fetch unit type names
      final either = await useCase(params);

      either.fold(
        //==> error
        (appError) => _emitError(appError),

        //==> success
        (userEntity) {
          _emitIfNotClosed(
            BuyerDataFetched(userEntity: userEntity),
          );
        },
      );
    }
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unAuthorized) {
      _emitIfNotClosed(UnAuthorizedToGetBuyerById());
    } else {
      _emitIfNotClosed(ErrorWhileGettingBuyerById(appError: appError));
    }
  }

  /// emit if not closed
  void _emitIfNotClosed(GetBuyerByIdState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
