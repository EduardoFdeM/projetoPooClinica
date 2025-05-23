package com.mack.clinica.controller;

import java.io.IOException;
import java.util.List;

import com.mack.clinica.dao.UsuarioDAO;
import com.mack.clinica.model.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/medicos")
public class MedicosServlet extends HttpServlet {
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
    UsuarioDAO usuarioDAO = new UsuarioDAO(getServletContext());

    try {
      if ("new".equals(action)) {
        // Exibir formulário para novo médico
        request.getRequestDispatcher("/form_medico.jsp").forward(request, response);

      } else if ("edit".equals(action)) {
        // Editar médico existente
        int id = Integer.parseInt(request.getParameter("id"));
        Usuario medico = usuarioDAO.getUsuarioById(id);

        if (medico != null && "medico".equals(medico.getTipo())) {
          request.setAttribute("medico", medico);
          request.getRequestDispatcher("/form_medico.jsp").forward(request, response);
        } else {
          response.sendRedirect(request.getContextPath() + "/medicos?error=medico_nao_encontrado");
        }

      } else if ("delete".equals(action)) {
        // Excluir médico
        int id = Integer.parseInt(request.getParameter("id"));

        if (usuarioDAO.excluirMedico(id)) {
          response.sendRedirect(request.getContextPath() + "/medicos?success=delete");
        } else {
          response.sendRedirect(request.getContextPath() + "/medicos?error=falha_deletar");
        }

      } else {
        // Listar todos os médicos
        List<Usuario> medicos = usuarioDAO.listarMedicos();
        request.setAttribute("medicos", medicos);
        request.getRequestDispatcher("/listar_medicos.jsp").forward(request, response);
      }

    } catch (Exception e) {
      System.err.println("Erro no MedicosServlet: " + e.getMessage());
      e.printStackTrace();
      response.sendRedirect(request.getContextPath() + "/medicos?error=erro_interno");
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
    UsuarioDAO usuarioDAO = new UsuarioDAO(getServletContext());

    try {
      if ("create".equals(action)) {
        // Criar novo médico
        Usuario medico = new Usuario();
        medico.setNome(request.getParameter("nome"));
        medico.setEmail(request.getParameter("email"));
        medico.setCpf(request.getParameter("cpf"));
        medico.setCelular(request.getParameter("celular"));

        String dataNascimento = request.getParameter("dataNascimento");
        if (dataNascimento != null && !dataNascimento.trim().isEmpty()) {
          medico.setDataNascimentoFromString(dataNascimento);
        }

        medico.setSenha(request.getParameter("senha"));
        medico.setTipo("medico");

        int novoId = usuarioDAO.criarMedico(medico);
        if (novoId > 0) {
          response.sendRedirect(request.getContextPath() + "/medicos?success=create");
        } else {
          response.sendRedirect(request.getContextPath() + "/medicos?action=new&error=falha_criar");
        }

      } else if ("update".equals(action)) {
        // Atualizar médico existente
        Usuario medico = new Usuario();
        medico.setId(Integer.parseInt(request.getParameter("id")));
        medico.setNome(request.getParameter("nome"));
        medico.setEmail(request.getParameter("email"));
        medico.setCpf(request.getParameter("cpf"));
        medico.setCelular(request.getParameter("celular"));

        String dataNascimento = request.getParameter("dataNascimento");
        if (dataNascimento != null && !dataNascimento.trim().isEmpty()) {
          medico.setDataNascimentoFromString(dataNascimento);
        }

        String senha = request.getParameter("senha");
        if (senha != null && !senha.trim().isEmpty()) {
          medico.setSenha(senha);
        }

        if (usuarioDAO.atualizarMedico(medico)) {
          response.sendRedirect(request.getContextPath() + "/medicos?success=update");
        } else {
          response.sendRedirect(request.getContextPath() + "/medicos?action=edit&id=" +
              medico.getId() + "&error=falha_atualizar");
        }
      }

    } catch (Exception e) {
      System.err.println("Erro ao processar médico: " + e.getMessage());
      e.printStackTrace();
      response.sendRedirect(request.getContextPath() + "/medicos?error=erro_interno");
    }
  }
}