package com.mack.clinica.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.mack.clinica.dao.ConsultaDAO;
import com.mack.clinica.dao.UsuarioDAO;
import com.mack.clinica.model.Consulta;
import com.mack.clinica.model.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/meus_pacientes")
public class MeusPacientesServlet extends HttpServlet {
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

    try {
      ConsultaDAO consultaDAO = new ConsultaDAO(getServletContext());
      UsuarioDAO usuarioDAO = new UsuarioDAO(getServletContext());

      // Buscar todas as consultas do médico
      List<Consulta> consultas = consultaDAO.getConsultasByProfissionalId(medicoId);

      System.out.println("DEBUG: Total de consultas do médico = " + (consultas != null ? consultas.size() : "null"));

      // Extrair IDs únicos dos pacientes
      Set<Integer> pacienteIds = new HashSet<>();
      for (Consulta consulta : consultas) {
        pacienteIds.add(consulta.getPacienteId());
      }

      System.out.println("DEBUG: Pacientes únicos encontrados = " + pacienteIds.size());

      // Buscar dados completos dos pacientes
      List<Usuario> pacientesAtendidos = new ArrayList<>();
      for (Integer pacienteId : pacienteIds) {
        Usuario paciente = usuarioDAO.getUsuarioById(pacienteId);
        if (paciente != null && "paciente".equals(paciente.getTipo())) {
          pacientesAtendidos.add(paciente);
        }
      }

      // Adicionar informações de quantas consultas cada paciente tem com este médico
      for (Usuario paciente : pacientesAtendidos) {
        int totalConsultas = 0;
        for (Consulta consulta : consultas) {
          if (consulta.getPacienteId() == paciente.getId()) {
            totalConsultas++;
          }
        }
        // Usar um campo temporário para armazenar essa informação
        String celularOriginal = paciente.getCelular() != null ? paciente.getCelular() : "";
        paciente.setCelular(celularOriginal + "|" + totalConsultas);
      }

      request.setAttribute("pacientesAtendidos", pacientesAtendidos);
      request.getRequestDispatcher("/meus_pacientes.jsp").forward(request, response);

    } catch (Exception e) {
      System.err.println("Erro ao carregar pacientes do médico: " + e.getMessage());
      e.printStackTrace();
      response.sendRedirect(request.getContextPath() + "/medico_dashboard?error=internal_error");
    }
  }
}