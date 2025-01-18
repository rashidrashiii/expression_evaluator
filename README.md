# Expression Evaluator

A simple and flexible Dart library to evaluate dynamic expressions with support for logical operators (`AND`, `OR`) and comparison operations (`==`, `!=`, `<`, `>`, `ILIKE`, `LIKE`). This package is designed to make it easy to evaluate expressions based on variable values, and can be used for a variety of logical and mathematical evaluations.

## Features

- Supports logical operators `AND` (`&&`) and `OR` (`||`).
- Handles comparison operators: equality (`==`), inequality (`!=`), less than (`<`), greater than (`>`), and pattern matching (`LIKE`, `ILIKE`).
- Flexible expression evaluation with dynamic variables.
- Simple API for integration into your Dart projects.

## Installation

To use this package in your Dart project, add the following dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  expression_evaluator: ^1.0.6
```

## Then run:

```bash
dart pub get
```

## Usage

```bash
import 'package:expression_evaluator/expression_evaluator.dart';

void main() {
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
```
## Available Operators

- **Equality (==)**: Checks if two values are equal.
- **Inequality (!=)**: Checks if two values are not equal.
- **Less Than (<)**: Checks if the left value is less than the right value.
- **Greater Than (>)**: Checks if the left value is greater than the right value.
- **LIKE**: Pattern matching with wildcard support (% for multiple characters, _ for a single character).
- **ILIKE**: Case-insensitive pattern matching, similar to LIKE.
- **AND**: Logical operator that returns `true` if both conditions are true.
- **OR**: Logical operator that returns `true` if at least one condition is true.

## Example

You can find an example script in the example/ folder that demonstrates how to use the ExpressionEvaluator in a real-world scenario.

```bash
dart example/expression_evaluator_example.dart
```

# API

## ExpressionEvaluator(variables)
Constructs an `ExpressionEvaluator` instance with a map of variables.

### Parameters:
- `variables`: A `Map<String, String>` containing variable names and their corresponding values.

## evaluate(expression)
Evaluates an expression string and returns a boolean result.

### Parameters:
- `expression`: A string representing the logical or comparison expression.

### Returns:
- `bool`: The result of the expression evaluation.

---

# License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/rashidrashiii/expression_evaluator/blob/95ec63cbb5e70e602f43372e600fa63ec68c340e/LICENSE) file for details.

---

# Author
**Muhammed Rashid V**

- Email: rashiofficialemail@gmail.com
- LinkedIn: [Muhammed Rashid V](https://www.linkedin.com/in/muhammed-rashid-v)
- GitHub: [rashidrashiii](https://github.com/rashidrashiii)
