import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/presentation/cubit/broker_changed/broker_changed_cubit.dart';

class BrokerTextName extends StatelessWidget {
  const BrokerTextName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<BrokerChangedCubit, BrokerChangedState>(
      builder: (blocContext,state){
        if (state is OnBrokerChangedState){
          return Text(
            state.brokerEntity.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.headline6,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
