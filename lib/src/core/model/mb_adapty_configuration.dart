import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:equatable/equatable.dart';

final class MBAdaptyConfiguration extends Equatable with EquatableMixin {
  final bool loadAllPlacementPaywallsOnInitialize;
  final bool loadAdaptyProfileOnInitialize;
  final bool logEveryPaywallView;
  final bool getPaywallsWithProductConfigModel;
  final List<String> placementIDs;
  final String? locale;
  final AdaptyPaywallFetchPolicy? fetchPolicy;
  final Function(Object e, String msg)? onAdaptyError;
  final bool getCachedPaywallIfAvailable;

  MBAdaptyConfiguration({
    this.loadAllPlacementPaywallsOnInitialize = false,
    this.loadAdaptyProfileOnInitialize = false,
    this.logEveryPaywallView = false,
    this.getPaywallsWithProductConfigModel = false,
    this.placementIDs = const [],
    this.locale,
    this.fetchPolicy,
    this.onAdaptyError,
    this.getCachedPaywallIfAvailable = false,
  });

  @override
  List<Object?> get props => [
        loadAllPlacementPaywallsOnInitialize,
        loadAdaptyProfileOnInitialize,
        logEveryPaywallView,
        getPaywallsWithProductConfigModel,
        placementIDs,
        locale,
        fetchPolicy,
        onAdaptyError,
        getCachedPaywallIfAvailable,
      ];

  MBAdaptyConfiguration copyWith({
    bool? loadAllPlacementPaywallsOnInitialize,
    bool? loadAdaptyProfileOnInitialize,
    bool? logEveryPaywallView,
    bool? getPaywallsWithProductConfigModel,
    List<String>? placementIDs,
    String? locale,
    AdaptyPaywallFetchPolicy? fetchPolicy,
    Function(Object e, String msg)? onAdaptyError,
    bool? getCachedPaywallIfAvailable,
  }) {
    return MBAdaptyConfiguration(
      loadAllPlacementPaywallsOnInitialize:
          loadAllPlacementPaywallsOnInitialize ??
              this.loadAllPlacementPaywallsOnInitialize,
      loadAdaptyProfileOnInitialize:
          loadAdaptyProfileOnInitialize ?? this.loadAdaptyProfileOnInitialize,
      logEveryPaywallView: logEveryPaywallView ?? this.logEveryPaywallView,
      getPaywallsWithProductConfigModel: getPaywallsWithProductConfigModel ??
          this.getPaywallsWithProductConfigModel,
      placementIDs: placementIDs ?? this.placementIDs,
      locale: locale ?? this.locale,
      fetchPolicy: fetchPolicy ?? this.fetchPolicy,
      onAdaptyError: onAdaptyError ?? this.onAdaptyError,
      getCachedPaywallIfAvailable:
          getCachedPaywallIfAvailable ?? this.getCachedPaywallIfAvailable,
    );
  }
}
