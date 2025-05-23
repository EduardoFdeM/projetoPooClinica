package com.mack.clinica.controller;

import java.io.IOException;
import java.util.List;

import com.mack.clinica.dao.ProntuarioDAO;
import com.mack.clinica.model.Prontuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/meus_prontuarios")
public class MeusProntuariosServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    HttpSession session = request.getSession(false);

    // Verifica se o usuário está logado e é um médico
    if (session == null || session.getAttribute("tipo") == null ||
        !"medico".equalsIgnoreCase((String) session.getAttribute("tipo"))) {
      response.sendRedirect(request.getContextPath() + "/index.jsp");
      return;
    }

    String action = request.getParameter("action");
    int medicoId = (Integer) session.getAttribute("id");

    try {
      ProntuarioDAO prontuarioDAO = new ProntuarioDAO(getServletContext());

      if ("view".equals(action)) {
        // Visualizar prontuário específico
        int prontuarioId = Integer.parseInt(request.getParameter("id"));
        Prontuario prontuario = prontuarioDAO.buscarProntuarioPorId(prontuarioId);

        // Verificar se o prontuário pertence ao médico logado
        if (prontuario != null && prontuario.getMedicoId() == medicoId) {
          request.setAttribute("prontuario", prontuario);
          request.getRequestDispatcher("/visualizar_prontuario.jsp").forward(request, response);
        } else {
          response.sendRedirect(request.getContextPath() + "/meus_prontuarios?error=access_denied");
        }
        return;
      }

      // Listar todos os prontuários do médico
      List<Prontuario> prontuarios = prontuarioDAO.listarProntuariosPorMedico(medicoId);
      request.setAttribute("prontuarios", prontuarios);
      request.getRequestDispatcher("/meus_prontuarios.jsp").forward(request, response);

    } catch (Exception e) {
      System.err.println("Erro ao carregar prontuários do médico: " + e.getMessage());
      e.printStackTrace();
      response.sendRedirect(request.getContextPath() + "/medico_dashboard?error=internal_error");
    }
  }
}