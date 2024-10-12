import 'package:flutter/material.dart';
import 'package:flutter_mb_adapty/src/product/paywall/viewmodel/cubit/paywall_cubit.dart';

import 'state/paywall_state.dart';

final class PaywallViewmodel extends PaywallCubit {
  PaywallViewmodel() : super(PaywallState());
  @override
  void initialEvent({BuildContext? context}) {
    // TODO: implement initialEvent
  }
}
