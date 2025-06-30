import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class RowDropdown extends StatelessWidget {
  final String text;
  final String? selectedValue;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;
  final double width;
  final bool isRequired;

  const RowDropdown({
    super.key,
    required this.text,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    this.width = 190,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onSurface,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: width,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: DropdownButtonFormField<String>(
              value: selectedValue,
              decoration: InputDecoration(
                filled: true,
                fillColor: colorScheme.surface,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colorScheme.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colorScheme.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: colorScheme.primary,
              ),
              dropdownColor: colorScheme.surface,
              items: items,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: isRequired
                  ? (value) => value == null
                      ? "يرجى اختيار ${text.replaceAll(':', '')}"
                      : null
                  : null,
              onChanged: onChanged,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
