package com.mack.clinica.controller;

import java.io.IOException;
import java.util.List;

import com.mack.clinica.dao.ConsultaDAO;
import com.mack.clinica.dao.ProntuarioDAO;
import com.mack.clinica.model.Consulta;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/medico_dashboard")
public class MedicoDashboardServlet extends HttpServlet {
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

    // Obter ID do médico
    int medicoId = (Integer) session.getAttribute("id");

    // Coleta estatísticas para o dashboard do médico
    try {
      ConsultaDAO consultaDAO = new ConsultaDAO(getServletContext());
      ProntuarioDAO prontuarioDAO = new ProntuarioDAO(getServletContext());

      // Busca todas as consultas do médico
      List<Consulta> todasConsultas = consultaDAO.getConsultasByProfissionalId(medicoId);

      System.out.println("DEBUG: Médico ID = " + medicoId);
      System.out.println(
          "DEBUG: Total de consultas encontradas = " + (todasConsultas != null ? todasConsultas.size() : "null"));

      // Conta consultas de hoje
      int consultasHoje = contarConsultasHoje(todasConsultas);
      request.setAttribute("consultasHoje", consultasHoje);

      // Conta consultas desta semana
      int consultasSemana = contarConsultasSemana(todasConsultas);
      request.setAttribute("consultasSemana", consultasSemana);

      // Total de consultas do médico
      request.setAttribute("totalConsultas", todasConsultas != null ? todasConsultas.size() : 0);

      System.out.println("DEBUG: Consultas hoje = " + consultasHoje);
      System.out.println("DEBUG: Consultas semana = " + consultasSemana);
      System.out.println("DEBUG: Total consultas = " + (todasConsultas != null ? todasConsultas.size() : 0));

    } catch (Exception e) {
      System.err.println("Erro ao carregar estatísticas do dashboard do médico: " + e.getMessage());
      e.printStackTrace();
      // Valores padrão em caso de erro
      request.setAttribute("consultasHoje", 0);
      request.setAttribute("consultasSemana", 0);
      request.setAttribute("totalConsultas", 0);
    }

    // Faz o forward para o JSP do dashboard do médico
    request.getRequestDispatcher("/medico_dashboard.jsp").forward(request, response);
  }

  private int contarConsultasHoje(List<Consulta> consultas) {
    if (consultas == null)
      return 0;

    java.time.LocalDate hoje = java.time.LocalDate.now();
    int count = 0;

    for (Consulta consulta : consultas) {
      if (consulta.getDataHora() != null &&
          consulta.getDataHora().toLocalDate().equals(hoje)) {
        count++;
      }
    }
    return count;
  }

  private int contarConsultasSemana(List<Consulta> consultas) {
    if (consultas == null)
      return 0;

    java.time.LocalDate hoje = java.time.LocalDate.now();
    java.time.LocalDate inicioSemana = hoje.minusDays(hoje.getDayOfWeek().getValue() - 1);
    java.time.LocalDate fimSemana = inicioSemana.plusDays(6);

    int count = 0;

    for (Consulta consulta : consultas) {
      if (consulta.getDataHora() != null) {
        java.time.LocalDate dataConsulta = consulta.getDataHora().toLocalDate();
        if (!dataConsulta.isBefore(inicioSemana) && !dataConsulta.isAfter(fimSemana)) {
          count++;
        }
      }
    }
    return count;
  }
}