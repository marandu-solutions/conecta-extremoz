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
        fullName: 'João da Silva',
        cpf: '123.456.789-00',
        birthDate: '15/05/1990',
        isPcd: false,
        pcdType: '',
        socialProgram: true,
      ),
      contactInfo: ContactInfo(
        phone: '(84) 99999-9999',
        email: 'joao.silva@email.com',
        address: 'Rua das Flores, 123',
        neighborhood: 'Centro',
      ),
      objective: ProfessionalObjective(
        areasOfInterest: ['Comércio', 'Administrativo'],
        desiredJob: 'Auxiliar Administrativo',
        availability: 'Comercial',
        firstJob: false,
      ),
      experiences: [
        Experience(
          company: 'Supermercado Central',
          role: 'Operador de Caixa',
          startDate: '01/2020',
          endDate: '12/2023',
          isCurrent: false,
          description: 'Atendimento ao público, fechamento de caixa e organização do ambiente de trabalho.',
        ),
      ],
      education: [
        Education(
          degree: 'Ensino Médio Completo',
          institution: 'Escola Estadual de Extremoz',
          courseName: '',
        ),
      ],
      qualifications: Qualifications(
        extraCourses: ['Informática Básica (SEBRAE)', 'Atendimento ao Cliente'],
        cnh: 'B',
        languages: [
          Language(name: 'Inglês', level: 'Básico'),
        ],
        skills: ['Pacote Office', 'Comunicação', 'Trabalho em Equipe'],
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
