import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:flutter_mb_adapty/flutter_mb_adapty.dart';
import 'package:mb_adapty_core/mb_adapty_core.dart';

abstract class AdaptyCubit<T extends IMBAdaptyRemoteConfig<T>,
    R extends IMBAdaptyProductConfig<R, T>> extends BaseCubit<AdaptyState> {
  AdaptyCubit(super.initialState);

  //void configureAdapty();

  Future<void> onMakePurchase({
    required AdaptyPaywallProduct product,
    Function(MBAdaptyProfile)? onPurchaseSuccess,
    Function()? onPurchaseError,
  });

  Future<void> onRestorePurchases({
    Function(MBAdaptyProfile)? onRestoreSuccess,
    Function()? onRestoreError,
  });

  Future<void> onPaywallView({
    required MBAdaptyPaywall paywall,
    Function()? customViewTrackerEvent,
  });

  Future<void> onGetAllPaywalls();

  /// This method is used to get a paywall by its [placementId].
  /// If [remoteConfigModel] is not provided, it will use the default [MBRemoteConfig] model.
  ///
  /// If you want to use the value of [state.configuration.getCachedPaywallIfAvailable] to determine whether to fetch the paywall do not set [useCachedPaywall]. Otherwise you can set [useCachedPaywall] to override the configuration value. If you did not set the [getCachedPaywallIfAvailable] in the configuration and [useCachedPaywall] parameter, it will fetch the paywall.
  ///
  /// If you want to handle the error that occurs while fetching the paywall, you can use the [onPaywallLoadError] callback.
  ///
  /// Returns the paywall if it is fetched successfully, otherwise it will return null.
  Future<MBAdaptyPaywall<T, R>?> onGetPaywall({
    required String placementId,
    T? remoteConfigModel,
    bool? useCachedPaywall,
    Function()? onPaywallLoadError,
  });

  Future<void> updateAndGetProfile({
    Function(MBAdaptyProfile)? onProfileUpdateSuccess,
    Function()? onProfileUpdateError,
  });
}
