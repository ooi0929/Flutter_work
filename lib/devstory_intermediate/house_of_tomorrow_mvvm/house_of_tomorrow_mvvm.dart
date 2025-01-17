import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_workspace/devstory_intermediate/house_of_tomorrow_mvvm/src/service/theme_service.dart';
import 'package:provider/provider.dart';

import 'src/service/lang_service.dart';
import 'util/lang/generated/l10n.dart';
import 'util/route_path.dart';

class HouseOfTomorrowMvvm extends StatelessWidget {
  const HouseOfTomorrowMvvm({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(builder: (context) => child!),
          ],
        );
      },
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: context.watch<LangService>().locale,
      theme: context.themeService.themeData,
      initialRoute: RoutePath.shopping,
      onGenerateRoute: RoutePath.onGenerateRoute,
    );
  }
}
