import 'package:flutter/material.dart';
import 'package:quiz_app/models/question_model.dart';

class ScorePage extends StatelessWidget {
  final int score;
  final void Function()? onTap;
  const ScorePage({super.key, required this.score, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Quiz Completed!'),
        const SizedBox(
          height: 8,
        ),
        Text('Score: $score/${questionsWithAnswers.length}'),
        TextButton(
          onPressed: onTap,
          child: const Text('Reset'),
        ),
      ],
    );
  }
}
