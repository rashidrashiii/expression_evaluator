import 'package:expression_evaluator/expression_evaluator.dart';
import 'package:test/test.dart';

void main() {
  test('Evaluate simple expressions', () {
    final evaluator = ExpressionEvaluator({'x': '10', 'y': '20'});

    expect(evaluator.evaluate('x == 10'), true);
    expect(evaluator.evaluate('y > 15'), true);
    expect(evaluator.evaluate('x < 5'), false);
  });

  test('Evaluate complex expressions', () {
    final evaluator = ExpressionEvaluator({'a': 'true', 'b': 'false'});

    expect(evaluator.evaluate('a == true AND b == false'), true);
    expect(evaluator.evaluate('a == false OR b == true'), false);
  });
}
