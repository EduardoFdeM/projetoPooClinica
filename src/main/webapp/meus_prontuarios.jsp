<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Meus Prontuários - Clínica Médica</title>
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
        background: linear-gradient(135deg, #e74c3c, #c0392b);
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
      .no-records {
        text-align: center;
        padding: 40px;
        background-color: #f8f9fa;
        border-radius: 8px;
        color: #6c757d;
      }
      .no-records i {
        font-size: 3rem;
        margin-bottom: 15px;
        color: #bbb;
      }
      .btn {
        display: inline-block;
        padding: 6px 12px;
        font-size: 0.9rem;
        text-decoration: none;
        border-radius: 4px;
        border: none;
        cursor: pointer;
        transition: all 0.2s;
      }
      .btn-primary {
        background-color: #007bff;
        color: white;
      }
      .btn-primary:hover {
        background-color: #0056b3;
      }
      .btn-sm {
        padding: 4px 8px;
        font-size: 0.8rem;
      }
      .truncate {
        max-width: 200px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
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
        .truncate {
          max-width: none;
          white-space: normal;
        }
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/jspf/menu_medico.jspf" />

    <div class="container">
      <h1><i class="fas fa-file-medical"></i> Meus Prontuários</h1>

      <!-- Alertas de Erro -->
      <c:if test="${param.error != null}">
        <div class="alert alert-danger">
          <c:choose>
            <c:when test="${param.error == 'access_denied'}">
              Acesso negado. Você só pode visualizar seus próprios prontuários.
            </c:when>
            <c:when test="${param.error == 'internal_error'}">
              Erro interno do sistema. Tente novamente.
            </c:when>
            <c:otherwise> Ocorreu um erro. Tente novamente. </c:otherwise>
          </c:choose>
        </div>
      </c:if>

      <!-- Estatísticas -->
      <div class="stats-row">
        <div class="stat-card">
          <span class="stat-number">${prontuarios.size()}</span>
          <span class="stat-label">Prontuários Criados</span>
        </div>
      </div>

      <c:choose>
        <c:when test="${empty prontuarios}">
          <div class="no-records">
            <i class="fas fa-file-medical"></i>
            <h3>Nenhum prontuário encontrado</h3>
            <p>Você ainda não criou nenhum prontuário médico.</p>
          </div>
        </c:when>
        <c:otherwise>
          <table>
            <thead>
              <tr>
                <th>Data da Consulta</th>
                <th>Paciente</th>
                <th>Diagnóstico</th>
                <th>Ações</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="prontuario" items="${prontuarios}">
                <tr>
                  <td data-label="Data da Consulta:">
                    ${prontuario.dataHoraCompleta}
                  </td>
                  <td data-label="Paciente:">${prontuario.nomePaciente}</td>
                  <td data-label="Diagnóstico:">
                    <div
                      class="truncate"
                      title="${prontuario.hipoteseDiagnostica}"
                    >
                      ${not empty prontuario.hipoteseDiagnostica ?
                      prontuario.hipoteseDiagnostica : '-'}
                    </div>
                  </td>
                  <td data-label="Ações:">
                    <a
                      href="${pageContext.request.contextPath}/meus_prontuarios?action=view&id=${prontuario.id}"
                      class="btn btn-primary btn-sm"
                      title="Visualizar"
                    >
                      <i class="fas fa-eye"></i> Ver
                    </a>
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
