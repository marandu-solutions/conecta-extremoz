class ResumeModel {
  PersonalInfo personalInfo;
  ContactInfo contactInfo;
  ProfessionalObjective objective;
  List<Experience> experiences;
  List<Education> education;
  Qualifications qualifications;
  Portfolio portfolio;

  ResumeModel({
    required this.personalInfo,
    required this.contactInfo,
    required this.objective,
    required this.experiences,
    required this.education,
    required this.qualifications,
    required this.portfolio,
  });

  static ResumeModel mock() {
    return ResumeModel(
      personalInfo: PersonalInfo(
        fullName: 'Israel Silvestre',
        cpf: '000.000.000-00',
        birthDate: '01/01/1990',
        isPcd: false,
        pcdType: '',
        socialProgram: false,
      ),
      contactInfo: ContactInfo(
        phone: '(84) 99999-9999',
        email: 'israel@marandusolutions.com',
        address: 'Rua Principal, 100',
        neighborhood: 'Centro',
      ),
      objective: ProfessionalObjective(
        areasOfInterest: ['Desenvolvimento', 'Inteligência Artificial', 'Gestão'],
        desiredJob: 'CEO & Desenvolvedor Full Stack / Especialista IA',
        availability: 'Integral',
        firstJob: false,
      ),
      experiences: [
        Experience(
          company: 'Marandu Solutions',
          role: 'CEO & Cientista / Desenvolvedor',
          startDate: '01/2020',
          endDate: '',
          isCurrent: true,
          description: 'Liderança executiva, desenvolvimento de sistemas Full Stack em Flutter e pesquisa como cientista. Especialista na criação de agentes de Inteligência Artificial e soluções de codificação agêntica (Agentic Coding) avançadas.',
        ),
      ],
      education: [
        Education(
          degree: 'Especialização em Inteligência Artificial',
          institution: 'Universidade de Tecnologia',
          courseName: 'IA e Machine Learning',
        ),
        Education(
          degree: 'Bacharelado em Ciência da Computação',
          institution: 'Universidade Federal',
          courseName: 'Ciência da Computação',
        ),
      ],
      qualifications: Qualifications(
        extraCourses: ['Especialização em Agentes de IA', 'Arquitetura Full Stack Avançada'],
        cnh: 'B',
        languages: [
          Language(name: 'Inglês', level: 'Fluente'),
        ],
        skills: ['Flutter', 'Dart', 'Desenvolvimento Full Stack', 'Agentes de IA', 'Agentic Coding', 'Liderança', 'Ciência de Dados'],
      ),
      portfolio: Portfolio(
        linkedIn: 'linkedin.com/in/joaosilva',
        externalLink: '',
      ),
    );
  }
}

class PersonalInfo {
  String fullName;
  String cpf;
  String birthDate;
  bool isPcd;
  String pcdType;
  bool socialProgram;

  PersonalInfo({
    required this.fullName,
    required this.cpf,
    required this.birthDate,
    required this.isPcd,
    required this.pcdType,
    required this.socialProgram,
  });
}

class ContactInfo {
  String phone;
  String email;
  String address;
  String neighborhood;

  ContactInfo({
    required this.phone,
    required this.email,
    required this.address,
    required this.neighborhood,
  });
}

class ProfessionalObjective {
  List<String> areasOfInterest;
  String desiredJob;
  String availability;
  bool firstJob;

  ProfessionalObjective({
    required this.areasOfInterest,
    required this.desiredJob,
    required this.availability,
    required this.firstJob,
  });
}

class Experience {
  String company;
  String role;
  String startDate;
  String endDate;
  bool isCurrent;
  String description;

  Experience({
    required this.company,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.isCurrent,
    required this.description,
  });
}

class Education {
  String degree;
  String institution;
  String courseName;

  Education({
    required this.degree,
    required this.institution,
    required this.courseName,
  });
}

class Qualifications {
  List<String> extraCourses;
  String cnh;
  List<Language> languages;
  List<String> skills;

  Qualifications({
    required this.extraCourses,
    required this.cnh,
    required this.languages,
    required this.skills,
  });
}

class Language {
  String name;
  String level;

  Language({
    required this.name,
    required this.level,
  });
}

class Portfolio {
  String linkedIn;
  String externalLink;

  Portfolio({
    required this.linkedIn,
    required this.externalLink,
  });
}
