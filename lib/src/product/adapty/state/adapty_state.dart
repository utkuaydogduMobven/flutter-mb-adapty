import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mb_adapty/src/core/model/mb_adapty_configuration.dart';
import 'package:flutter_mb_adapty/src/core/model/mb_adapty_placements.dart';
import 'package:mb_adapty_core/mb_adapty_core.dart';

@immutable
class AdaptyState<T extends IMBAdaptyRemoteConfig<T>,
        R extends IMBAdaptyProductConfig<R, T>> extends Equatable
    with EquatableMixin {
  final MBAdaptyConfiguration? configuration;
  final List<MBAdaptyPlacement<T, R>>? placements;
  final MBAdaptyProfile? adaptyProfile;
  final List<MBAdaptyPaywall> viewedPaywallStack;

  AdaptyState({
    this.configuration,
    this.placements,
    this.adaptyProfile,
    this.viewedPaywallStack = const [],
  });

  @override
  List<Object?> get props => [
        placements,
        adaptyProfile,
        configuration,
        viewedPaywallStack,
      ];

  AdaptyState copyWith({
    MBAdaptyConfiguration? configuration,
    List<MBAdaptyPlacement<T, R>>? placements,
    MBAdaptyProfile? adaptyProfile,
    List<MBAdaptyPaywall>? viewedPaywallStack,
  }) {
    return AdaptyState<T, R>(
      configuration: configuration ?? this.configuration,
      placements: placements ?? this.placements,
      adaptyProfile: adaptyProfile ?? this.adaptyProfile,
      viewedPaywallStack: viewedPaywallStack ?? this.viewedPaywallStack,
    );
  }
}
