import 'package:flutter/material.dart';
import 'package:flutter_mb_adapty/flutter_mb_adapty.dart';
import 'package:flutter_mb_adapty/src/core/model/mb_adapty_configuration.dart';
import 'package:flutter_mb_adapty/src/core/model/mb_adapty_placements.dart';
import 'package:mb_adapty_core/mb_adapty_core.dart';

mixin AdaptyVmMixin on BaseCubit<AdaptyState> {
  void configureAdapty(MBAdaptyConfiguration configuration) {
    emit(state.copyWith(configuration: configuration));
  }

  void onAdaptyError(Object e, {String? message}) {
    debugPrint(
        '\n------\n[MBAdapty ERROR]: ${e.toString()}\n-MBAdapty Error Info: $message\n------\n');
    state.configuration?.onAdaptyError?.call(e, message ?? '');
  }

  Future<void> loadAllPaywallsByPlacements<T extends IMBAdaptyRemoteConfig<T>,
      R extends IMBAdaptyProductConfig<R, T>>(
    MBAdaptyGateService adaptyService,
    T remoteConfigModel,
  ) async {
    final placementsWithPaywall =
        await adaptyService.getPaywallsByPlacements<T, R>(
      placementIds: state.placements!.map((e) => e.placementId).toList(),
      remoteConfigModel: remoteConfigModel,
    );
    List<MBAdaptyPlacement> placements = [];
    for (var placementEntry in placementsWithPaywall.entries) {
      MBAdaptyPlacement<T, R> statePlacement =
          MBAdaptyPlacement<T, R>.fromServiceMap(placementEntry);
      placements.add(statePlacement);
    }
    emit(state.copyWith(placements: placements));
  }

  Future<void> loadAdaptyProfile(MBAdaptyGateService adaptyService) async {
    MBAdaptyProfile adaptyProfile = await adaptyService.getAdaptyProfile();
    emit(state.copyWith(adaptyProfile: adaptyProfile));
  }

  Future<MBAdaptyProfile> loadAndGetAdaptyProfile(
      MBAdaptyGateService adaptyService) async {
    MBAdaptyProfile adaptyProfile = await adaptyService.getAdaptyProfile();
    emit(state.copyWith(adaptyProfile: adaptyProfile));
    return adaptyProfile;
  }
}
