import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool isPassword;
  final bool autoFocus;
  final String label;
  final Function(String)? onSubmit;
  final FocusNode? focusNode;
  final Function(String)? onChanged;

  const AppTextField({
    super.key,
    required this.controller,
    this.isPassword = false,
    this.autoFocus = false,
    required this.label,
    this.onSubmit,
    this.onChanged,
    this.focusNode,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool obscured = false;

  @override
  void initState() {
    obscured = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        TextFormField(
          onChanged: widget.onChanged,
          focusNode: widget.focusNode,
          onFieldSubmitted: widget.onSubmit,
          autofocus: widget.autoFocus,
          controller: widget.controller,
          obscureText: obscured,
          decoration: InputDecoration(
            suffixIcon: widget.isPassword
                ? InkWell(
                    onTap: () {
                      setState(() {
                        obscured = !obscured;
                      });
                    },
                    child: Icon(Icons.remove_red_eye),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
