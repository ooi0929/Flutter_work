/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/arrow-left.svg
  String get arrowLeft => 'assets/icons/arrow-left.svg';

  /// File path: assets/icons/basket.svg
  String get basket => 'assets/icons/basket.svg';

  /// File path: assets/icons/check.svg
  String get check => 'assets/icons/check.svg';

  /// File path: assets/icons/chevron-right.svg
  String get chevronRight => 'assets/icons/chevron-right.svg';

  /// File path: assets/icons/close.svg
  String get close => 'assets/icons/close.svg';

  /// File path: assets/icons/language.svg
  String get language => 'assets/icons/language.svg';

  /// File path: assets/icons/minus.svg
  String get minus => 'assets/icons/minus.svg';

  /// File path: assets/icons/moon.svg
  String get moon => 'assets/icons/moon.svg';

  /// File path: assets/icons/option.svg
  String get option => 'assets/icons/option.svg';

  /// File path: assets/icons/plus.svg
  String get plus => 'assets/icons/plus.svg';

  /// File path: assets/icons/search.svg
  String get search => 'assets/icons/search.svg';

  /// File path: assets/icons/star.svg
  String get star => 'assets/icons/star.svg';

  /// File path: assets/icons/sunny.svg
  String get sunny => 'assets/icons/sunny.svg';

  /// File path: assets/icons/uncheck.svg
  String get uncheck => 'assets/icons/uncheck.svg';

  /// List of all assets
  List<String> get values => [
        arrowLeft,
        basket,
        check,
        chevronRight,
        close,
        language,
        minus,
        moon,
        option,
        plus,
        search,
        star,
        sunny,
        uncheck
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const AssetGenImage logo = AssetGenImage('assets/logo.png');

  /// List of all assets
  static List<AssetGenImage> get values => [logo];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
