import 'package:flutter/material.dart';
import 'package:conecta/theme/app_theme.dart';
import 'package:conecta/models/worker/resume_model.dart';

class EditPersonalInfoModal extends StatefulWidget {
  final PersonalInfo initialData;
  final Function(PersonalInfo) onSave;

  const EditPersonalInfoModal({
    super.key,
    required this.initialData,
    required this.onSave,
  });

  @override
  State<EditPersonalInfoModal> createState() => _EditPersonalInfoModalState();
}

class _EditPersonalInfoModalState extends State<EditPersonalInfoModal> {
  late TextEditingController _nameController;
  late TextEditingController _cpfController;
  late TextEditingController _birthDateController;
  late TextEditingController _pcdTypeController;
  
  late bool _isPcd;
  late bool _socialProgram;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialData.fullName);
    _cpfController = TextEditingController(text: widget.initialData.cpf);
    _birthDateController = TextEditingController(text: widget.initialData.birthDate);
    _pcdTypeController = TextEditingController(text: widget.initialData.pcdType);
    _isPcd = widget.initialData.isPcd;
    _socialProgram = widget.initialData.socialProgram;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cpfController.dispose();
    _birthDateController.dispose();
    _pcdTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (_, controller) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: ListView(
                    controller: controller,
                    padding: const EdgeInsets.all(24),
                    children: [
                      _buildTextField('Nome Completo', _nameController, Icons.person_outline),
                      const SizedBox(height: 16),
                      _buildTextField('CPF', _cpfController, Icons.badge_outlined),
                      const SizedBox(height: 16),
                      _buildTextField('Data de Nascimento', _birthDateController, Icons.calendar_today),
                      const SizedBox(height: 24),
                      
                      const Divider(),
                      const SizedBox(height: 16),
                      
                      SwitchListTile(
                        title: const Text('Pessoa com Deficiência (PCD)?', style: TextStyle(fontWeight: FontWeight.w500)),
                        value: _isPcd,
                        activeColor: AppTheme.primaryColor,
                        onChanged: (val) {
                          setState(() {
                            _isPcd = val;
                          });
                        },
                      ),
                      if (_isPcd) ...[
                        const SizedBox(height: 8),
                        _buildTextField('Tipo de Deficiência', _pcdTypeController, Icons.accessible),
                      ],
                      
                      const SizedBox(height: 16),
                      SwitchListTile(
                        title: const Text('Inscrito em Programas Sociais (CadÚnico)?', style: TextStyle(fontWeight: FontWeight.w500)),
                        value: _socialProgram,
                        activeColor: AppTheme.primaryColor,
                        onChanged: (val) {
                          setState(() {
                            _socialProgram = val;
                          });
                        },
                      ),
                      
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          final newData = PersonalInfo(
                            fullName: _nameController.text,
                            cpf: _cpfController.text,
                            birthDate: _birthDateController.text,
                            isPcd: _isPcd,
                            pcdType: _pcdTypeController.text,
                            socialProgram: _socialProgram,
                          );
                          widget.onSave(newData);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Salvar Alterações', style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Editar Informações Pessoais',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppTheme.textSecondary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
      ),
    );
  }
}