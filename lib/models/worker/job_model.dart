class JobModel {
  final String id;
  final String title;
  final String company;
  final String location;
  final String modality; // Presencial, Híbrido, Home Office
  final String type; // CLT, PJ, Estágio
  final String salary;
  final String postedAt;
  final int matchPercentage;
  final String description;
  final List<String> requirements;
  final List<String> benefits;
  bool isSaved;

  JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.modality,
    required this.type,
    required this.salary,
    required this.postedAt,
    required this.matchPercentage,
    required this.description,
    required this.requirements,
    required this.benefits,
    this.isSaved = false,
  });

  static List<JobModel> mockJobs() {
    return [
      JobModel(
        id: '1',
        title: 'Desenvolvedor Flutter Pleno',
        company: 'Tech Solutions RN',
        location: 'Extremoz, RN',
        modality: 'Híbrido',
        type: 'CLT',
        salary: 'R\$ 4.500 - R\$ 6.000',
        postedAt: 'Há 2 horas',
        matchPercentage: 98,
        description: 'Estamos buscando um Desenvolvedor Flutter Pleno apaixonado por criar experiências móveis incríveis. Você fará parte de um time ágil, trabalhando em projetos de impacto para a região.',
        requirements: [
          'Experiência comprovada de 2+ anos com Flutter/Dart',
          'Conhecimento em gerência de estado (Bloc, Provider, ou Riverpod)',
          'Familiaridade com consumo de APIs REST e Firebase',
          'Ensino superior completo ou cursando em TI',
        ],
        benefits: [
          'Plano de Saúde e Odontológico',
          'Vale Alimentação (R\$ 800/mês)',
          'Auxílio Home Office',
          'Gympass',
        ],
        isSaved: true,
      ),
      JobModel(
        id: '2',
        title: 'Auxiliar Administrativo',
        company: 'Grupo Litoral',
        location: 'Centro, Extremoz',
        modality: 'Presencial',
        type: 'CLT',
        salary: 'R\$ 1.800',
        postedAt: 'Há 5 horas',
        matchPercentage: 85,
        description: 'Oportunidade para Auxiliar Administrativo com foco em organização de documentos, atendimento ao público e suporte ao departamento financeiro.',
        requirements: [
          'Ensino Médio Completo',
          'Conhecimento no Pacote Office (Excel, Word)',
          'Boa comunicação e organização',
          'Experiência prévia de 6 meses na função',
        ],
        benefits: [
          'Vale Transporte',
          'Vale Refeição',
          'Plano Odontológico',
        ],
      ),
      JobModel(
        id: '3',
        title: 'Designer Gráfico Júnior',
        company: 'Agência Criativa',
        location: 'Natal, RN',
        modality: 'Home Office',
        type: 'PJ',
        salary: 'R\$ 2.500',
        postedAt: 'Ontem',
        matchPercentage: 72,
        description: 'Procuramos um Designer Júnior criativo para ajudar na criação de peças para redes sociais, banners e identidades visuais de nossos clientes.',
        requirements: [
          'Domínio de Adobe Illustrator e Photoshop',
          'Noções de Figma e UI/UX',
          'Portfólio atualizado',
          'Proatividade e cumprimento de prazos',
        ],
        benefits: [
          'Horário Flexível',
          'Bônus por produtividade',
        ],
      ),
      JobModel(
        id: '4',
        title: 'Atendente de Loja',
        company: 'Varejo Extremoz',
        location: 'Pitangui, Extremoz',
        modality: 'Presencial',
        type: 'CLT',
        salary: 'R\$ 1.412',
        postedAt: 'Há 2 dias',
        matchPercentage: 60,
        description: 'Vaga para atendente de loja de roupas. Responsável por recepcionar clientes, organizar prateleiras e auxiliar no caixa.',
        requirements: [
          'Ensino Médio Completo',
          'Disponibilidade para trabalhar aos finais de semana (escala)',
          'Não exigimos experiência anterior',
        ],
        benefits: [
          'Vale Transporte',
          'Comissão por metas de vendas da loja',
        ],
      ),
    ];
  }
}
