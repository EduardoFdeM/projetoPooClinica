<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Meus Pacientes - Clínica Médica</title>
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
        margin: 0;
        padding: 0;
        color: #333;
      }
      .container {
        width: 90%;
        max-width: 1200px;
        margin: 20px auto;
        padding: 20px;
        background: white;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      }
      h1 {
        color: #2c3e50;
        margin-bottom: 20px;
        font-weight: 600;
        text-align: center;
      }
      .alert {
        padding: 12px 15px;
        margin-bottom: 20px;
        border-radius: 5px;
        font-weight: 500;
      }
      .alert-danger {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
      }
      .stats-row {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
      }
      .stat-card {
        background: linear-gradient(135deg, #27ae60, #2ecc71);
        color: white;
        padding: 20px;
        border-radius: 8px;
        text-align: center;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      }
      .stat-number {
        font-size: 2rem;
        font-weight: bold;
        display: block;
      }
      .stat-label {
        font-size: 0.9rem;
        opacity: 0.9;
        margin-top: 5px;
      }
      table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
        background-color: white;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
      }
      th,
      td {
        padding: 12px 15px;
        text-align: left;
        border-bottom: 1px solid #e9ecef;
      }
      th {
        background-color: #f8f9fa;
        font-weight: 600;
        color: #495057;
      }
      tr:hover {
        background-color: #f8f9fa;
      }
      .no-patients {
        text-align: center;
        padding: 40px;
        background-color: #f8f9fa;
        border-radius: 8px;
        color: #6c757d;
      }
      .no-patients i {
        font-size: 3rem;
        margin-bottom: 15px;
        color: #bbb;
      }
      .prontuarios-count {
        background-color: #e3f2fd;
        color: #1976d2;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 500;
      }

      /* Responsividade */
      @media screen and (max-width: 768px) {
        .stats-row {
          grid-template-columns: 1fr;
        }
        table,
        thead,
        tbody,
        th,
        td,
        tr {
          display: block;
        }
        thead tr {
          position: absolute;
          top: -9999px;
          left: -9999px;
        }
        tr {
          border: 1px solid #ddd;
          margin-bottom: 10px;
          border-radius: 5px;
          overflow: hidden;
        }
        td {
          border: none;
          border-bottom: 1px solid #eee;
          position: relative;
          padding-left: 50%;
          white-space: normal;
          text-align: right;
        }
        td:before {
          position: absolute;
          top: 12px;
          left: 10px;
          width: 45%;
          padding-right: 10px;
          white-space: nowrap;
          text-align: left;
          font-weight: bold;
          content: attr(data-label);
        }
        td:last-child {
          border-bottom: 0;
        }
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/jspf/menu_medico.jspf" />

    <div class="container">
      <h1><i class="fas fa-users"></i> Meus Pacientes</h1>

      <!-- Alertas de Erro -->
      <c:if test="${param.error != null}">
        <div class="alert alert-danger">
          <c:choose>
            <c:when test="${param.error == 'erro_carregar_pacientes'}">
              Erro ao carregar lista de pacientes.
            </c:when>
            <c:otherwise> Ocorreu um erro. Tente novamente. </c:otherwise>
          </c:choose>
        </div>
      </c:if>

      <!-- Estatísticas -->
      <div class="stats-row">
        <div class="stat-card">
          <span class="stat-number">${pacientesAtendidos.size()}</span>
          <span class="stat-label">Pacientes Atendidos</span>
        </div>
      </div>

      <c:choose>
        <c:when test="${empty pacientesAtendidos}">
          <div class="no-patients">
            <i class="fas fa-user-injured"></i>
            <h3>Nenhum paciente atendido</h3>
            <p>
              Você ainda não atendeu nenhum paciente ou não criou prontuários.
            </p>
          </div>
        </c:when>
        <c:otherwise>
          <table>
            <thead>
              <tr>
                <th>Nome</th>
                <th>Email</th>
                <th>CPF</th>
                <th>Telefone</th>
                <th>Consultas</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="paciente" items="${pacientesAtendidos}">
                <c:set var="celularInfo" value="${paciente.celular}" />
                <c:set
                  var="celularParts"
                  value="${fn:split(celularInfo, '|')}"
                />
                <c:set var="celularReal" value="${celularParts[0]}" />
                <c:set var="totalConsultas" value="${celularParts[1]}" />

                <tr>
                  <td data-label="Nome:">${paciente.nome}</td>
                  <td data-label="Email:">${paciente.email}</td>
                  <td data-label="CPF:">${paciente.cpf}</td>
                  <td data-label="Telefone:">
                    ${not empty celularReal and celularReal != 'null' ?
                    celularReal : '-'}
                  </td>
                  <td data-label="Consultas:">
                    <span class="prontuarios-count">
                      ${totalConsultas} consulta${totalConsultas == '1' ? '' :
                      's'}
                    </span>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </c:otherwise>
      </c:choose>
    </div>
  </body>
</html>
