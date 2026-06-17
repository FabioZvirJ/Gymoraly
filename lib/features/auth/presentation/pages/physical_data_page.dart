import 'package:flutter/material.dart';
import 'package:gymoraly/features/onboarding/pages/fitness_onboarding_intro_page.dart';
import '../controllers/auth_controller.dart';

class PhysicalDataPage extends StatefulWidget {
  final AuthController controller;
  const PhysicalDataPage({super.key, required this.controller});

  @override
  State<PhysicalDataPage> createState() => _PhysicalDataPageState();
}

class _PhysicalDataPageState extends State<PhysicalDataPage> {
  final TextEditingController _heightController = TextEditingController(
    text: '175',
  );
  final TextEditingController _weightController = TextEditingController(
    text: '70',
  );

  @override
  void initState() {
    super.initState();
    _heightController.addListener(_updateState);
    _weightController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {});
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Widget _buildSmallInput({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2196F3);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Seus Dados\nAtuais',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 40),
              _buildSmallInput(
                label: 'Altura (cm)',
                controller: _heightController,
              ),
              const SizedBox(height: 20),
              _buildSmallInput(
                label: 'Peso (kg)',
                controller: _weightController,
              ),
              const SizedBox(height: 80),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Anterior',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: widget.controller.isLoading
                          ? null
                          : () async {
                              widget.controller.model.height =
                                  double.tryParse(_heightController.text) ??
                                  0.0;
                              widget.controller.model.weight =
                                  double.tryParse(_weightController.text) ??
                                  0.0;

                              final result = await widget.controller.register();
                              if (result > 0 && context.mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FitnessOnboardingIntroPage(
                                      userName: widget.controller.model.name,
                                    ),
                                  ),
                                );
                              } else if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Erro ao criar conta.'),
                                  ),
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: widget.controller.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Cadastrar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

