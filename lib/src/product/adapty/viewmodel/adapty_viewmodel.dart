import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:flutter_mb_adapty/flutter_mb_adapty.dart';
import 'package:flutter_mb_adapty/src/core/const/adapty_error_strings.dart';
import 'package:flutter_mb_adapty/src/core/model/mb_adapty_configuration.dart';
import 'package:flutter_mb_adapty/src/product/adapty/mixin/adapty_vm_mixin.dart';
import 'package:mb_adapty_core/mb_adapty_core.dart';

class AdaptyViewmodel<T extends IMBAdaptyRemoteConfig<T>,
        R extends IMBAdaptyProductConfig<R, T>> extends AdaptyCubit<T, R>
    with AdaptyVmMixin {
  AdaptyViewmodel(super.initialState);

  final MBAdaptyGateService _adaptyService = MBAdaptyGateService(
    adaptyCore: MBAdaptyCore(),
  );

  MBAdaptyProfile? get adaptyProfile => state.adaptyProfile;
  set adaptyProfile(MBAdaptyProfile? value) {
    emit(state.copyWith(adaptyProfile: value));
  }

  List<MBAdaptyPaywall> get viewedPaywallStack => state.viewedPaywallStack;
  MBAdaptyPaywall? get lastViewedPaywall =>
      viewedPaywallStack.isNotEmpty ? viewedPaywallStack.last : null;
  void addViewedPaywall(MBAdaptyPaywall paywall) {
    emit(state.copyWith(viewedPaywallStack: [...viewedPaywallStack, paywall]));
  }

  @override
  Future<void> initAdapty(MBAdaptyConfiguration configuration) async {
    await _adaptyService.activate();
    configureAdapty(configuration);
    if (configuration.loadAdaptyProfileOnInitialize) {
      await loadAdaptyProfile(_adaptyService);
    }
    if (configuration.loadAllPlacementPaywallsOnInitialize) {
      if ((state.configuration?.placementIDs ?? []).isEmpty) {
        onAdaptyError(
          AdaptyGetPaywallsError(AdaptyErrorStrings.noPlacementIDsProvided),
        );
      } else {
        try {
          await loadAllPaywallsByPlacements<T, R>(
            _adaptyService,
            MBRemoteConfig() as T,
          );
        } catch (e) {
          onAdaptyError(e, message: AdaptyErrorStrings.loadAllPaywallsError);
        }
      }
    }
  }

  @override
  Future<void> onGetAllPaywalls({
    List<String>? placementIDs,
    T? remoteConfigModel,
  }) async {
    try {
      await loadAllPaywallsByPlacements<T, R>(
        _adaptyService,
        remoteConfigModel ?? MBRemoteConfig() as T,
      );
    } catch (e) {
      onAdaptyError(e, message: AdaptyErrorStrings.loadAllPaywallsError);
    }
  }

  @override
  Future<MBAdaptyPaywall<T, R>?> onGetPaywall({
    required String placementId,
    T? remoteConfigModel,
    bool? useCachedPaywall,
    Function()? onPaywallLoadError,
  }) async {
    bool willFetchPaywall = true;
    if (state.configuration?.getCachedPaywallIfAvailable ?? false) {
      if (useCachedPaywall == false) {
        willFetchPaywall = true;
      } else {
        willFetchPaywall = !state.viewedPaywallStack
            .any((element) => element.placementId == placementId);
      }
    } else {
      if (useCachedPaywall == true) {
        willFetchPaywall = !state.viewedPaywallStack
            .any((element) => element.placementId == placementId);
      }
    }
    if (!willFetchPaywall) {
      try {
        return state.viewedPaywallStack
                .firstWhere((element) => element.placementId == placementId)
            as MBAdaptyPaywall<T, R>;
      } catch (e) {
        onAdaptyError(
          e,
          message: AdaptyErrorStrings.viewedStackFirstWhereError,
        );
        return null;
      }
    }
    try {
      final mbPaywall = await _adaptyService.getPaywall<T, R>(
        placementId: placementId,
        remoteConfigModel: remoteConfigModel ?? MBRemoteConfig() as T,
        fetchPolicy: state.configuration?.fetchPolicy,
        withProductConfigs:
            state.configuration?.getPaywallsWithProductConfigModel ?? false,
      );

      return mbPaywall;
    } catch (e) {
      onAdaptyError(e, message: AdaptyErrorStrings.loadPaywallError);
      onPaywallLoadError?.call();
      return null;
    }
  }

  @override
  Future<void> onMakePurchase({
    // TODO: Change AdaptyPaywallProduct to IMBAdaptyProductConfig
    required AdaptyPaywallProduct product,
    Function(MBAdaptyProfile)? onPurchaseSuccess,
    Function()? onPurchaseError,
  }) async {
    try {
      final purchasedProfile =
          await _adaptyService.makePurchase(product: product);
      onPurchaseSuccess?.call(purchasedProfile);
    } catch (e) {
      onAdaptyError(e, message: AdaptyErrorStrings.makePurchaseError);
      await onPurchaseError?.call();
    }
  }

  @override
  Future<void> onPaywallView({
    required MBAdaptyPaywall paywall,
    Function()? customViewTrackerEvent,
  }) async {
    if (state.configuration?.logEveryPaywallView ?? false) {
      try {
        await _adaptyService.logShowPaywall(paywall: paywall);
      } catch (e) {
        onAdaptyError(e, message: AdaptyErrorStrings.logPaywallError);
      }
    } else {
      // TODO: Add AdaptyLogPaywallViewError
    }
    addViewedPaywall(paywall);
    customViewTrackerEvent?.call();
  }

  @override
  Future<void> onRestorePurchases({
    Function(MBAdaptyProfile)? onRestoreSuccess,
    Function()? onRestoreError,
  }) async {
    try {
      final restoredProfile = await _adaptyService.restorePurchases();
      onRestoreSuccess?.call(restoredProfile);
    } catch (e) {
      onAdaptyError(e, message: AdaptyErrorStrings.restorePurchasesError);
      await onRestoreError?.call();
    }
  }

  @override
  Future<void> updateAndGetProfile({
    Function(MBAdaptyProfile)? onProfileUpdateSuccess,
    Function()? onProfileUpdateError,
  }) async {
    try {
      final MBAdaptyProfile mbAdaptyProfile =
          await _adaptyService.getAdaptyProfile();
      adaptyProfile = mbAdaptyProfile;
    } catch (e) {
      onAdaptyError(e, message: AdaptyErrorStrings.getAdaptyProfileError);
      onProfileUpdateError?.call();
    }
  }
}
