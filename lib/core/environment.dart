import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../hello_flutter/hello.dart';
import '../instagram/instagram.dart';

import 'main_common.dart';

enum BuildType {
  hello,
  instagram;

  const BuildType();

  Widget build(BuildContext context) {
    switch (this) {
      case BuildType.hello:
        return Hello();
      case BuildType.instagram:
        return Instagram();
      default:
        return Container();
    }
  }
}

enum SupportOrientation {
  landscape,
  portrait,
  orientation,
}

class Environment {
  final BuildType _buildType;
  BuildType get buildType => _buildType;

  static Environment? _instance;
  static Environment get instance => _instance!;

  const Environment._internal(this._buildType);
  factory Environment.newInstance(BuildType buildType) {
    _instance ??= Environment._internal(buildType);
    return _instance!;
  }

  Future run() => mainCommon();

  // 앱에 따라서 설정을 한다.
  static SupportOrientation supportOrientation = SupportOrientation.orientation;

  static get supportedOrientation {
    if (supportOrientation == SupportOrientation.landscape) {
      if (kIsWeb || Platform.isWindows || Platform.isIOS) {
        // 저작툴 iOS 14 대응시까지...(저작툴로 인해서 한쪽 방향만 지원)
        return [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ];
      } else {
        return [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ];
      }
    } else if (supportOrientation == SupportOrientation.portrait) {
      return [
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ];
    } else {
      return [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ];
    }
  }
}
