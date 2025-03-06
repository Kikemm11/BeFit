/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'package:flutter/material.dart';

class BeFitDropDownButtonFieldWidget extends StatefulWidget {
  final String label;
  final List<dynamic> values;
  dynamic controller;
  final IconData icon;
  final void Function(String?)? onChange;
  final String? Function(String?)? validator;

  BeFitDropDownButtonFieldWidget({
    required this.label,
    required this.controller,
    required this.values,
    required this.icon,
    this.onChange,
    this.validator,
  });

  @override
  _BeFitDropDownButtonFieldWidgetState createState() =>
      _BeFitDropDownButtonFieldWidgetState();
}

class _BeFitDropDownButtonFieldWidgetState
    extends State<BeFitDropDownButtonFieldWidget> {

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(),
      ),
      items: widget.values
          .map((value) => DropdownMenuItem(
        value: value.id.toString(),
        child: Row(
          children: [
            Icon(widget.icon, color: Colors.cyan[600]),
            SizedBox(width: 8.0),
            Text(value.name),
          ],
        ),
      ))
          .toList(),
      onChanged: (value) {
        setState(() {
          widget.controller = int.tryParse(value!);
        });
        if (widget.onChange != null) {
          widget.onChange!(value);
        }
      },
      style: TextStyle(
        color: Colors.black,
        fontSize: 14.0,
      ),
      validator: widget.validator,
    );
  }
}
