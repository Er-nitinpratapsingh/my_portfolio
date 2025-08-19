import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/nav_item.dart'
    show ResponsiveScaffoldWrapper;
import '../widgets/navbar.dart';
import '../theme/app_theme.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();

  late FocusNode nameFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode messageFocusNode;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    messageFocusNode = FocusNode();

    nameFocusNode.addListener(() => setState(() {}));
    emailFocusNode.addListener(() => setState(() {}));
    messageFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    messageFocusNode.dispose();

    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffoldWrapper(
      body: Column(
        children: [
          const NavBar(),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.backgroundLight],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 60,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Contact Me",
                        style: AppTextStyles.heading1.copyWith(
                          color: AppColors.secondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      _buildTextFormField(
                        controller: nameController,
                        label: 'Name',
                        hint: 'Enter your name',
                        focusNode: nameFocusNode,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onChanged: (_) {
                          // This will call validate and update errors in real-time
                          if (_formKey.currentState != null) {
                            _formKey.currentState!.validate();
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildTextFormField(
                        controller: emailController,
                        label: 'Email',
                        hint: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        focusNode: emailFocusNode,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          final emailRegex = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-\/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          );
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onChanged: (_) {
                          // This will call validate and update errors in real-time
                          if (_formKey.currentState != null) {
                            _formKey.currentState!.validate();
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildTextFormField(
                        controller: messageController,
                        label: 'Message',
                        hint: 'Enter your message',
                        maxLines: 5,
                        focusNode: messageFocusNode,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a message';
                          }
                          if (value.length < 10) {
                            return 'Message must be at least 10 characters';
                          }
                          return null;
                        },
                        onChanged: (_) {
                          // This will call validate and update errors in real-time
                          if (_formKey.currentState != null) {
                            _formKey.currentState!.validate();
                          }
                        },
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            debugPrint('Name: ${nameController.text}');
                            debugPrint('Email: ${emailController.text}');
                            debugPrint('Message: ${messageController.text}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Message sent!')),
                            );
                            nameController.clear();
                            emailController.clear();
                            messageController.clear();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 6,
                          shadowColor: AppColors.secondary.withOpacity(0.6),
                        ),
                        child: const Text(
                          "Send",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    FocusNode? focusNode,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    final bool hasFocus = focusNode?.hasFocus ?? false;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      focusNode: focusNode,
      style: AppTextStyles.body.copyWith(color: Colors.black87),
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.body.copyWith(
          color: hasFocus ? AppColors.primary : AppColors.secondary,
          fontWeight: hasFocus ? FontWeight.w900 : FontWeight.bold,
        ),
        hintText: hint,
        hintStyle: AppTextStyles.body.copyWith(
          color: AppColors.secondary.withOpacity(0.6),
        ),
        errorStyle: TextStyle(
          color: Colors.redAccent[700],
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
          shadows: const [
            Shadow(
              offset: Offset(0.5, 0.5),
              blurRadius: 2,
              color: Colors.black26,
            ),
          ],
        ),
        errorMaxLines: 2,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent.shade400, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent.shade700, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary),
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),

        // Icon next to error text (optional)
        suffixIcon:
            validator != null &&
                controller.text.isNotEmpty &&
                validator(controller.text) != null
            ? const Icon(Icons.error_outline, color: Colors.redAccent)
            : null,
      ),
    );
  }
}
