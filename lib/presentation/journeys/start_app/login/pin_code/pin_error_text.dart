import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';

import '../../../../bloc/login/login_bloc.dart';

class PinErrorText extends StatelessWidget {
  const PinErrorText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (_, __) => true,
      builder: (context, state) {
        if (state is WrongCodeEntered) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              "*${state.appError.message.t(context)}",
              style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
