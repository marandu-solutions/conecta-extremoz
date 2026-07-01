class CourseModel {
  final String id;
  final String title;
  final String provider;
  final String format; // Online, Presencial
  final String duration;
  final String description;
  final String imageUrl;
  final bool isAvailable;

  CourseModel({
    required this.id,
    required this.title,
    required this.provider,
    required this.format,
    required this.duration,
    required this.description,
    required this.imageUrl,
    this.isAvailable = true,
  });

  static List<CourseModel> mockCourses() {
    return [
      CourseModel(
        id: '1',
        title: 'Informática Básica e Digitação',
        provider: 'Secretaria de Trabalho - Extremoz',
        format: 'Presencial',
        duration: '40h',
        description: 'Aprenda os conceitos básicos de informática, navegação na internet, pacote Office (Word, Excel) e melhore sua digitação para o mercado de trabalho.',
        imageUrl: 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      ),
      CourseModel(
        id: '2',
        title: 'Atendimento ao Cliente',
        provider: 'SEBRAE',
        format: 'Online',
        duration: '20h',
        description: 'Descubra as melhores técnicas para encantar clientes, resolver conflitos e se destacar no comércio varejista e de serviços.',
        imageUrl: 'https://images.unsplash.com/photo-1556745753-b2904692b3cd?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      ),
      CourseModel(
        id: '3',
        title: 'Marketing Pessoal e Entrevistas',
        provider: 'Prefeitura de Extremoz',
        format: 'Híbrido',
        duration: '15h',
        description: 'Saiba como construir uma imagem profissional forte, elaborar um currículo atraente e como se comportar nas entrevistas de emprego.',
        imageUrl: 'https://images.unsplash.com/photo-1573164713988-8665fc963095?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      ),
      CourseModel(
        id: '4',
        title: 'Manutenção de Computadores',
        provider: 'SENAI',
        format: 'Presencial',
        duration: '60h',
        description: 'Curso técnico focado na montagem e manutenção de microcomputadores, identificação de falhas e instalação de sistemas operacionais.',
        imageUrl: 'https://images.unsplash.com/photo-1597872200969-2b65d56bd16b?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
        isAvailable: false,
      ),
    ];
  }
}

class EmployabilityTip {
  final String id;
  final String title;
  final String summary;
  final String readTime;
  final String category;

  EmployabilityTip({
    required this.id,
    required this.title,
    required this.summary,
    required this.readTime,
    required this.category,
  });

  static List<EmployabilityTip> mockTips() {
    return [
      EmployabilityTip(
        id: '1',
        title: 'O que colocar (e não colocar) no seu currículo',
        summary: 'Aprenda a destacar suas melhores habilidades e evitar informações que possam atrapalhar a sua seleção.',
        readTime: '3 min',
        category: 'Currículo',
      ),
      EmployabilityTip(
        id: '2',
        title: 'Como controlar a ansiedade na entrevista',
        summary: 'Dicas práticas de respiração e postura para passar segurança e confiança para o recrutador.',
        readTime: '5 min',
        category: 'Comportamento',
      ),
      EmployabilityTip(
        id: '3',
        title: 'A importância das Soft Skills',
        summary: 'Empresas valorizam comunicação e empatia tanto quanto conhecimento técnico. Entenda o porquê.',
        readTime: '4 min',
        category: 'Mercado',
      ),
    ];
  }
}
