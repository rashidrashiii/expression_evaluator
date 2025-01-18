/// A class for evaluating dynamic expressions with logical operators.
class ExpressionEvaluator {
  /// A map of variables and their values to use in expressions.
  final Map<String, String> variables;

  /// Creates an instance of [ExpressionEvaluator].
  ///
  /// [variables] is a map containing the variables and their corresponding values.
  ExpressionEvaluator(this.variables);

  /// Evaluates a dynamic expression and returns `true` or `false`.
  ///
  /// Example:
  /// ```dart
  /// final evaluator = ExpressionEvaluator({'x': '10'});
  /// final result = evaluator.evaluate('x == 10');
  /// print(result); // true
  /// ```
  bool evaluate(String expression) {
    // Replace OR and AND with || and && respectively for easier handling
    expression = expression.replaceAll('OR', '||').replaceAll('AND', '&&');

    // Split the expression by OR (`||`) operator for evaluation
    final List<String> orParts = expression.split(RegExp(r'\s*\|\|\s*'));
    bool result = false;

    for (var part in orParts) {
      // Evaluate each part and apply OR logic
      bool partResult = _evaluatePart(part);
      result = result || partResult; // Apply OR logic
    }

    return result;
  }

  /// Evaluates a sub-expression divided by the OR (`||`) operator.
  ///
  /// This method splits the sub-expression further using the AND (`&&`) operator.
  bool _evaluatePart(String part) {
    final List<String> andParts = part.split(RegExp(r'\s*\&\&\s*'));
    bool partResult = true;

    for (var andPart in andParts) {
      // If any AND part is false, the entire AND block is false
      if (!_evaluateCondition(andPart.trim())) {
        partResult = false;
        break;
      }
    }

    return partResult;
  }

  /// Evaluates an individual condition, such as `x == 10` or `name LIKE "Jo%"`.
  ///
  /// Supports various operators and delegates the evaluation to specific methods.
  bool _evaluateCondition(String condition) {
    if (condition.contains('==')) {
      return _evaluateEquality(condition);
    } else if (condition.contains('!=')) {
      return _evaluateInequality(condition);
    } else if (condition.contains('<')) {
      return _evaluateLessThan(condition);
    } else if (condition.contains('>')) {
      return _evaluateGreaterThan(condition);
    } else if (condition.contains('ILIKE')) {
      return _evaluateIlike(condition);
    } else if (condition.contains('LIKE')) {
      return _evaluateLike(condition);
    }

    return false;
  }

  /// Evaluates equality conditions like `x == 10`.
  bool _evaluateEquality(String condition) {
    var tokens = condition.split('==');
    String left = tokens[0].trim();
    String right = tokens[1].trim();

    // Handle quoted string values
    if (right.startsWith('"') && right.endsWith('"')) {
      right = right.substring(1, right.length - 1); // Remove quotes
    }

    return variables.containsKey(left) && variables[left] == right;
  }

  /// Evaluates inequality conditions like `x != 20`.
  bool _evaluateInequality(String condition) {
    var tokens = condition.split('!=');
    String left = tokens[0].trim();
    String right = tokens[1].trim();

    // Handle quoted string values
    if (right.startsWith('"') && right.endsWith('"')) {
      right = right.substring(1, right.length - 1); // Remove quotes
    }

    return variables.containsKey(left) && variables[left] != right;
  }

  /// Evaluates less-than conditions like `x < 10`.
  bool _evaluateLessThan(String condition) {
    var tokens = condition.split('<');
    String left = tokens[0].trim();
    String right = tokens[1].trim();

    if (variables.containsKey(left)) {
      var leftValue = int.tryParse(variables[left]!);
      var rightValue = int.tryParse(right);
      if (leftValue != null && rightValue != null) {
        return leftValue < rightValue;
      }
    }
    return false;
  }

  /// Evaluates greater-than conditions like `x > 5`.
  bool _evaluateGreaterThan(String condition) {
    var tokens = condition.split('>');
    String left = tokens[0].trim();
    String right = tokens[1].trim();

    if (variables.containsKey(left)) {
      var leftValue = int.tryParse(variables[left]!);
      var rightValue = int.tryParse(right);
      if (leftValue != null && rightValue != null) {
        return leftValue > rightValue;
      }
    }
    return false;
  }

  /// Evaluates pattern matching conditions with `LIKE`.
  ///
  /// Example: `name LIKE "Jo%"` matches variables that start with "Jo".
  bool _evaluateLike(String condition) {
    var tokens = condition.split('LIKE');
    String left = tokens[0].trim();
    String right = tokens[1].trim();

    // Handle quoted string values
    if (right.startsWith('"') && right.endsWith('"')) {
      right = right.substring(1, right.length - 1); // Remove quotes
    }

    // Perform LIKE pattern matching
    return _matchPattern(variables[left] ?? '', right, caseSensitive: true);
  }

  /// Evaluates case-insensitive pattern matching conditions with `ILIKE`.
  ///
  /// Example: `name ILIKE "jo%"` matches variables like "John" or "joanna".
  bool _evaluateIlike(String condition) {
    var tokens = condition.split('ILIKE');
    String left = tokens[0].trim();
    String right = tokens[1].trim();

    // Handle quoted string values
    if (right.startsWith('"') && right.endsWith('"')) {
      right = right.substring(1, right.length - 1); // Remove quotes
    }

    String leftValue = variables[left]?.toLowerCase() ?? '';
    right = right.toLowerCase();

    return _matchPattern(leftValue, right, caseSensitive: false);
  }

  /// Matches a string against a pattern, supporting `_` and `%` wildcards.
  ///
  /// - `_` matches exactly one character.
  /// - `%` matches zero or more characters.
  bool _matchPattern(String input, String pattern,
      {bool caseSensitive = true}) {
    // Normalize input and pattern if case-insensitivity is required
    if (!caseSensitive) {
      input = input.toLowerCase();
      pattern = pattern.toLowerCase();
    }

    // Convert SQL wildcards to regular expression equivalents
    pattern = pattern.replaceAll('_', '.');
    pattern = pattern.replaceAll('%', '.*');

    // Create a regular expression for pattern matching
    final regex = RegExp('^$pattern\$');
    return regex.hasMatch(input);
  }
}
