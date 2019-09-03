import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/constants.dart';
import 'package:todo_list/pages/add_new.dart';

void main() {
  test('empty name returns error string', () {
    final result = TaskNameFieldValidator.validate('');
    expect(result, validateTaskNameEmpty);
  });

  test('non-empty name with < 5 length returns error string', () {
    final result = TaskNameFieldValidator.validate('task');
    expect(result, validateTaskNameLength);
  });

  test('non-empty name with > 5 length returns null', () {
    final result = TaskNameFieldValidator.validate('task name');
    expect(result, null);
  });

  test('empty desc returns error string', () {
    final result = TaskDescFieldValidator.validate('');
    expect(result, validateTaskDescEmpty);
  });

  test('non-empty desc with < 10 length returns error string', () {
    final result = TaskDescFieldValidator.validate('task');
    expect(result, validateTaskDescLength);
  });

  test('non-empty name with > 10 length returns null', () {
    final result = TaskDescFieldValidator.validate('task description');
    expect(result, null);
  });
}
