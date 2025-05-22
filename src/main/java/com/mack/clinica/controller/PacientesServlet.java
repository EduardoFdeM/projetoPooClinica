package com.mack.clinica.controller;

import com.mack.clinica.dao.UsuarioDAO;
import com.mack.clinica.model.Usuario;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/pacientes")
public class PacientesServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    HttpSession session = request.getSession(false);

    // Verifica se o usuário está logado e é um administrador
    if (session == null || session.getAttribute("tipo") == null ||
        !"admin".equalsIgnoreCase((String) session.getAttribute("tipo"))) {
      response.sendRedirect(request.getContextPath() + "/index.jsp");
      return;
    }

    String action = request.getParameter("action");
    if (action == null) {
      action = "list"; // Ação padrão: listar pacientes
    }

    switch (action) {
      case "new":
        showNewForm(request, response);
        break;
      case "create":
        createPaciente(request, response);
        break;
      case "edit":
        showEditForm(request, response);
        break;
      case "update":
        updatePaciente(request, response);
        break;
      case "delete":
        deletePaciente(request, response);
        break;
      default:
        listPacientes(request, response);
        break;
    }
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    doGet(request, response);
  }

  private void listPacientes(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    UsuarioDAO usuarioDAO = new UsuarioDAO(getServletContext());
    List<Usuario> pacientes = usuarioDAO.listarPacientes();

    request.setAttribute("pacientes", pacientes);
    RequestDispatcher dispatcher = request.getRequestDispatcher("/listar_pacientes.jsp");
    dispatcher.forward(request, response);
  }

  private void showNewForm(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    RequestDispatcher dispatcher = request.getRequestDispatcher("/form_paciente.jsp");
    dispatcher.forward(request, response);
  }

  private void createPaciente(HttpServletRequest request, HttpServletResponse response)
      throws IOException {
    // Recupera os dados do formulário
    String nome = request.getParameter("nome");
    String email = request.getParameter("email");
    String cpf = request.getParameter("cpf");
    String celular = request.getParameter("celular");
    String senha = request.getParameter("senha");

    // Validação básica
    if (nome == null || nome.trim().isEmpty() ||
        email == null || email.trim().isEmpty() ||
        cpf == null || cpf.trim().isEmpty() ||
        senha == null || senha.trim().isEmpty()) {
      response.sendRedirect(request.getContextPath() + "/pacientes?action=new&error=campos_obrigatorios");
      return;
    }

    // Verifica se email ou CPF já existem
    UsuarioDAO usuarioDAO = new UsuarioDAO(getServletContext());
    if (usuarioDAO.emailOuCpfJaExiste(email, cpf, null)) {
      response.sendRedirect(request.getContextPath() + "/pacientes?action=new&error=email_cpf_existente");
      return;
    }

    // Cria o objeto Usuario e salva
    Usuario novoPaciente = new Usuario();
    novoPaciente.setNome(nome);
    novoPaciente.setEmail(email);
    novoPaciente.setCpf(cpf);
    novoPaciente.setCelular(celular);
    novoPaciente.setSenha(senha);

    int id = usuarioDAO.criarPaciente(novoPaciente);
    if (id > 0) {
      // Sucesso
      response.sendRedirect(request.getContextPath() + "/pacientes?success=create");
    } else {
      // Erro
      response.sendRedirect(request.getContextPath() + "/pacientes?action=new&error=falha_criar");
    }
  }

  private void showEditForm(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    int id = Integer.parseInt(request.getParameter("id"));
    UsuarioDAO usuarioDAO = new UsuarioDAO(getServletContext());
    Usuario paciente = usuarioDAO.getUsuarioById(id);

    // Valida se é realmente um paciente
    if (paciente == null || !"paciente".equalsIgnoreCase(paciente.getTipo())) {
      response.sendRedirect(request.getContextPath() + "/pacientes?error=paciente_nao_encontrado");
      return;
    }

    request.setAttribute("paciente", paciente);
    RequestDispatcher dispatcher = request.getRequestDispatcher("/form_paciente.jsp");
    dispatcher.forward(request, response);
  }

  private void updatePaciente(HttpServletRequest request, HttpServletResponse response)
      throws IOException {
    // Recupera os dados do formulário
    int id = Integer.parseInt(request.getParameter("id"));
    String nome = request.getParameter("nome");
    String email = request.getParameter("email");
    String cpf = request.getParameter("cpf");
    String celular = request.getParameter("celular");
    String senha = request.getParameter("senha"); // Senha é opcional na edição

    // Validação básica
    if (nome == null || nome.trim().isEmpty() ||
        email == null || email.trim().isEmpty() ||
        cpf == null || cpf.trim().isEmpty()) {
      response
          .sendRedirect(request.getContextPath() + "/pacientes?action=edit&id=" + id + "&error=campos_obrigatorios");
      return;
    }

    // Verifica se email ou CPF já existem para outro paciente
    UsuarioDAO usuarioDAO = new UsuarioDAO(getServletContext());
    if (usuarioDAO.emailOuCpfJaExiste(email, cpf, id)) {
      response
          .sendRedirect(request.getContextPath() + "/pacientes?action=edit&id=" + id + "&error=email_cpf_existente");
      return;
    }

    // Recupera o paciente atual para não perder dados que não estamos atualizando
    Usuario paciente = usuarioDAO.getUsuarioById(id);

    if (paciente == null || !"paciente".equalsIgnoreCase(paciente.getTipo())) {
      response.sendRedirect(request.getContextPath() + "/pacientes?error=paciente_nao_encontrado");
      return;
    }

    // Atualiza os dados
    paciente.setNome(nome);
    paciente.setEmail(email);
    paciente.setCpf(cpf);
    paciente.setCelular(celular);

    boolean atualizacaoBemSucedida = usuarioDAO.atualizarPaciente(paciente);

    // Se foi fornecida uma nova senha, atualiza-a separadamente
    if (senha != null && !senha.trim().isEmpty()) {
      usuarioDAO.atualizarSenhaPaciente(id, senha);
    }

    if (atualizacaoBemSucedida) {
      // Sucesso
      response.sendRedirect(request.getContextPath() + "/pacientes?success=update");
    } else {
      // Erro
      response.sendRedirect(request.getContextPath() + "/pacientes?action=edit&id=" + id + "&error=falha_atualizar");
    }
  }

  private void deletePaciente(HttpServletRequest request, HttpServletResponse response)
      throws IOException {
    int id = Integer.parseInt(request.getParameter("id"));

    UsuarioDAO usuarioDAO = new UsuarioDAO(getServletContext());
    boolean deleteBemSucedido = usuarioDAO.excluirPaciente(id);

    if (deleteBemSucedido) {
      // Sucesso
      response.sendRedirect(request.getContextPath() + "/pacientes?success=delete");
    } else {
      // Erro
      response.sendRedirect(request.getContextPath() + "/pacientes?error=falha_deletar");
    }
  }
}