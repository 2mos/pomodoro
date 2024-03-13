import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro/my_app.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class PomodoroPage extends StatelessWidget {
  const PomodoroPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return LayoutBuilder(builder: (context, constraints) {
      return Center(
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BigCard(
                pair: pair,
                appState: appState,
                screenWidth: constraints.maxWidth,
                screenHeight: constraints.maxHeight,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class TopRow extends StatelessWidget {
  const TopRow({super.key, required this.appState, required this.screenWidth});

  final MyAppState appState;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.bodyLarge!.copyWith(
      color: theme.colorScheme.primary,

      fontFamily: GoogleFonts.jetBrainsMono().fontFamily,
      // fontWeight: FontWeight.bold,
    );
    final btnStyle = ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(theme.colorScheme.surface),
        surfaceTintColor:
            MaterialStateProperty.all<Color>(theme.colorScheme.surface),
        // shadowColor: MaterialStateProperty.all<Color>(Colors.black),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          // side: BorderSide(color: Colors.red)
        )));

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
              style: style,
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
              style: style,
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
              style: style,
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
    required this.appState,
    required this.screenWidth,
    required this.screenHeight,
  });

  final WordPair pair;
  final MyAppState appState;
  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayLarge!.copyWith(
        color: theme.colorScheme.onSurface,
        fontFamily: GoogleFonts.jetBrainsMono().fontFamily,
        fontSize: screenWidth >= 600 && screenHeight >= 500 ? 100 : 60
        // fontWeight: FontWeight.bold,
        );
    final btnStyle = ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(theme.colorScheme.primary),
        surfaceTintColor:
            MaterialStateProperty.all<Color>(theme.colorScheme.primary),
        shadowColor: MaterialStateProperty.all<Color>(Colors.black),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          // side: BorderSide(color: Colors.red)
        )));

    return Card(
      color: theme.colorScheme.surface,
      surfaceTintColor: theme.colorScheme.surface,
      child: Padding(
        padding: screenWidth >= 600 && screenHeight >= 500
            ? const EdgeInsets.all(40)
            : const EdgeInsets.all(20),
        child: Column(
          children: [
            TopRow(appState: appState, screenWidth: screenWidth),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Text(
                "90:00",
                style: style,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(shape: CircleBorder()),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("#1"),
                      )),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: btnStyle,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('START',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontFamily:
                                  GoogleFonts.jetBrainsMono().fontFamily,
                            )),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    // style: btnStyle,
                    icon: Icon(Icons.skip_next),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
