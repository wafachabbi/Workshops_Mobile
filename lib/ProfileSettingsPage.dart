import 'package:flutter/material.dart';
import 'models/user_model.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordCtrl = TextEditingController();
  final _newPasswordCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();

  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _addressCtrl.text = currentUser?.address ?? '';
  }

  String? _validateCurrentPassword(String? v) {
    if (v == null || v.isEmpty) return 'Current password cannot be empty';
    return null;
  }

  String? _validateNewPassword(String? v) {
    if (v == null || v.isEmpty) return 'New password cannot be empty';
    if (v.length < 4) return 'New password cannot be empty';
    return null;
  }

  String? _validateAddress(String? v) {
    if (v == null || v.trim().isEmpty) return 'Address cannot be empty';
    return null;
  }

  void _save() {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      if (currentUser != null) {
        // Verify current password
        if (_currentPasswordCtrl.text != currentUser!.password) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Mot de passe actuel incorrect')),
          );
          return;
        }
        currentUser!.password = _newPasswordCtrl.text;
        currentUser!.address = _addressCtrl.text.trim();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil mis à jour avec succès')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4F4),
      appBar: AppBar(
        title: const Text('Profile settings'),
        backgroundColor: const Color(0xFFF8F4F4),
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Form(
          key: _formKey,
          autovalidateMode:
              _submitted ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: Column(
            children: [
              // Avatar
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.transparent,
                child: Icon(Icons.account_circle, size: 100, color: Colors.deepOrange),
              ),
              const SizedBox(height: 32),

              // Current password
              _ProfileTextField(
                controller: _currentPasswordCtrl,
                hint: 'Current password',
                obscure: true,
                validator: _validateCurrentPassword,
              ),
              const SizedBox(height: 16),

              // New password
              _ProfileTextField(
                controller: _newPasswordCtrl,
                hint: 'New password',
                obscure: true,
                validator: _validateNewPassword,
              ),
              const SizedBox(height: 16),

              // Address
              _ProfileTextField(
                controller: _addressCtrl,
                hint: 'Address',
                maxLines: 3,
                validator: _validateAddress,
              ),
              const SizedBox(height: 28),

              // SAVE button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'SAVE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final int maxLines;
  final String? Function(String?)? validator;

  const _ProfileTextField({
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black38),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.black26),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.black26),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.deepOrange),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.red),
        ),
        errorStyle: const TextStyle(color: Colors.red),
      ),
    );
  }
}
