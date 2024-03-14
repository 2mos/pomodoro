import 'package:flutter/material.dart';
import 'package:pomodoro/pomodoro_page.dart';
import 'package:pomodoro/settings_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = PomodoroPage();
      case 1:
        page = SettingsPage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      var screenWidth = constraints.maxWidth;
      final theme = Theme.of(context);
      final btnStyle = ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(theme.colorScheme.surface),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            // side: BorderSide(color: Colors.red)
          )));

      return Scaffold(
        body: Stack(
          children: [
            Center(
              child: Container(
                color: theme.colorScheme.primaryContainer,
                child: page,
              ),
            ),
            if (screenWidth < 600)
              Align(
                alignment: Alignment.bottomCenter,
                child: NavigationBar(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  surfaceTintColor: theme.colorScheme.primaryContainer,
                  animationDuration: Duration.zero,
                  indicatorColor: theme.colorScheme.surface,
                  indicatorShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.timer),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.edit),
                      label: 'Settings',
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                ),
              )
            else if (screenWidth >= 600)
              SafeArea(
                child: Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: IconButton(
                          style: btnStyle,
                          icon: Icon(Icons.timer_outlined),
                          onPressed: () {
                            setState(() {
                              selectedIndex = 0;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: IconButton(
                          style: btnStyle,
                          icon: Icon(Icons.settings),
                          onPressed: () {
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}
