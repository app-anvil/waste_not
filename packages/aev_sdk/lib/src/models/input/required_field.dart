import 'package:formz/formz.dart';

/// Validation errors for the [RequiredField] [FormzInput].
class RequiredInputValidationError {
  ///
  RequiredInputValidationError(this.message);

  /// Indicates the failure message.
  final String message;
}

/// {@template required_input}
/// Form input for a required input.
/// {@endtemplate}
class RequiredField extends FormzInput<String, RequiredInputValidationError> {
  /// {@macro required_input}
  const RequiredField.pure() : super.pure('');

  /// {@macro required_input}
  const RequiredField.dirty([super.value = '']) : super.dirty();

  @override
  RequiredInputValidationError? validator(String? value) {
    return value != null && value.isNotEmpty
        ? null
        : RequiredInputValidationError('This field is required');
  }
}
