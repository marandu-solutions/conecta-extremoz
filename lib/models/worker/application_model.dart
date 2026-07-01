enum ApplicationStep { sent, review, interview, offer, rejected }

class ApplicationTimelineEvent {
  final ApplicationStep step;
  final String title;
  final String date;
  final String? description;

  ApplicationTimelineEvent({
    required this.step,
    required this.title,
    required this.date,
    this.description,
  });
}

class ApplicationModel {
  final String id;
  final String jobTitle;
  final String company;
  final String location;
  final String appliedAt;
  final ApplicationStep currentStep;
  final List<ApplicationTimelineEvent> timeline;

  ApplicationModel({
    required this.id,
    required this.jobTitle,
    required this.company,
    required this.location,
    required this.appliedAt,
    required this.currentStep,
    required this.timeline,
  });

  static List<ApplicationModel> mockApplications() {
    return [
      ApplicationModel(
        id: '1',
        jobTitle: 'Recepcionista',
        company: 'Clínica Sorriso',
        location: 'Centro, Extremoz',
        appliedAt: '10/07/2026',
        currentStep: ApplicationStep.interview,
        timeline: [
          ApplicationTimelineEvent(
            step: ApplicationStep.sent,
            title: 'Currículo Enviado',
            date: '10/07/2026',
            description: 'Sua candidatura foi recebida pelo sistema.',
          ),
          ApplicationTimelineEvent(
            step: ApplicationStep.review,
            title: 'Em Análise',
            date: '12/07/2026',
            description: 'O RH está analisando seu perfil.',
          ),
          ApplicationTimelineEvent(
            step: ApplicationStep.interview,
            title: 'Entrevista Agendada',
            date: '15/07/2026 às 14h',
            description: 'Compareça à recepção principal. Procure por Mariana.',
          ),
        ],
      ),
      ApplicationModel(
        id: '2',
        jobTitle: 'Estoquista',
        company: 'Supermercado Central',
        location: 'Pitangui, Extremoz',
        appliedAt: '12/07/2026',
        currentStep: ApplicationStep.review,
        timeline: [
          ApplicationTimelineEvent(
            step: ApplicationStep.sent,
            title: 'Currículo Enviado',
            date: '12/07/2026',
          ),
          ApplicationTimelineEvent(
            step: ApplicationStep.review,
            title: 'Em Análise pelo RH',
            date: '13/07/2026',
            description: 'Seu perfil está sob avaliação do gerente da loja.',
          ),
        ],
      ),
      ApplicationModel(
        id: '3',
        jobTitle: 'Auxiliar Administrativo',
        company: 'Grupo Litoral',
        location: 'Centro, Extremoz',
        appliedAt: '05/07/2026',
        currentStep: ApplicationStep.rejected,
        timeline: [
          ApplicationTimelineEvent(
            step: ApplicationStep.sent,
            title: 'Currículo Enviado',
            date: '05/07/2026',
          ),
          ApplicationTimelineEvent(
            step: ApplicationStep.review,
            title: 'Em Análise',
            date: '06/07/2026',
          ),
          ApplicationTimelineEvent(
            step: ApplicationStep.rejected,
            title: 'Processo Finalizado',
            date: '10/07/2026',
            description:
                'Agradecemos seu interesse, mas optamos por seguir com outro candidato no momento. Seu currículo ficará em nosso banco de talentos.',
          ),
        ],
      ),
      ApplicationModel(
        id: '4',
        jobTitle: 'Vendedor',
        company: 'Loja de Calçados ABC',
        location: 'Shopping Extremoz',
        appliedAt: 'Hoje',
        currentStep: ApplicationStep.sent,
        timeline: [
          ApplicationTimelineEvent(
            step: ApplicationStep.sent,
            title: 'Currículo Enviado',
            date: 'Hoje',
            description: 'Sua candidatura foi registrada com sucesso!',
          ),
        ],
      ),
    ];
  }
}
