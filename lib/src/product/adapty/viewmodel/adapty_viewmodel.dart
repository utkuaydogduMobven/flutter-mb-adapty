import 'package:flutter/material.dart';
import 'package:flutter_mb_adapty/flutter_mb_adapty.dart';
import 'package:flutter_mb_adapty/src/core/model/mb_adapty_configuration.dart';
import 'package:flutter_mb_adapty/src/product/adapty/mixin/adapty_vm_mixin.dart';
import 'package:mb_adapty_core/mb_adapty_core.dart';

class AdaptyViewmodel<T extends IMBAdaptyRemoteConfig<T>,
        R extends IMBAdaptyProductConfig<R, T>> extends AdaptyCubit
    with AdaptyVmMixin {
  AdaptyViewmodel(super.initialState);

  final MBAdaptyGateService _adaptyService = MBAdaptyGateService(
    adaptyCore: MBAdaptyCore(),
  );

  @override
  void initialEvent({BuildContext? context}) {}

  @override
  Future<void> initAdapty(MBAdaptyConfiguration configuration) async {
    await _adaptyService.activate();
    configureAdapty(configuration);
    if (configuration.loadAdaptyProfileOnInitialize) {
      await loadAdaptyProfile(_adaptyService);
    }
    if (configuration.loadAllPlacementPaywallsOnInitialize) {
      await loadAllPaywallsByPlacements<T, R>(
        _adaptyService,
        MBRemoteConfig() as T,
      );
    }
  }

  @override
  Future<void> onGetPaywall() {
    // TODO: implement onGetPaywall
    throw UnimplementedError();
  }

  @override
  Future<void> onMakePurchase() {
    // TODO: implement onMakePurchase
    throw UnimplementedError();
  }

  @override
  Future<void> onPaywallView() {
    // TODO: implement onPaywallView
    throw UnimplementedError();
  }

  @override
  Future<void> onRestorePurchases() {
    // TODO: implement onRestorePurchases
    throw UnimplementedError();
  }

  @override
  Future<void> updateAndGetProfile() {
    // TODO: implement updateAndGetProfile
    throw UnimplementedError();
  }
}
