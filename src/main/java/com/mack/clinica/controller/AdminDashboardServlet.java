package com.mack.clinica.controller;

import java.io.IOException;

import com.mack.clinica.dao.UsuarioDAO;
import com.mack.clinica.dao.ConsultaDAO;
import com.mack.clinica.dao.ProntuarioDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// Mapeia para "/admin_dashboard" sem expor .jsp
@WebServlet("/admin_dashboard")
public class AdminDashboardServlet extends HttpServlet {
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

        // Coleta estatísticas para o dashboard
        try {
            UsuarioDAO usuarioDAO = new UsuarioDAO(getServletContext());
            ConsultaDAO consultaDAO = new ConsultaDAO(getServletContext());
            ProntuarioDAO prontuarioDAO = new ProntuarioDAO(getServletContext());

            // Conta total de pacientes
            int totalPacientes = usuarioDAO.listarPacientes().size();
            request.setAttribute("totalPacientes", totalPacientes);

            // Conta total de médicos
            int totalMedicos = usuarioDAO.listarMedicos().size();
            request.setAttribute("totalMedicos", totalMedicos);

            // Conta total de consultas
            int totalConsultas = consultaDAO.contarTodasConsultas();
            request.setAttribute("totalConsultas", totalConsultas);

            // Conta fichas clínicas
            int totalFichasClinicas = prontuarioDAO.contarTotalProntuarios();
            request.setAttribute("totalFichasClinicas", totalFichasClinicas);

        } catch (Exception e) {
            System.err.println("Erro ao carregar estatísticas do dashboard: " + e.getMessage());
            e.printStackTrace();
            // Valores padrão em caso de erro
            request.setAttribute("totalPacientes", 0);
            request.setAttribute("totalMedicos", 0);
            request.setAttribute("totalConsultas", 0);
            request.setAttribute("totalFichasClinicas", 0);
        }

        // Faz o forward para o JSP interno
        request.getRequestDispatcher("/admin_dashboard.jsp").forward(request, response);
    }
}
