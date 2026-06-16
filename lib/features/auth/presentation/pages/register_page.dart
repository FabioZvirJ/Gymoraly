import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'age_page.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authControllerProvider);
    const primaryColor = Color(0xFF2196F3);

    Widget _buildInputGroup({
      required String label,
      required String hint,
      required Function(String) onChanged,
      bool isPassword = false,
      TextInputType keyboardType = TextInputType.text,
      Widget? suffixIcon,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
          const SizedBox(height: 8),
          SizedBox(
            height: 56,
            child: TextField(
              onChanged: onChanged,
              obscureText: isPassword,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                filled: true,
                fillColor: Colors.grey.shade50,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                suffixIcon: suffixIcon,
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF2196F3), width: 1.5)),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 64,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
            child: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18), padding: const EdgeInsets.only(right: 2), onPressed: () => Navigator.pop(context)),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: SizedBox(height: 80, child: Icon(Icons.fitness_center, size: 50, color: primaryColor))),
              const SizedBox(height: 30),
              const Center(child: Text('Criar Conta', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: primaryColor))),
              const SizedBox(height: 10),
              Text('Junte-se à comunidade Gymoraly', style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
              const SizedBox(height: 40),
              _buildInputGroup(label: 'Nome Completo', hint: 'Seu nome', onChanged: (value) => controller.model.name = value),
              const SizedBox(height: 20),
              _buildInputGroup(label: 'E-mail', hint: 'exemplo@email.com', keyboardType: TextInputType.emailAddress, onChanged: (value) => controller.model.email = value),
              const SizedBox(height: 20),
              _buildInputGroup(label: 'Senha', hint: 'Mínimo 6 caracteres', isPassword: !controller.isPasswordVisible, onChanged: (value) => controller.model.password = value, suffixIcon: IconButton(icon: Icon(controller.isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey, size: 20), onPressed: controller.togglePasswordVisibility)),
              const SizedBox(height: 20),
              _buildInputGroup(label: 'Confirmar Senha', hint: 'Repita sua senha', isPassword: !controller.isPasswordVisible, onChanged: (value) => controller.model.confirmPassword = value),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: controller.isLoading
                      ? null
                      : () {
                          if (controller.model.isRegisterStep1Valid) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AgePage(controller: controller)));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preencha os dados de acesso corretamente.')));
                          }
                        },
                  style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: controller.isLoading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text('Próximo', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
