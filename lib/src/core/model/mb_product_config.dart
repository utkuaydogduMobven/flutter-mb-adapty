import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:mb_adapty_core/mb_adapty_core.dart';

class MBProductConfig<T extends IMBAdaptyRemoteConfig<T>>
    extends IMBAdaptyProductConfig<MBProductConfig<T>, T> {
  @override
  MBProductConfig<T>? fromConfigs(
      {required List<AdaptyPaywallProduct>? adaptyProducts,
      required T? remoteConfig}) {
    // TODO: implement fromConfigs
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
