import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/pages/home.dart';

import 'model/themes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  _getTheme(String theme) {
    switch (theme) {
      case 'red':
        return CustomTheme.redTheme();
        break;
      case 'yellow':
        return CustomTheme.yellowTheme();
        break;
      case 'blue':
        return CustomTheme.blueTheme();
        break;
      case 'indigo':
        return CustomTheme.indigoTheme();
        break;
      case 'green':
        return CustomTheme.greenTheme();
        break;
      case 'black':
        return CustomTheme.blackTheme();
        break;
      default:
        return CustomTheme.blackTheme();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
        defaultBrightness: Brightness.dark,
        data: (brightness) => CustomTheme.greenTheme(),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: theme,
            home: HomeView(),
          );
        });
  }
}
