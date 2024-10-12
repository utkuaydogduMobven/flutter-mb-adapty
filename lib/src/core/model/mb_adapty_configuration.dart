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

  MBAdaptyConfiguration({
    this.loadAllPlacementPaywallsOnInitialize = false,
    this.loadAdaptyProfileOnInitialize = false,
    this.logEveryPaywallView = false,
    this.getPaywallsWithProductConfigModel = false,
    this.placementIDs = const [],
    this.locale,
    this.fetchPolicy,
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
      ];

  MBAdaptyConfiguration copyWith({
    bool? loadAllPlacementPaywallsOnInitialize,
    bool? loadAdaptyProfileOnInitialize,
    bool? logEveryPaywallView,
    bool? getPaywallsWithProductConfigModel,
    List<String>? placementIDs,
    String? locale,
    AdaptyPaywallFetchPolicy? fetchPolicy,
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
    );
  }
}
