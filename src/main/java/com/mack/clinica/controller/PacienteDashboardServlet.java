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

@WebServlet("/paciente_dashboard")
public class PacienteDashboardServlet extends HttpServlet {
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

            // Obter ID do paciente
            int pacienteId = (Integer) session.getAttribute("id");

            // Buscar próxima consulta do paciente
            ConsultaDAO consultaDAO = new ConsultaDAO(getServletContext());
            List<Consulta> consultas = consultaDAO.getConsultasByPacienteId(pacienteId);

            // Encontrar a próxima consulta (primeira consulta futura com status "agendada")
            Consulta proximaConsulta = null;
            if (consultas != null && !consultas.isEmpty()) {
                for (Consulta consulta : consultas) {
                    if ("agendada".equalsIgnoreCase(consulta.getStatus())) {
                        proximaConsulta = consulta;
                        break; // Considera a primeira consulta agendada como a próxima
                    }
                }
            }

            // Adicionar a próxima consulta ao request
            request.setAttribute("proximaConsulta", proximaConsulta);

            // Redireciona para o dashboard do paciente
            RequestDispatcher dispatcher = request.getRequestDispatcher("/paciente_dashboard.jsp");
            dispatcher.forward(request, response);
        } else {
            // Se não há sessão ou usuário logado, redireciona para o login
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}
