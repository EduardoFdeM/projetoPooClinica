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

    if (session != null && session.getAttribute("usuarioLogado") != null) {
      Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

      // Para esta funcionalidade, precisamos dos dados completos do usuário, não
      // apenas o que está na sessão.
      // O objeto na sessão pode ser apenas um resumo (id, nome, tipo).
      // Vamos buscar do banco usando o ID do usuário logado.
      UsuarioDAO usuarioDAO = new UsuarioDAO(getServletContext());
      Usuario dadosCompletosUsuario = usuarioDAO.getUsuarioById(usuarioLogado.getId());

      if (dadosCompletosUsuario != null) {
        request.setAttribute("paciente", dadosCompletosUsuario);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/meu_cadastro.jsp");
        dispatcher.forward(request, response);
      } else {
        // Lidar com o caso em que o usuário não é encontrado no banco (improvável se
        // logado)
        response.sendRedirect("logout.jsp"); // Ou uma página de erro
      }
    } else {
      // Se não há sessão ou usuário logado, redireciona para o login
      response.sendRedirect("index.jsp");
    }
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    // Futuramente, este método pode ser usado para processar a edição dos dados do
    // cadastro
    doGet(request, response); // Por enquanto, apenas redireciona para o doGet
  }
}