import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
  }) : _isExpanded = false;

  const Button.expanded({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
  }) : _isExpanded = true;

  final String text;
  final Color bgColor;
  final Color textColor;

  final bool _isExpanded;

  @override
  Widget build(BuildContext context) {
    if (_isExpanded) {
      return _ExpandedWrapper(
        child: Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(45),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(45),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
            ),
          ),
        ),
      );
    }
  }
}

class _ExpandedWrapper extends StatelessWidget {
  const _ExpandedWrapper({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: child,
    );
  }
}
