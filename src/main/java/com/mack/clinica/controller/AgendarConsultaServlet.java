package com.mack.clinica.controller;

import java.io.IOException;
import java.util.List;

import com.mack.clinica.model.AgendarConsultaDAO;
import com.mack.clinica.model.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/agendarConsulta")
public class AgendarConsultaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Verificar se o usuário está logado e é paciente
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null ||
                session.getAttribute("tipo") == null ||
                !"paciente".equalsIgnoreCase((String) session.getAttribute("tipo"))) {

            // Redirecionar para login se não for paciente ou não estiver logado
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // Instancia o DAO passando o ServletContext
        AgendarConsultaDAO dao = new AgendarConsultaDAO(getServletContext());
        // Busca a lista de médicos
        List<Usuario> medicos = dao.listarMedicos();
        System.out.println("Médicos encontrados: " + (medicos != null ? medicos.size() : 0));
        // Atribui a lista no request para ser usada no JSP
        request.setAttribute("medicos", medicos);
        // Encaminha para a página de agendamento
        request.getRequestDispatcher("/agendar_consulta.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Verificar se o usuário está logado e é paciente
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("id") == null ||
                    session.getAttribute("tipo") == null ||
                    !"paciente".equalsIgnoreCase((String) session.getAttribute("tipo"))) {

                // Redirecionar para login se não for paciente ou não estiver logado
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }

            // Pega dados do formulário
            int profissionalId = Integer.parseInt(request.getParameter("profissionalId"));
            String dataHora = request.getParameter("dataHora");
            String observacoes = request.getParameter("observacoes");

            // Pega o paciente_id da sessão
            int pacienteId = (Integer) session.getAttribute("id");

            System.out.println("Paciente ID: " + pacienteId);
            System.out.println("Profissional ID: " + profissionalId);
            System.out.println("Data e Hora: " + dataHora);
            System.out.println("Observações: " + (observacoes != null ? observacoes : "Não fornecidas"));

            AgendarConsultaDAO dao = new AgendarConsultaDAO(getServletContext());

            // Agenda a consulta com as observações
            boolean sucesso = dao.agendarConsulta(pacienteId, profissionalId, dataHora, observacoes);

            if (sucesso) {
                // Redirecionar para a agenda com mensagem de sucesso
                response.sendRedirect(request.getContextPath() + "/minha_agenda?success=agendamento");
            } else {
                // Redirecionar com mensagem de erro
                response.sendRedirect(request.getContextPath() + "/agendarConsulta?error=falha");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/paciente_dashboard.jsp?error=erro_inesperado");
        }
    }
}
