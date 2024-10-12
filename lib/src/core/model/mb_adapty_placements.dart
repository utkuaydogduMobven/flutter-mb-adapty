import 'package:mb_adapty_core/mb_adapty_core.dart';

final class MBAdaptyPlacement<T extends IMBAdaptyRemoteConfig<T>,
    R extends IMBAdaptyProductConfig<R, T>> {
  final String placementId;
  MBAdaptyPaywall<T, R> paywall;

  MBAdaptyPlacement({
    required this.placementId,
    required this.paywall,
  });

  factory MBAdaptyPlacement.fromServiceMap(
    MapEntry<String, MBAdaptyPaywall<T, R>> serviceMapEntry,
  ) {
    return MBAdaptyPlacement<T, R>(
      placementId: serviceMapEntry.key,
      paywall: serviceMapEntry.value,
    );
  }

  void updatePaywall(MBAdaptyPaywall<T, R> paywall) {
    this.paywall = paywall;
  }
}
