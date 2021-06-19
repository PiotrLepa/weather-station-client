import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_station/core/presentation/validation/validators.dart';

class AppFormField extends StatefulWidget {
  final TextEditingController? controller;
  final PlainLocalizedString labelText;
  final TextInputType? type;
  final int? maxLength;
  final List<ValidatorFunction>? validators;
  final bool obscureText;

  const AppFormField({
    Key? key,
    required this.labelText,
    this.controller,
    this.type,
    this.maxLength,
    this.validators,
    this.obscureText = false,
  }) : super(key: key);

  @override
  AppFormFieldState createState() => AppFormFieldState();
}

class AppFormFieldState extends State<AppFormField> {
  final _formFieldKey = GlobalKey<FormFieldState>();

  var _isValid = false;

  var _value = '';

  bool get isValid => _isValid;

  String get value => _value;

  @override
  Widget build(BuildContext context) {
    final formColor = Theme.of(context).primaryColor;
    return Theme(
      data: Theme.of(context).copyWith(
        accentColor: formColor,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: formColor,
          selectionColor: formColor,
          selectionHandleColor: formColor,
        ),
      ),
      child: TextFormField(
        key: _formFieldKey,
        controller: widget.controller,
        keyboardType: widget.type,
        cursorColor: formColor,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          labelText: widget.labelText.get(context),
          border: const OutlineInputBorder(),
        ),
        obscureText: widget.obscureText,
        validator: (value) => _validate(context, _value),
        onChanged: (value) {
          _value = value;
          _isValid = _formFieldKey.currentState?.validate() ?? false;
        },
      ),
    );
  }

  bool validate() {
    return _formFieldKey.currentState?.validate() ?? false;
  }

  String? _validate(BuildContext context, String value) {
    final validators = widget.validators;
    if (validators == null) {
      return null;
    }
    for (var i = 0; i < validators.length; i++) {
      final validator = validators[i];
      final result = validator(value);
      if (result != null) {
        return result.get(context);
      }
    }
    return null;
  }
}
