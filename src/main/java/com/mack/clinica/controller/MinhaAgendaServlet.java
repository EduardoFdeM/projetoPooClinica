package com.mack.clinica.controller;

import com.mack.clinica.dao.ConsultaDAO;
import com.mack.clinica.model.Consulta;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/minha_agenda")
public class MinhaAgendaServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    HttpSession session = request.getSession(false);

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
      int pacienteId = (Integer) session.getAttribute("id");

      ConsultaDAO consultaDAO = new ConsultaDAO(getServletContext());
      List<Consulta> minhasConsultas = consultaDAO.getConsultasByPacienteId(pacienteId);

      request.setAttribute("consultas", minhasConsultas);
      RequestDispatcher dispatcher = request.getRequestDispatcher("/minha_agenda.jsp");
      dispatcher.forward(request, response);

    } else {
      // Se não há sessão ou usuário logado, redireciona para o login
      response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
  }
}