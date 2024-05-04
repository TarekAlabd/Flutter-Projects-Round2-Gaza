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
  String? selectedAnswer;

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
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
            child: !showScore
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      Text(
                        questionsWithAnswers[questionIndex]['question'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Answer and get points!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 60),
                      Column(
                        children: (questionsWithAnswers[questionIndex]
                                ['answers'] as List<String>)
                            .map(
                              (answer) => Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedAnswer = answer;
                                    });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      color: answer == selectedAnswer
                                          ? Colors.green
                                          : null,
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.3),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: answer == selectedAnswer
                                              ? Colors.white
                                              : null,
                                        ),
                                        const SizedBox(width: 16),
                                        Text(
                                          answer,
                                          style: TextStyle(
                                            color: answer == selectedAnswer
                                                ? Colors.white
                                                : null,
                                            fontWeight: answer == selectedAnswer
                                                ? FontWeight.bold
                                                : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (selectedAnswer != null) {
                              if (selectedAnswer ==
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
                            } else {
                              // Show a snackbar => Task 1
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Next'),
                        ),
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
                            selectedAnswer = null;
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
