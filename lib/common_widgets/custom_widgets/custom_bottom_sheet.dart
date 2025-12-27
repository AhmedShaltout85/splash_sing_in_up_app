import 'package:flutter/material.dart';
import 'package:splash_sing_in_up_app/utils/app_colors.dart';

/// A reusable bottom sheet component with multiple text fields and dropdowns
class CustomBottomSheet extends StatefulWidget {
  final String title;
  final List<FieldConfig> fields;
  final String submitButtonText;
  final Function(Map<String, String>) onSubmit;
  final VoidCallback? onCancel;

  const CustomBottomSheet({
    super.key,
    required this.title,
    required this.fields,
    this.submitButtonText = 'Submit',
    required this.onSubmit,
    this.onCancel,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();

  /// Static method to show the bottom sheet
  static Future<void> show({
    required BuildContext context,
    required String title,
    required List<FieldConfig> fields,
    String submitButtonText = 'Submit',
    required Function(Map<String, String>) onSubmit,
    VoidCallback? onCancel,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CustomBottomSheet(
        title: title,
        fields: fields,
        submitButtonText: submitButtonText,
        onSubmit: onSubmit,
        onCancel: onCancel,
      ),
    );
  }
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  late Map<String, TextEditingController> _controllers;
  late Map<String, String?> _dropdownValues;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controllers = {};
    _dropdownValues = {};

    for (var field in widget.fields) {
      if (field is TextFieldConfig) {
        _controllers[field.key] = TextEditingController(
          text: field.initialValue,
        );
      } else if (field is DropdownFieldConfig) {
        _dropdownValues[field.key] = field.initialValue;
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final values = <String, String>{};

      // Add text field values
      _controllers.forEach((key, controller) {
        values[key] = controller.text;
      });

      // Add dropdown values
      _dropdownValues.forEach((key, value) {
        if (value != null) {
          values[key] = value;
        }
      });

      widget.onSubmit(values);
      Navigator.pop(context);
    }
  }

  Widget _buildField(FieldConfig field) {
    if (field is TextFieldConfig) {
      return TextFormField(
        controller: _controllers[field.key],
        decoration: InputDecoration(
          labelText: field.label,
          hintText: field.hint,
          hintStyle: TextStyle(color: AppColors.hintColor),
          prefixIcon: field.icon != null ? Icon(field.icon) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        keyboardType: field.keyboardType,
        maxLines: field.maxLines,
        obscureText: field.obscureText,
        validator: field.validator,
      );
    } else if (field is DropdownFieldConfig) {
      return DropdownButtonFormField<String>(
        initialValue: _dropdownValues[field.key],
        decoration: InputDecoration(
          labelText: field.label,
          hintText: field.hint,
          hintStyle: TextStyle(color: AppColors.hintColor),
          prefixIcon: field.icon != null ? Icon(field.icon) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        items: field.items.map((item) {
          return DropdownMenuItem<String>(value: item, child: Text(item));
        }).toList(),
        onChanged: (value) {
          setState(() {
            _dropdownValues[field.key] = value;
          });
        },
        validator: field.validator,
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      // widget.onCancel?.call();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            // Form fields
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      for (var field in widget.fields) ...[
                        _buildField(field),
                        const SizedBox(height: 16),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            // Action buttons
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        widget.onCancel?.call();
                        // Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(widget.submitButtonText),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Base configuration for fields
abstract class FieldConfig {
  final String key;
  final String label;
  final String? hint;
  final IconData? icon;
  final String? Function(String?)? validator;

  const FieldConfig({
    required this.key,
    required this.label,
    this.hint,
    this.icon,
    this.validator,
  });
}

/// Configuration for text fields
class TextFieldConfig extends FieldConfig {
  final String? initialValue;
  final TextInputType keyboardType;
  final int maxLines;
  final bool obscureText;

  const TextFieldConfig({
    required super.key,
    required super.label,
    super.hint,
    this.initialValue,
    super.icon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.obscureText = false,
    super.validator,
  });
}

/// Configuration for dropdown fields
class DropdownFieldConfig extends FieldConfig {
  final List<String> items;
  final String? initialValue;

  const DropdownFieldConfig({
    required super.key,
    required super.label,
    required this.items,
    this.initialValue,
    super.hint,
    super.icon,
    super.validator,
  });
}

/// Example usage:
/// 
/// CustomBottomSheet.show(
///   context: context,
///   title: 'Add User',
///   fields: [

///     TextFieldConfig(
///       key: 'name',
///       label: 'Name',
///       hint: 'Enter your name',
///       icon: Icons.person,
///       validator: (value) {
///         if (value == null || value.isEmpty) {
///           return 'Please enter a name';
///         }
///         return null;
///       },
///     ),
///     DropdownFieldConfig(
///       key: 'country',
///       label: 'Country',
///       items: ['USA', 'Canada', 'UK', 'Australia'],
///       icon: Icons.public,
///       validator: (value) {
///         if (value == null || value.isEmpty) {
///           return 'Please select a country';
///         }
///         return null;
///       },
///     ),

///   ],
///   onSubmit: (values) {
///     print('Submitted values: $values');
///   },
/// );

