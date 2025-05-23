package com.mack.clinica.controller;

import java.io.IOException;
import java.util.List;

import com.mack.clinica.dao.ProntuarioDAO;
import com.mack.clinica.dao.UsuarioDAO;
import com.mack.clinica.model.Prontuario;
import com.mack.clinica.model.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ficha_clinica")
public class FichaClinicaServlet extends HttpServlet {
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

    String action = request.getParameter("action");
    ProntuarioDAO prontuarioDAO = new ProntuarioDAO(getServletContext());

    try {
      if ("new".equals(action)) {
        // Carregar listas para o formulário
        UsuarioDAO usuarioDAO = new UsuarioDAO(getServletContext());
        List<Usuario> pacientes = usuarioDAO.listarPacientes();
        List<Usuario> medicos = usuarioDAO.listarMedicos();

        request.setAttribute("pacientes", pacientes);
        request.setAttribute("medicos", medicos);
        request.getRequestDispatcher("/form_prontuario.jsp").forward(request, response);

      } else if ("edit".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));
        Prontuario prontuario = prontuarioDAO.buscarProntuarioPorId(id);

        if (prontuario != null) {
          UsuarioDAO usuarioDAO = new UsuarioDAO(getServletContext());
          List<Usuario> pacientes = usuarioDAO.listarPacientes();
          List<Usuario> medicos = usuarioDAO.listarMedicos();

          request.setAttribute("prontuario", prontuario);
          request.setAttribute("pacientes", pacientes);
          request.setAttribute("medicos", medicos);
          request.getRequestDispatcher("/form_prontuario.jsp").forward(request, response);
        } else {
          response.sendRedirect(request.getContextPath() + "/ficha_clinica?error=prontuario_nao_encontrado");
        }

      } else if ("delete".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));

        if (prontuarioDAO.excluirProntuario(id)) {
          response.sendRedirect(request.getContextPath() + "/ficha_clinica?success=delete");
        } else {
          response.sendRedirect(request.getContextPath() + "/ficha_clinica?error=falha_deletar");
        }

      } else {
        // Listar todos os prontuários
        List<Prontuario> prontuarios = prontuarioDAO.listarTodosProntuarios();
        request.setAttribute("prontuarios", prontuarios);
        request.getRequestDispatcher("/ficha_clinica.jsp").forward(request, response);
      }

    } catch (Exception e) {
      System.err.println("Erro no FichaClinicaServlet: " + e.getMessage());
      e.printStackTrace();
      response.sendRedirect(request.getContextPath() + "/ficha_clinica?error=erro_interno");
    }
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    HttpSession session = request.getSession(false);

    // Verifica se o usuário está logado e é um administrador
    if (session == null || session.getAttribute("tipo") == null ||
        !"admin".equalsIgnoreCase((String) session.getAttribute("tipo"))) {
      response.sendRedirect(request.getContextPath() + "/index.jsp");
      return;
    }

    String action = request.getParameter("action");
    ProntuarioDAO prontuarioDAO = new ProntuarioDAO(getServletContext());

    try {
      if ("create".equals(action)) {
        // Criar novo prontuário
        Prontuario prontuario = new Prontuario();
        prontuario.setPacienteId(Integer.parseInt(request.getParameter("pacienteId")));
        prontuario.setMedicoId(Integer.parseInt(request.getParameter("medicoId")));
        prontuario.setDataConsulta(request.getParameter("dataConsulta"));
        prontuario.setHorarioConsulta(request.getParameter("horarioConsulta"));
        prontuario.setAnamnese(request.getParameter("anamnese"));
        prontuario.setExameFisico(request.getParameter("exameFisico"));
        prontuario.setHipoteseDiagnostica(request.getParameter("hipoteseDiagnostica"));
        prontuario.setCondutaMedica(request.getParameter("condutaMedica"));
        prontuario.setObservacoes(request.getParameter("observacoes"));

        if (prontuarioDAO.criarProntuario(prontuario)) {
          response.sendRedirect(request.getContextPath() + "/ficha_clinica?success=create");
        } else {
          response.sendRedirect(request.getContextPath() + "/ficha_clinica?action=new&error=falha_criar");
        }

      } else if ("update".equals(action)) {
        // Atualizar prontuário existente
        Prontuario prontuario = new Prontuario();
        prontuario.setId(Integer.parseInt(request.getParameter("id")));
        prontuario.setAnamnese(request.getParameter("anamnese"));
        prontuario.setExameFisico(request.getParameter("exameFisico"));
        prontuario.setHipoteseDiagnostica(request.getParameter("hipoteseDiagnostica"));
        prontuario.setCondutaMedica(request.getParameter("condutaMedica"));
        prontuario.setObservacoes(request.getParameter("observacoes"));

        if (prontuarioDAO.atualizarProntuario(prontuario)) {
          response.sendRedirect(request.getContextPath() + "/ficha_clinica?success=update");
        } else {
          response.sendRedirect(request.getContextPath() + "/ficha_clinica?action=edit&id=" +
              prontuario.getId() + "&error=falha_atualizar");
        }
      }

    } catch (Exception e) {
      System.err.println("Erro ao processar prontuário: " + e.getMessage());
      e.printStackTrace();
      response.sendRedirect(request.getContextPath() + "/ficha_clinica?error=erro_interno");
    }
  }
}