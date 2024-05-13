/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/ic_heart_small.png
  AssetGenImage get icHeartSmall =>
      const AssetGenImage('assets/images/ic_heart_small.png');

  /// File path: assets/images/im_intro.png
  AssetGenImage get imIntro =>
      const AssetGenImage('assets/images/im_intro.png');

  /// File path: assets/images/im_money.png
  AssetGenImage get imMoney =>
      const AssetGenImage('assets/images/im_money.png');

  /// File path: assets/images/sticker1.png
  AssetGenImage get sticker1 =>
      const AssetGenImage('assets/images/sticker1.png');

  /// File path: assets/images/sticker2.png
  AssetGenImage get sticker2 =>
      const AssetGenImage('assets/images/sticker2.png');

  /// File path: assets/images/sticker3.png
  AssetGenImage get sticker3 =>
      const AssetGenImage('assets/images/sticker3.png');

  /// File path: assets/images/sticker4.png
  AssetGenImage get sticker4 =>
      const AssetGenImage('assets/images/sticker4.png');

  /// File path: assets/images/sticker5.png
  AssetGenImage get sticker5 =>
      const AssetGenImage('assets/images/sticker5.png');

  /// File path: assets/images/sticker6.png
  AssetGenImage get sticker6 =>
      const AssetGenImage('assets/images/sticker6.png');

  /// File path: assets/images/sticker7.png
  AssetGenImage get sticker7 =>
      const AssetGenImage('assets/images/sticker7.png');

  /// File path: assets/images/sticker8.png
  AssetGenImage get sticker8 =>
      const AssetGenImage('assets/images/sticker8.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        icHeartSmall,
        imIntro,
        imMoney,
        sticker1,
        sticker2,
        sticker3,
        sticker4,
        sticker5,
        sticker6,
        sticker7,
        sticker8
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
    bool gaplessPlayback = false,
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
