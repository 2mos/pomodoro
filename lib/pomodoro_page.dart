import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/my_app.dart';
import 'package:provider/provider.dart';

class PomodoroPage extends StatelessWidget {
  const PomodoroPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyLarge!.copyWith(
      color: theme.colorScheme.onSurface,
    );

    final btnStyle = ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(theme.colorScheme.surface),
        surfaceTintColor:
            MaterialStateProperty.all<Color>(theme.colorScheme.surface),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          // side: BorderSide(color: Colors.red)
        )));

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Center(
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TopRow(
                    appState: appState,
                    icon: icon,
                    textStyle: textStyle,
                    btnStyle: btnStyle,
                    screenWidth: constraints.maxWidth),
              ),
              SizedBox(
                height: 6,
              ),
              BigCard(pair: pair),
              SizedBox(
                height: 6,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class TopRow extends StatelessWidget {
  const TopRow(
      {super.key,
      required this.appState,
      required this.icon,
      required this.textStyle,
      required this.btnStyle,
      required this.screenWidth});

  final MyAppState appState;
  final IconData icon;
  final TextStyle textStyle;
  final ButtonStyle btnStyle;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              appState.toggleFavorite();
            },
            style: btnStyle,
            child: Text(
              screenWidth >= 600 ? 'Pomodoro' : 'Pomo',
              style: textStyle,
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextButton(
            onPressed: () {
              appState.getNext();
            },
            style: btnStyle,
            child: Text(
              screenWidth >= 600 ? 'Short Break' : 'Short',
              style: textStyle,
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextButton(
            onPressed: () {
              appState.getNext();
            },
            style: btnStyle,
            child: Text(
              screenWidth >= 600 ? 'Long Break' : 'Long',
              style: textStyle,
            ),
          ),
        )
      ],
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayLarge!.copyWith(
      color: theme.colorScheme.onSurface,
    );

    return Card(
      color: theme.colorScheme.surface,
      surfaceTintColor: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "00:00",
              style: style,
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: OutlinedButton(
                onPressed: () {},
                // style: btnStyle,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Start',
                    // style: textStyle,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
