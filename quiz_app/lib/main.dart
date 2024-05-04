import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int questionIndex = 0;
  bool showScore = false;
  int score = 0;

  List<Map<String, dynamic>> questionsWithAnswers = [
    {
      'question': 'What\'s your favorite color?',
      'answers': ['Red', 'Blue', 'Green', 'Black'],
      'correctAnswer': 'Red',
    },
    {
      'question': 'What\'s your favorite animal?',
      'answers': ['Dog', 'Cat', 'Elephant', 'Lion'],
      'correctAnswer': 'Dog',
    },
    {
      'question': 'What\'s your favorite food?',
      'answers': ['Pizza', 'Burger', 'Pasta', 'Sandwich'],
      'correctAnswer': 'Pizza',
    },
    {
      'question': 'What\'s your favorite movie?',
      'answers': ['Titanic', 'Avatar', 'Inception', 'Interstellar'],
      'correctAnswer': 'Avatar',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz App'),
        ),
        body: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
            child: !showScore
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        questionsWithAnswers[questionIndex]['question'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children: (questionsWithAnswers[questionIndex]
                                ['answers'] as List<String>)
                            .map(
                              (answer) => SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (answer ==
                                          questionsWithAnswers[questionIndex]
                                              ['correctAnswer']) {
                                        setState(() {
                                          score++;
                                        });
                                      }
                                      if (questionIndex <
                                          questionsWithAnswers.length - 1) {
                                        setState(() {
                                          questionIndex++;
                                        });
                                      } else {
                                        setState(() {
                                          showScore = true;
                                        });
                                      }
                                      debugPrint('Index: $questionIndex');
                                    },
                                    child: Text(answer),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Quiz Completed!'),
                      const SizedBox(
                        height: 8,
                      ),
                      Text('Score: $score/${questionsWithAnswers.length}'),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            questionIndex = 0;
                            score = 0;
                            showScore = false;
                          });
                        },
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
