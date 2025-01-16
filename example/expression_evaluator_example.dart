import 'package:expression_evaluator/expression_evaluator.dart';

void main() {
  // Example usage of ExpressionEvaluator
  var variables = {
    'x': '10',
    'y': '20',
    'z': 'hello',
  };

  var evaluator = ExpressionEvaluator(variables);

  var expression1 = 'x > 5 AND y < 25'; // Should return true
  var expression2 = 'z == "world" OR x == "10"'; // Should return true
  var expression3 = 'x == 15 AND z != "hello"'; // Should return false

  print('Expression 1: $expression1 => ${evaluator.evaluate(expression1)}');
  print('Expression 2: $expression2 => ${evaluator.evaluate(expression2)}');
  print('Expression 3: $expression3 => ${evaluator.evaluate(expression3)}');
}
