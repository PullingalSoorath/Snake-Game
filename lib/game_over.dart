import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:snakegame/game_screen.dart';

class GameOver extends StatefulWidget {
  const GameOver({Key? key, required this.score}) : super(key: key);

  final int score;

  @override
  State<GameOver> createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  bool _showgameover = true;
  bool _showpop = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 4000), () {
      setState(() {
        _showgameover = false;
      });
    });
    Future.delayed(const Duration(milliseconds: 6000), () {
      setState(() {
        _showpop = true;
      });
    });

    super.initState();
  }

  swipeback() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[900]
              : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: const Text('Quit game'),
          content: const Text('Are you sure want to quit the game'),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text('Quit'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameScreen(),
                      ));
                },
                child: const Text('Restart'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return swipeback();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    AnimatedCrossFade(
                      firstChild: LottieBuilder.asset(
                          'assets/lottie/Animation1699638319825.json'),
                      secondChild: Container(
                          color: Theme.of(context).colorScheme.background,
                          alignment: Alignment.center,
                          height: 500,
                          width: 800,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'You have scored ${widget.score - 5}',
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'HindBold',
                                ),
                              ),
                              if (_showpop)
                                AnimatedContainer(
                                  duration: const Duration(seconds: 8),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const GameScreen(),
                                              ),
                                              (route) => false);
                                        },
                                        child: const Text('Restart'),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          SystemNavigator.pop();
                                        },
                                        child: const Text('Quit'),
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          )),
                      firstCurve: Curves.easeOut,
                      crossFadeState: _showgameover
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: const Duration(seconds: 1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


