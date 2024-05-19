class QuestionModel {
  final String question;
  final List<String> answers;
  final String correctAnswer;

  const QuestionModel({
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });
}

List<QuestionModel> questionsWithAnswers = const [
    QuestionModel(
      question: 'What\'s your favorite color?',
      answers: ['Red', 'Blue', 'Green', 'Black'],
      correctAnswer: 'Red',
    ),
    QuestionModel(
      question: 'What\'s your favorite animal?',
      answers: ['Dog', 'Cat', 'Elephant', 'Lion'],
      correctAnswer: 'Dog',
    ),
    QuestionModel(
      question: 'What\'s your favorite food?',
      answers: ['Pizza', 'Burger', 'Pasta', 'Sandwich'],
      correctAnswer: 'Pizza',
    ),
    QuestionModel(
      question: 'What\'s your favorite movie?',
      answers: ['Titanic', 'Avatar', 'Inception', 'Interstellar'],
      correctAnswer: 'Avatar',
    ),
  ];