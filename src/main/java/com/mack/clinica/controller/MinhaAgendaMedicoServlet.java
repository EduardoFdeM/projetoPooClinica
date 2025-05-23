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

@WebServlet("/minha_agenda_medico")
public class MinhaAgendaMedicoServlet extends HttpServlet {
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
      ConsultaDAO consultaDAO = new ConsultaDAO(getServletContext());

      if ("update_status".equals(action)) {
        // Atualizar status da consulta
        int consultaId = Integer.parseInt(request.getParameter("consultaId"));
        String novoStatus = request.getParameter("status");

        if (consultaDAO.atualizarStatusConsulta(consultaId, novoStatus)) {
          response.sendRedirect(request.getContextPath() + "/minha_agenda_medico?success=status_updated");
        } else {
          response.sendRedirect(request.getContextPath() + "/minha_agenda_medico?error=update_failed");
        }
        return;
      } else {
        // Listar consultas do médico
        List<Consulta> consultas = consultaDAO.getConsultasByProfissionalId(medicoId);
        request.setAttribute("consultas", consultas);
        request.getRequestDispatcher("/minha_agenda_medico.jsp").forward(request, response);
      }

    } catch (Exception e) {
      System.err.println("Erro na agenda do médico: " + e.getMessage());
      e.printStackTrace();
      response.sendRedirect(request.getContextPath() + "/minha_agenda_medico?error=internal_error");
    }
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    doGet(request, response);
  }
}