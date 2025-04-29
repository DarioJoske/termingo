import 'package:flutter/material.dart';

class TermingoTextField extends StatelessWidget {
  const TermingoTextField({super.key, required this.labelText, required this.onChanged});

  final String labelText;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: labelText, border: OutlineInputBorder()),
      onChanged: onChanged,
    );
  }
}

class TermingoTextFormField extends StatefulWidget {
  const TermingoTextFormField({
    super.key,
    required this.labelText,
    this.validator,
    this.onSaved,
    this.onChanged,
    required this.controller,
    this.suffixIcon,
    this.obscureText,
  });

  final String labelText;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool? obscureText;

  @override
  State<TermingoTextFormField> createState() => _TermingoTextFormFieldState();
}

class _TermingoTextFormFieldState extends State<TermingoTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(),
        suffixIcon: widget.suffixIcon,
      ),
      obscureText: widget.obscureText ?? false,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
    );
  }
}
