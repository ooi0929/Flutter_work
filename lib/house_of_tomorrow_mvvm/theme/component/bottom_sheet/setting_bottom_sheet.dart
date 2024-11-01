import 'package:flutter/material.dart';
import 'package:flutter_workspace/house_of_tomorrow_mvvm/src/service/theme_service.dart';
import 'package:provider/provider.dart';

import '../../../src/service/lang_service.dart';
import '../../../util/helper/intl_helper.dart';
import '../../../util/lang/generated/l10n.dart';
import '../tile.dart';
import 'base_bottom_sheet.dart';

class SettingBottomSheet extends StatelessWidget {
  const SettingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = context.theme.brightness == Brightness.light;
    final LangService langService = context.watch();
    return BaseBottomSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Theme Tile
          Tile(
            icon: isLightTheme ? 'sunny' : 'moon',
            title: S.current.theme,
            subtitle: isLightTheme ? S.current.light : S.current.dark,
            onPressed: context.read<ThemeService>().toggleTheme,
          ),

          // Lang Tile
          Tile(
            icon: 'language',
            title: S.current.language,
            subtitle: IntlHelper.isKo ? S.current.ko : S.current.en,
            onPressed: langService.toggleLang,
          ),
        ],
      ),
    );
  }
}
