import 'package:flutter_mb_adapty/flutter_mb_adapty.dart';
import 'package:flutter_mb_adapty/src/core/model/mb_adapty_configuration.dart';

abstract class AdaptyCubit extends BaseCubit<AdaptyState> {
  AdaptyCubit(super.initialState);

  Future<void> initAdapty(MBAdaptyConfiguration configuration);

  //void configureAdapty();

  Future<void> onMakePurchase();

  Future<void> onRestorePurchases();

  Future<void> onPaywallView();

  Future<void> onGetPaywall();

  Future<void> updateAndGetProfile();
}
