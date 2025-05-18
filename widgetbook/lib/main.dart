import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../main.directories.g.dart';

void main()
{
    runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget
{
    const WidgetbookApp({super.key});

    @override
    Widget build(BuildContext context)
    => Widgetbook.material(
        addons: <WidgetbookAddon>[
            MaterialThemeAddon(
                themes: <WidgetbookTheme<ThemeData>>[
                    WidgetbookTheme<ThemeData>(
                        name: 'Dark',
                        data: _createDefaultMaterialDarkThemeData(context)
                    ),
                    WidgetbookTheme<ThemeData>(
                        name: 'Light',
                        data: _createDefaultMaterialLightThemeData(context)
                    )
                ]
            ),
            LocalizationAddon(
                locales: <Locale>[
                    const Locale('en', 'US'),
                    const Locale('de', 'DE')
                ],
                localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                    DefaultCupertinoLocalizations.delegate,
                    DefaultMaterialLocalizations.delegate,
                    DefaultWidgetsLocalizations.delegate
                ]
            ),
            TextScaleAddon(
                divisions: 2,
                initialScale: 1,
                min: 1
            ),
            DeviceFrameAddon(
                devices: <DeviceInfo>[
                    Devices.android.samsungGalaxyS20,
                    Devices.ios.iPhone13
                ]
            )
            //GridAddon()
        ],
        directories: directories
    );
}

ThemeData _createDefaultMaterialLightThemeData(BuildContext context)
=> ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    switchTheme: Theme.of(context).switchTheme
);

ThemeData _createDefaultMaterialDarkThemeData(BuildContext context)
=> ThemeData(
    useMaterial3: false,
    brightness: Brightness.dark,
    switchTheme: Theme.of(context).switchTheme
);
