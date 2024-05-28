import 'package:flutter/material.dart';
import 'package:phenikaa_campus/theme/pallete.dart';

class AuthField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final bool obscureText;
  final double rightPadding; // Add a rightPadding property

  AuthField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.prefixIconColor,
    this.obscureText = false,
    this.rightPadding = 0.0, // Set a default value for rightPadding
  }) : super(key: key);

  @override
  _AuthFieldState createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void trimText() {
    final trimmedText = widget.controller.text.trim();
    if (widget.controller.text != trimmedText) {
      widget.controller.text = trimmedText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      onEditingComplete:
          trimText, // Add this line to trim the text when editing is complete
      decoration: InputDecoration(
        filled: true,
        fillColor: Pallete.rhinoDark700,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Pallete.rhinoDark700,
            width: 3,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Pallete.rhinoDark700,
            width: 3,
          ),
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(fontSize: 18),
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: widget.prefixIconColor,
              )
            : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: togglePasswordVisibility,
              )
            : null,
      ),
    );
  }
}
