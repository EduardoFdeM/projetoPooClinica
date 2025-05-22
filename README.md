# Sistema de Gestão de Clínica Médica

Este projeto consiste em um sistema web para agendamento e gestão de consultas médicas para clínicas, desenvolvido com tecnologias Java EE, seguindo a arquitetura MVC (Model-View-Controller).

## Tecnologias Utilizadas

- **Java Servlets**: Para processamento de requisições no servidor
- **JSP (JavaServer Pages)**: Para renderização da interface do usuário
- **JSTL (JavaServer Pages Standard Tag Library)**: Para manipulação de dados nas páginas JSP
- **SQLite**: Banco de dados leve e embarcado
- **CSS**: Estilização das páginas para uma interface responsiva
- **JavaScript**: Validações no lado do cliente e melhorias de UX

## Estrutura do Projeto

O projeto segue a estrutura padrão Maven:

```
clinica/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── mack/
│       │           └── clinica/
│       │               ├── controller/   # Servlets (Controllers)
│       │               ├── dao/          # Camada de acesso a dados
│       │               ├── model/        # Classes de domínio
│       │               └── util/         # Classes utilitárias
│       ├── resources/
│       └── webapp/
│           ├── WEB-INF/
│           │   ├── jspf/                 # Fragmentos JSP (menus, etc.)
│           │   └── ...
│           ├── css/                      # Arquivos de estilo
│           ├── js/                       # Scripts JavaScript
│           └── *.jsp                     # Páginas JSP
└── pom.xml                               # Configurações do Maven
```

## Principais Componentes

### Modelos (Models)

- `Usuario.java`: Representa um usuário do sistema (administrador, paciente ou médico)
- `Consulta.java`: Representa uma consulta agendada

### Acesso a Dados (DAOs)

- `UsuarioDAO.java`: Operações de banco de dados relacionadas aos usuários
- `ConsultaDAO.java`: Operações de banco de dados relacionadas às consultas
- `AgendarConsultaDAO.java`: Operações específicas para agendamento de consultas

### Controladores (Servlets)

- `LoginServlet.java`: Controle de autenticação
- `MeuCadastroServlet.java`: Visualização e gestão de dados pessoais do paciente
- `MinhaAgendaServlet.java`: Visualização de consultas agendadas pelo paciente
- `AgendarConsultaServlet.java`: Agendamento de novas consultas
- `PacientesServlet.java`: CRUD completo de pacientes (para administradores)

### Páginas JSP (Views)

- `index.jsp`: Página inicial com login
- `paciente_dashboard.jsp`: Painel principal do paciente
- `admin_dashboard.jsp`: Painel principal do administrador
- `meu_cadastro.jsp`: Visualização dos dados cadastrais do paciente
- `minha_agenda.jsp`: Visualização das consultas agendadas pelo paciente
- `agendar_consulta.jsp`: Formulário para agendamento de consultas
- `listar_pacientes.jsp`: Lista de pacientes (para administradores)
- `form_paciente.jsp`: Formulário para criação/edição de pacientes

### Componentes Reutilizáveis

- `menu_paciente.jspf`: Menu de navegação para pacientes
- `menu_admin.jspf`: Menu de navegação para administradores

## Funcionalidades Principais

### Para Pacientes

- Login/Logout
- Visualização de dados cadastrais
- Visualização de consultas agendadas
- Agendamento de novas consultas

### Para Administradores

- Login/Logout
- Gestão completa de pacientes (CRUD)
- Visualização e gestão de consultas

### Para Médicos (Em desenvolvimento)

- Login/Logout
- Visualização de agenda de consultas
- Registro de prontuários

## Banco de Dados

O sistema utiliza SQLite com as seguintes tabelas principais:

- `usuarios`: Armazena dados de todos os usuários do sistema
- `consultas`: Armazena informações sobre as consultas agendadas
- `prontuarios`: Armazena dados dos prontuários médicos

## Instalação e Execução

1. Clone o repositório
2. Importe o projeto em sua IDE como um projeto Maven
3. Configure um servidor de aplicação (Tomcat, Jetty, etc.)
4. Execute o projeto no servidor

## Acesso ao Sistema

- **Pacientes**: Acesso por CPF/senha
- **Administradores**: Acesso por login administrativo
- **Médicos**: Acesso por credenciais médicas

---

Projeto desenvolvido como parte da disciplina de Programação Orientada a Objetos. 