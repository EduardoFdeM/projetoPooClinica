<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="java.util.List" %> <%@ page import="com.mack.clinica.model.Consulta" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <%-- Para responsividade --%>
    <title>Minha Agenda - Clínica Médica</title>
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/css/style.css"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    />
    <style>
      body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f0f4f8;
        color: #333;
        margin: 0;
        padding: 0;
      }
      .container {
        width: 90%;
        max-width: 1000px; /* Aumentado para acomodar a tabela melhor */
        margin: 20px auto;
        padding: 25px;
        background-color: #fff;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        border-radius: 12px;
      }
      h1 {
        color: #2c3e50; /* Azul mais escuro */
        text-align: center;
        margin-bottom: 25px;
        font-weight: 600;
      }
      table {
        width: 100%;
        border-collapse: separate; /* Alterado para separate para usar border-spacing */
        border-spacing: 0 8px; /* Espaçamento vertical entre as linhas */
        margin-bottom: 20px;
      }
      th,
      td {
        padding: 15px;
        text-align: left;
        border-bottom: 1px solid #ecf0f1; /* Linha sutil abaixo de cada célula */
      }
      th {
        background-color: #3498db; /* Azul mais vibrante */
        color: white;
        font-weight: 600;
        text-transform: uppercase;
        font-size: 0.9em;
        letter-spacing: 0.5px;
      }
      /* Arredondar cantos da primeira e última th */
      th:first-child {
        border-top-left-radius: 8px;
      }
      th:last-child {
        border-top-right-radius: 8px;
      }
      /* Arredondar cantos da última td de cada linha */
      tr td:first-child {
        border-bottom-left-radius: 8px;
      }
      tr td:last-child {
        border-bottom-right-radius: 8px;
      }
      tr:last-child td {
        border-bottom: none; /* Remove a borda da última linha */
      }

      td {
        background-color: #fdfdfe;
      }
      .status-agendada {
        color: #2980b9; /* Azul para agendada */
        font-weight: bold;
      }
      .status-realizada {
        color: #27ae60; /* Verde para realizada */
        font-weight: bold;
      }
      .status-cancelada {
        color: #c0392b; /* Vermelho para cancelada */
        font-weight: bold;
      }
      .no-appointments {
        text-align: center;
        font-size: 1.1em;
        color: #7f8c8d; /* Cinza */
        padding: 20px;
        background-color: #f9fafb;
        border-radius: 8px;
      }
      .back-link-container {
        text-align: center; /* Centraliza o botão de voltar */
        margin-bottom: 20px;
      }
      .back-link {
        display: inline-block;
        padding: 10px 18px;
        background-color: #3498db;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        font-size: 0.95em;
        transition: background-color 0.2s ease-in-out;
      }
      .back-link:hover {
        background-color: #2980b9;
      }

      /* Mensagem de sucesso */
      .success-message {
        background-color: #d4edda;
        color: #155724;
        padding: 15px;
        border-radius: 8px;
        margin-bottom: 20px;
        text-align: center;
        display: flex;
        align-items: center;
        justify-content: center;
      }

      .success-message i {
        margin-right: 10px;
        font-size: 20px;
      }

      /* Tabela de consultas */
      .consultas-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        margin-bottom: 25px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
      }

      .consultas-table th {
        background-color: #3498db;
        color: white;
        font-weight: 600;
        padding: 15px;
        text-align: left;
        text-transform: uppercase;
        font-size: 0.9em;
        letter-spacing: 0.5px;
      }

      .consultas-table th:first-child {
        border-top-left-radius: 8px;
      }

      .consultas-table th:last-child {
        border-top-right-radius: 8px;
      }

      .consultas-table td {
        padding: 15px;
        border-bottom: 1px solid #eee;
        background-color: #fdfdfe;
        vertical-align: top;
      }

      .consultas-table tr:hover td {
        background-color: #f8fafc;
      }

      .consultas-table tr:last-child td {
        border-bottom: none;
      }

      .status-agendada {
        display: inline-block;
        background-color: #e3f2fd;
        color: #0d47a1;
        padding: 5px 10px;
        border-radius: 15px;
        font-weight: 600;
        font-size: 0.85em;
        border: 1px solid #bbdefb;
      }

      .status-realizada {
        display: inline-block;
        background-color: #e8f5e9;
        color: #1b5e20;
        padding: 5px 10px;
        border-radius: 15px;
        font-weight: 600;
        font-size: 0.85em;
        border: 1px solid #c8e6c9;
      }

      .status-cancelada {
        display: inline-block;
        background-color: #ffebee;
        color: #b71c1c;
        padding: 5px 10px;
        border-radius: 15px;
        font-weight: 600;
        font-size: 0.85em;
        border: 1px solid #ffcdd2;
      }

      .observacoes-cell {
        max-width: 250px;
        white-space: pre-line;
      }

      .data-hora-cell {
        white-space: nowrap;
        font-weight: 500;
      }

      .medico-cell {
        font-weight: 500;
      }

      /* Sem consultas */
      .no-appointments {
        text-align: center;
        padding: 30px 20px;
        background-color: #f8f9fa;
        border-radius: 8px;
        margin-bottom: 25px;
        border: 1px dashed #dee2e6;
      }

      .no-appointments i {
        font-size: 48px;
        color: #adb5bd;
        margin-bottom: 15px;
        display: block;
      }

      .no-appointments p {
        font-size: 18px;
        color: #6c757d;
        margin-bottom: 20px;
      }

      /* Botões */
      .buttons-container {
        display: flex;
        justify-content: center;
        gap: 15px;
        margin-top: 25px;
      }

      .btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 12px 24px;
        background-color: #3498db;
        color: white;
        text-decoration: none;
        border-radius: 6px;
        font-weight: 500;
        transition: all 0.2s;
        border: none;
        cursor: pointer;
      }

      .btn i {
        margin-right: 8px;
      }

      .btn:hover {
        background-color: #2980b9;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      }

      .btn-secondary {
        background-color: #7f8c8d;
      }

      .btn-secondary:hover {
        background-color: #6c7a7d;
      }

      .btn-success {
        background-color: #27ae60;
      }

      .btn-success:hover {
        background-color: #219955;
      }

      /* Responsividade para a tabela */
      @media screen and (max-width: 768px) {
        .consultas-table,
        .consultas-table thead,
        .consultas-table tbody,
        .consultas-table th,
        .consultas-table td,
        .consultas-table tr {
          display: block;
        }

        .consultas-table thead tr {
          position: absolute;
          top: -9999px;
          left: -9999px;
        }

        .consultas-table tr {
          border: 1px solid #ddd;
          border-radius: 8px;
          margin-bottom: 15px;
          background-color: #fff;
          box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .consultas-table td {
          border: none;
          border-bottom: 1px solid #eee;
          position: relative;
          padding-left: 130px;
          min-height: 30px;
          text-align: left;
          background-color: transparent;
        }

        .consultas-table td:last-child {
          border-bottom: none;
        }

        .consultas-table td::before {
          position: absolute;
          top: 15px;
          left: 15px;
          width: 110px;
          padding-right: 10px;
          white-space: nowrap;
          font-weight: 600;
          color: #3498db;
          content: attr(data-label);
        }

        .observacoes-cell {
          max-width: none;
        }

        .buttons-container {
          flex-direction: column;
          gap: 10px;
        }

        .btn {
          width: 100%;
        }
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/jspf/menu_paciente.jspf" />

    <div class="container">
      <h1><i class="fas fa-calendar-alt"></i> Minha Agenda de Consultas</h1>

      <c:if test="${param.success != null && param.success == 'agendamento'}">
        <div class="success-message">
          <i class="fas fa-check-circle"></i> Sua consulta foi agendada com
          sucesso!
        </div>
      </c:if>

      <c:choose>
        <c:when test="${not empty consultas}">
          <table class="consultas-table">
            <thead>
              <tr>
                <th>Data/Hora</th>
                <th>Médico</th>
                <th>Status</th>
                <th>Observações</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="consulta" items="${consultas}">
                <tr>
                  <td data-label="Data/Hora" class="data-hora-cell">
                    <i
                      class="fas fa-clock"
                      style="color: #3498db; margin-right: 5px"
                    ></i>
                    <c:out value="${consulta.getFormattedDataHora()}" />
                  </td>
                  <td data-label="Médico" class="medico-cell">
                    <i
                      class="fas fa-user-md"
                      style="color: #3498db; margin-right: 5px"
                    ></i>
                    <c:out value="${consulta.nomeProfissional}" />
                  </td>
                  <td data-label="Status">
                    <span class="status-${consulta.status.toLowerCase()}">
                      <c:choose>
                        <c:when test="${consulta.status == 'agendada'}">
                          <i class="fas fa-calendar-check"></i>
                        </c:when>
                        <c:when test="${consulta.status == 'realizada'}">
                          <i class="fas fa-check-circle"></i>
                        </c:when>
                        <c:when test="${consulta.status == 'cancelada'}">
                          <i class="fas fa-times-circle"></i>
                        </c:when>
                      </c:choose>
                      <c:out value="${consulta.status}" />
                    </span>
                  </td>
                  <td data-label="Observações" class="observacoes-cell">
                    <c:choose>
                      <c:when test="${not empty consulta.observacoes}">
                        <c:out value="${consulta.observacoes}" />
                      </c:when>
                      <c:otherwise>
                        <em style="color: #7f8c8d">Sem observações</em>
                      </c:otherwise>
                    </c:choose>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </c:when>
        <c:otherwise>
          <div class="no-appointments">
            <i class="fas fa-calendar-xmark"></i>
            <p>Você ainda não possui nenhuma consulta agendada.</p>
            <a
              href="${pageContext.request.contextPath}/agendarConsulta"
              class="btn btn-success"
            >
              <i class="fas fa-plus-circle"></i> Agendar Consulta
            </a>
          </div>
        </c:otherwise>
      </c:choose>

      <div class="buttons-container">
        <a
          href="${pageContext.request.contextPath}/paciente_dashboard"
          class="btn btn-secondary"
        >
          <i class="fas fa-arrow-left"></i> Voltar ao Painel
        </a>

        <c:if test="${not empty consultas}">
          <a
            href="${pageContext.request.contextPath}/agendarConsulta"
            class="btn btn-success"
          >
            <i class="fas fa-plus-circle"></i> Agendar Nova Consulta
          </a>
        </c:if>
      </div>
    </div>
  </body>
</html>
