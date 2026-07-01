class DashboardData {
  final UserProfile profile;
  final DashboardMetrics metrics;
  final List<JobOffer> recommendedJobs;
  final List<ApplicationStatus> recentApplications;
  final List<CourseOffer> recommendedCourses;
  final List<AlertNotification> alerts;

  DashboardData({
    required this.profile,
    required this.metrics,
    required this.recommendedJobs,
    required this.recentApplications,
    required this.recommendedCourses,
    required this.alerts,
  });

  // Factory de Mock para UI
  factory DashboardData.mock() {
    return DashboardData(
      profile: UserProfile(
        name: 'João Silva',
        profileCompletionPercentage: 65,
        missingProfileTask:
            'Adicione uma experiência anterior para ganhar +15% de visibilidade',
      ),
      metrics: DashboardMetrics(
        availableJobs: 42,
        applicationsSent: 5,
        profileViews: 12,
        scheduledInterviews: 1,
      ),
      recommendedJobs: [
        JobOffer(
          title: 'Auxiliar Administrativo',
          company: 'Empresa X',
          location: 'Centro, Extremoz',
          salary: 'R\$ 1.500,00',
          matchPercentage: 95,
        ),
        JobOffer(
          title: 'Atendente de Loja',
          company: 'Comércio Y',
          location: 'Pitangui, Extremoz',
          salary: 'A combinar',
          matchPercentage: 88,
        ),
      ],
      recentApplications: [
        ApplicationStatus(
          jobTitle: 'Recepcionista',
          company: 'Empresa Z',
          status: ApplicationState.interview,
          date: '15/07 às 14h',
        ),
        ApplicationStatus(
          jobTitle: 'Estoquista',
          company: 'Empresa Y',
          status: ApplicationState.inAnalysis,
          date: 'Ontem',
        ),
        ApplicationStatus(
          jobTitle: 'Auxiliar de Serviços Gerais',
          company: 'Empresa X',
          status: ApplicationState.sent,
          date: 'Há 3 dias',
        ),
      ],
      recommendedCourses: [
        CourseOffer(
          title: 'Informática Básica',
          provider: 'Secretaria de Trabalho',
          status: 'Inscrições Abertas',
        ),
        CourseOffer(
          title: 'Atendimento ao Cliente',
          provider: 'SEBRAE',
          status: 'Online e Gratuito',
        ),
      ],
      alerts: [
        AlertNotification(
          title: 'Entrevista Agendada',
          message:
              'Você tem uma entrevista amanhã às 14h para a vaga de Recepcionista.',
          type: AlertType.warning,
        ),
      ],
    );
  }
}

class UserProfile {
  final String name;
  final int profileCompletionPercentage;
  final String missingProfileTask;

  UserProfile({
    required this.name,
    required this.profileCompletionPercentage,
    required this.missingProfileTask,
  });
}

class DashboardMetrics {
  final int availableJobs;
  final int applicationsSent;
  final int profileViews;
  final int scheduledInterviews;

  DashboardMetrics({
    required this.availableJobs,
    required this.applicationsSent,
    required this.profileViews,
    required this.scheduledInterviews,
  });
}

class JobOffer {
  final String title;
  final String company;
  final String location;
  final String salary;
  final int matchPercentage;

  JobOffer({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.matchPercentage,
  });
}

enum ApplicationState { sent, inAnalysis, interview, rejected, hired }

class ApplicationStatus {
  final String jobTitle;
  final String company;
  final ApplicationState status;
  final String date;

  ApplicationStatus({
    required this.jobTitle,
    required this.company,
    required this.status,
    required this.date,
  });

  String get statusText {
    switch (status) {
      case ApplicationState.sent:
        return 'Currículo Enviado';
      case ApplicationState.inAnalysis:
        return 'Em Análise pelo RH';
      case ApplicationState.interview:
        return 'Entrevista Agendada';
      case ApplicationState.rejected:
        return 'Não Selecionado';
      case ApplicationState.hired:
        return 'Contratado';
    }
  }
}

class CourseOffer {
  final String title;
  final String provider;
  final String status;

  CourseOffer({
    required this.title,
    required this.provider,
    required this.status,
  });
}

enum AlertType { info, warning, success }

class AlertNotification {
  final String title;
  final String message;
  final AlertType type;

  AlertNotification({
    required this.title,
    required this.message,
    required this.type,
  });
}
