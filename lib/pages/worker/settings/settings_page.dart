import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:conecta/theme/app_theme.dart';

import 'components/settings_section.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isProfilePublic = true;
  bool _pushNotifications = true;
  bool _emailAlerts = false;

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Conta'),
        content: const Text(
          'Tem certeza que deseja excluir sua conta permanentemente? Esta ação não pode ser desfeita e todos os seus dados e currículos serão apagados da base da prefeitura.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              // Lógica de logout e exclusão aqui
            },
            child: const Text('Sim, Excluir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: AppTheme.surfaceColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(isDesktop ? 40.0 : 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Configurações',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ).animate().fade().slideY(begin: -0.1),
                const SizedBox(height: 8),
                Text(
                  'Gerencie sua privacidade, notificações e dados da conta.',
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 16),
                ).animate().fade().slideY(begin: -0.1),
                const SizedBox(height: 40),

                // Privacidade
                SettingsSection(
                  title: 'Privacidade e LGPD',
                  children: [
                    SettingsTile(
                      icon: Icons.visibility_outlined,
                      iconColor: AppTheme.primaryColor,
                      title: 'Perfil Público',
                      subtitle:
                          'Permitir que empresas encontrem seu currículo no banco de talentos.',
                      trailing: Switch(
                        value: _isProfilePublic,
                        activeColor: AppTheme.primaryColor,
                        onChanged: (val) {
                          setState(() {
                            _isProfilePublic = val;
                          });
                        },
                      ),
                    ),
                    SettingsTile(
                      icon: Icons.download_outlined,
                      title: 'Baixar meus dados',
                      subtitle:
                          'Solicitar uma cópia de todos os seus dados cadastrados.',
                      onTap: () {},
                    ),
                  ],
                ).animate().fade(delay: 100.ms).slideX(begin: -0.05),

                // Notificações
                SettingsSection(
                  title: 'Notificações',
                  children: [
                    SettingsTile(
                      icon: Icons.notifications_active_outlined,
                      title: 'Notificações no Celular',
                      subtitle: 'Receber alertas sobre entrevistas e vagas.',
                      trailing: Switch(
                        value: _pushNotifications,
                        activeColor: AppTheme.primaryColor,
                        onChanged: (val) {
                          setState(() {
                            _pushNotifications = val;
                          });
                        },
                      ),
                    ),
                    SettingsTile(
                      icon: Icons.email_outlined,
                      title: 'Alertas por E-mail',
                      subtitle: 'Receber resumo semanal de vagas por e-mail.',
                      trailing: Switch(
                        value: _emailAlerts,
                        activeColor: AppTheme.primaryColor,
                        onChanged: (val) {
                          setState(() {
                            _emailAlerts = val;
                          });
                        },
                      ),
                    ),
                  ],
                ).animate().fade(delay: 200.ms).slideX(begin: -0.05),

                // Segurança
                SettingsSection(
                  title: 'Segurança',
                  children: [
                    SettingsTile(
                      icon: Icons.lock_outline,
                      title: 'Alterar Senha',
                      onTap: () {},
                    ),
                    SettingsTile(
                      icon: Icons.security,
                      title: 'Autenticação em Duas Etapas',
                      subtitle: 'Adicione uma camada extra de segurança.',
                      onTap: () {},
                    ),
                  ],
                ).animate().fade(delay: 300.ms).slideX(begin: -0.05),

                // Conta
                SettingsSection(
                  title: 'Gerenciamento de Conta',
                  children: [
                    SettingsTile(
                      icon: Icons.logout,
                      title: 'Sair da Conta',
                      onTap: () {},
                    ),
                    SettingsTile(
                      icon: Icons.delete_forever_outlined,
                      title: 'Excluir Conta Permanentemente',
                      isDestructive: true,
                      onTap: _showDeleteAccountDialog,
                    ),
                  ],
                ).animate().fade(delay: 400.ms).slideX(begin: -0.05),

                const SizedBox(height: 40),
                Center(
                  child: Text(
                    'CONECTA - Versão 1.0.0\nPrefeitura Municipal de Extremoz',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.textSecondary.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ).animate().fade(delay: 600.ms),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
