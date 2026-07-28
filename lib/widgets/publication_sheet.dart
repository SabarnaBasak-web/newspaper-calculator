import 'package:flutter/material.dart';
import 'package:newspaper_calculator_app/database/app_database.dart';
import 'package:newspaper_calculator_app/widgets/field_label.dart';

class AddPublicationSheet extends StatefulWidget {
  const AddPublicationSheet({required this.database, this.newspaper, super.key});

  final AppDatabase database;
  final Newspaper? newspaper;

  @override
  State<AddPublicationSheet> createState() => AddPublicationSheetState();
}

class AddPublicationSheetState extends State<AddPublicationSheet> {
  static const _purple = Color(0xFF6750A4);
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _weekdayPriceController = TextEditingController();
  final _weekendPriceController = TextEditingController();
  bool _isActive = true;
  bool _isSaving = false;

  bool get _isEditing => widget.newspaper != null;

  @override
  void initState() {
    super.initState();

    final newspaper = widget.newspaper;
    if (newspaper == null) return;

    _nameController.text = newspaper.name;
    _weekdayPriceController.text = newspaper.weekdayPrice.toStringAsFixed(2);
    _weekendPriceController.text = newspaper.weekendPrice.toStringAsFixed(2);
    _isActive = newspaper.isActive;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _weekdayPriceController.dispose();
    _weekendPriceController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    final weekdayPrice = double.parse(_weekdayPriceController.text.trim());
    final weekendPrice = double.parse(_weekendPriceController.text.trim());

    try {
      final newspaper = widget.newspaper;
      final name = _nameController.text.trim();

      if (newspaper == null) {
        await widget.database.addNewspaper(
          name: name,
          weekdayPrice: weekdayPrice,
          weekendPrice: weekendPrice,
          isActive: _isActive,
        );
      } else {
        await widget.database.updateNewspaper(
          id: newspaper.id,
          name: name,
          weekdayPrice: weekdayPrice,
          weekendPrice: weekendPrice,
          isActive: _isActive,
        );
      }

      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditing
                ? 'Could not update the publication.'
                : 'Could not save the publication.',
          ),
        ),
      );
    }
  }

  InputDecoration _fieldDecoration({required String hint, Widget? prefixIcon}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: prefixIcon,
      filled: true,
      fillColor: const Color(0xFFFAF7FC),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFB8AFBA)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _purple, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  String? _validatePrice(String? value) {
    final price = double.tryParse(value?.trim() ?? '');
    return price == null || price < 0 ? 'Enter a valid price' : null;
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.9,
      ),
      child: Material(
        color: const Color(0xFFFFFBFF),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 6),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: Text(
                      _isEditing ? 'Edit Publication' : 'Add Publication',
                      style: const TextStyle(
                        color: _purple,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Flexible(
              fit: FlexFit.loose,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const FieldLabelWidget(text: 'Publication Name'),
                      TextFormField(
                        controller: _nameController,
                        textCapitalization: TextCapitalization.words,
                        decoration: _fieldDecoration(
                          hint: 'e.g., The Daily Chronicle',
                        ),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                            ? 'Enter a publication name'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      const FieldLabelWidget(text: 'Price per Delivery'),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _weekdayPriceController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              decoration: _fieldDecoration(
                                hint: 'Weekday',
                                prefixIcon: const Icon(
                                  Icons.currency_rupee,
                                  size: 18,
                                ),
                              ),
                              validator: _validatePrice,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _weekendPriceController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              decoration: _fieldDecoration(
                                hint: 'Weekend',
                                prefixIcon: const Icon(
                                  Icons.currency_rupee,
                                  size: 18,
                                ),
                              ),
                              validator: _validatePrice,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text(
                          'Set separate weekday and weekend delivery rates.',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Material(
                        color: const Color(0xFFFAF7FC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Color(0xFFB8AFBA)),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: SwitchListTile(
                          value: _isActive,
                          activeThumbColor: _purple,
                          title: const Text('Active publication'),
                          subtitle: Text(
                            _isActive
                                ? 'Included in delivery tracking'
                                : 'Excluded from delivery tracking',
                          ),
                          onChanged: (value) {
                            setState(() => _isActive = value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: bottomInset),
              child: SafeArea(
                top: false,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFFBFF),
                    border: Border(top: BorderSide(color: Color(0xFFE5E1E7))),
                  ),
                  child: FilledButton.icon(
                    onPressed: _isSaving ? null : _save,
                    style: FilledButton.styleFrom(
                      backgroundColor: _purple,
                      minimumSize: const Size.fromHeight(52),
                    ),
                    icon: _isSaving
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.check, size: 18),
                    label: Text(
                      _isSaving
                          ? 'Saving...'
                          : _isEditing
                          ? 'Update Publication'
                          : 'Save Publication',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
