enum NotificationType { alert, message, system, job }

class NotificationModel {
  final String id;
  final String title;
  final String content;
  final String time;
  final NotificationType type;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.content,
    required this.time,
    required this.type,
    this.isRead = false,
  });

  static List<NotificationModel> mock() {
    return [
      NotificationModel(
        id: '1',
        title: 'Entrevista Agendada!',
        content: 'Você tem uma entrevista amanhã às 14h para a vaga de Recepcionista na Clínica Sorriso.',
        time: 'Há 2 horas',
        type: NotificationType.alert,
      ),
      NotificationModel(
        id: '2',
        title: 'Nova mensagem do RH',
        content: 'Olá! Gostaríamos de solicitar que você anexe seu portfólio na sua candidatura.',
        time: 'Há 5 horas',
        type: NotificationType.message,
      ),
      NotificationModel(
        id: '3',
        title: 'Novas vagas na sua área',
        content: 'Encontramos 3 novas oportunidades que dão match com o seu perfil. Venha conferir!',
        time: 'Ontem',
        type: NotificationType.job,
        isRead: true,
      ),
      NotificationModel(
        id: '4',
        title: 'Bem-vindo ao Conecta!',
        content: 'Seu cadastro foi realizado com sucesso. Complete seu currículo para começar a se candidatar.',
        time: 'Há 3 dias',
        type: NotificationType.system,
        isRead: true,
      ),
    ];
  }
}
