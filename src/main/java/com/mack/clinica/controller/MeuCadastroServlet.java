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

@WebServlet("/meu_cadastro") // Define a URL que acionará este servlet
public class MeuCadastroServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    HttpSession session = request.getSession(false); // Pega a sessão existente, não cria uma nova

    // Verificar se existe uma sessão e se o usuário está logado (verificando id e
    // tipo)
    if (session != null && session.getAttribute("id") != null && session.getAttribute("tipo") != null) {
      // Verifica se o usuário é um paciente
      String tipoUsuario = (String) session.getAttribute("tipo");
      if (!"paciente".equalsIgnoreCase(tipoUsuario)) {
        response.sendRedirect(request.getContextPath() + "/logout.jsp");
        return;
      }

      // Obter o ID do usuário da sessão
      int idUsuario = (Integer) session.getAttribute("id");

      // Verificar se é uma solicitação para o formulário de edição
      String action = request.getParameter("action");

      // Buscar dados completos do paciente
      UsuarioDAO usuarioDAO = new UsuarioDAO(getServletContext());
      Usuario dadosCompletosUsuario = usuarioDAO.getUsuarioById(idUsuario);

      if (dadosCompletosUsuario != null) {
        request.setAttribute("paciente", dadosCompletosUsuario);

        // Se a ação for editar, mostrar o formulário de edição
        if ("edit".equals(action)) {
          RequestDispatcher dispatcher = request.getRequestDispatcher("/editar_cadastro.jsp");
          dispatcher.forward(request, response);
        } else {
          // Caso contrário, mostrar a visualização padrão
          RequestDispatcher dispatcher = request.getRequestDispatcher("/meu_cadastro.jsp");
          dispatcher.forward(request, response);
        }
      } else {
        // Lidar com o caso em que o usuário não é encontrado no banco (improvável se
        // logado)
        response.sendRedirect(request.getContextPath() + "/logout.jsp"); // Ou uma página de erro
      }
    } else {
      // Se não há sessão ou usuário logado, redireciona para o login
      response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    HttpSession session = request.getSession(false);

    // Verificar autenticação
    if (session == null || session.getAttribute("id") == null || session.getAttribute("tipo") == null) {
      response.sendRedirect(request.getContextPath() + "/index.jsp");
      return;
    }

    // Verificar se é paciente
    String tipoUsuario = (String) session.getAttribute("tipo");
    if (!"paciente".equalsIgnoreCase(tipoUsuario)) {
      response.sendRedirect(request.getContextPath() + "/logout.jsp");
      return;
    }

    // Obter o ID do usuário da sessão
    int idUsuario = (Integer) session.getAttribute("id");

    // Buscar dados atuais do paciente
    UsuarioDAO usuarioDAO = new UsuarioDAO(getServletContext());
    Usuario pacienteAtual = usuarioDAO.getUsuarioById(idUsuario);

    if (pacienteAtual == null) {
      response.sendRedirect(request.getContextPath() + "/logout.jsp");
      return;
    }

    // Obter os dados do formulário
    String nome = request.getParameter("nome");
    String email = request.getParameter("email");
    String celular = request.getParameter("celular");
    String dataNascimento = request.getParameter("dataNascimento");

    // Validar campos obrigatórios
    if (nome == null || nome.trim().isEmpty() || email == null || email.trim().isEmpty()) {
      request.setAttribute("erro", "nome_email_obrigatorios");
      request.setAttribute("paciente", pacienteAtual);
      RequestDispatcher dispatcher = request.getRequestDispatcher("/editar_cadastro.jsp");
      dispatcher.forward(request, response);
      return;
    }

    // Verificar se o email já está em uso por outro paciente
    if (!email.equals(pacienteAtual.getEmail()) && usuarioDAO.emailJaExiste(email, idUsuario)) {
      request.setAttribute("erro", "email_existente");
      request.setAttribute("paciente", pacienteAtual);
      RequestDispatcher dispatcher = request.getRequestDispatcher("/editar_cadastro.jsp");
      dispatcher.forward(request, response);
      return;
    }

    // Atualizar os dados do paciente
    pacienteAtual.setNome(nome);
    pacienteAtual.setEmail(email);
    pacienteAtual.setCelular(celular);

    // Atualizar data de nascimento
    if (dataNascimento != null && !dataNascimento.trim().isEmpty()) {
      pacienteAtual.setDataNascimentoFromString(dataNascimento);
    } else {
      pacienteAtual.setDataNascimento(null);
    }

    // Salvar as alterações
    boolean atualizacaoBemSucedida = usuarioDAO.atualizarDadosPaciente(pacienteAtual);

    if (atualizacaoBemSucedida) {
      // Atualizar nome na sessão
      session.setAttribute("nome", nome);
      // Redirecionar com mensagem de sucesso
      response.sendRedirect(request.getContextPath() + "/meu_cadastro?success=update");
    } else {
      // Em caso de erro, voltar para o formulário de edição
      request.setAttribute("erro", "falha_atualizacao");
      request.setAttribute("paciente", pacienteAtual);
      RequestDispatcher dispatcher = request.getRequestDispatcher("/editar_cadastro.jsp");
      dispatcher.forward(request, response);
    }
  }
}