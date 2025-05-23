package com.mack.clinica.controller;

import java.io.IOException;
import java.util.List;

import com.mack.clinica.dao.ConsultaDAO;
import com.mack.clinica.model.Consulta;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/consultar_agenda")
public class ConsultarAgendaServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    HttpSession session = request.getSession(false);

    // Verifica se o usuário está logado e é um administrador
    if (session == null || session.getAttribute("tipo") == null ||
        !"admin".equalsIgnoreCase((String) session.getAttribute("tipo"))) {
      response.sendRedirect(request.getContextPath() + "/index.jsp");
      return;
    }

    ConsultaDAO consultaDAO = new ConsultaDAO(getServletContext());

    try {
      // Buscar todas as consultas
      List<Consulta> consultas = consultaDAO.listarTodasConsultas();
      request.setAttribute("consultas", consultas);

      // Forward para a página JSP
      request.getRequestDispatcher("/consultar_agenda.jsp").forward(request, response);

    } catch (Exception e) {
      System.err.println("Erro no ConsultarAgendaServlet: " + e.getMessage());
      e.printStackTrace();
      response.sendRedirect(request.getContextPath() + "/admin_dashboard?error=erro_agenda");
    }
  }
}