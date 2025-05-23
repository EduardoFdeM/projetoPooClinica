<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Consultar Agenda - Clínica Médica</title>
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
      .filters {
        background-color: #f8f9fa;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 20px;
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 15px;
      }
      .filter-group {
        display: flex;
        flex-direction: column;
      }
      .filter-group label {
        margin-bottom: 5px;
        font-weight: 500;
        color: #2c3e50;
      }
      .filter-group input,
      .filter-group select {
        padding: 8px 12px;
        border: 1px solid #ced4da;
        border-radius: 4px;
        font-size: 0.9rem;
      }
      .btn {
        display: inline-block;
        font-weight: 400;
        text-align: center;
        vertical-align: middle;
        cursor: pointer;
        padding: 8px 16px;
        font-size: 0.9rem;
        line-height: 1.5;
        border-radius: 5px;
        transition: all 0.15s ease-in-out;
        text-decoration: none;
        border: none;
      }
      .btn-primary {
        color: #fff;
        background-color: #3498db;
        border: 1px solid #3498db;
      }
      .btn-primary:hover {
        background-color: #2980b9;
        border-color: #2980b9;
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
      .status-badge {
        padding: 4px 8px;
        border-radius: 12px;
        font-size: 0.8rem;
        font-weight: 500;
        text-transform: uppercase;
      }
      .status-agendada {
        background-color: #e3f2fd;
        color: #1976d2;
      }
      .status-confirmada {
        background-color: #e8f5e8;
        color: #2e7d32;
      }
      .status-cancelada {
        background-color: #ffebee;
        color: #c62828;
      }
      .status-realizada {
        background-color: #f3e5f5;
        color: #7b1fa2;
      }
      .no-consultas {
        text-align: center;
        padding: 40px;
        background-color: #f8f9fa;
        border-radius: 8px;
        color: #6c757d;
      }
      .no-consultas i {
        font-size: 3rem;
        margin-bottom: 15px;
        color: #bbb;
      }

      /* Responsividade */
      @media screen and (max-width: 768px) {
        .filters {
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
    <jsp:include page="/WEB-INF/jspf/menu_admin.jspf" />

    <div class="container">
      <h1><i class="fas fa-calendar-check"></i> Consultar Agenda</h1>

      <!-- Filtros -->
      <div class="filters">
        <div class="filter-group">
          <label for="dataInicio">Data Início:</label>
          <input type="date" id="dataInicio" name="dataInicio" />
        </div>
        <div class="filter-group">
          <label for="dataFim">Data Fim:</label>
          <input type="date" id="dataFim" name="dataFim" />
        </div>
        <div class="filter-group">
          <label for="status">Status:</label>
          <select id="status" name="status">
            <option value="">Todos</option>
            <option value="agendada">Agendada</option>
            <option value="confirmada">Confirmada</option>
            <option value="realizada">Realizada</option>
            <option value="cancelada">Cancelada</option>
          </select>
        </div>
        <div class="filter-group">
          <label>&nbsp;</label>
          <button
            type="button"
            class="btn btn-primary"
            onclick="filtrarConsultas()"
          >
            <i class="fas fa-search"></i> Filtrar
          </button>
        </div>
      </div>

      <!-- Tabela de Consultas -->
      <c:choose>
        <c:when test="${empty consultas}">
          <div class="no-consultas">
            <i
              class="fas fa-calendar-times"
              style="font-size: 3rem; margin-bottom: 15px; color: #bbb"
            ></i>
            <h3>Nenhuma consulta encontrada</h3>
            <p>Não há consultas agendadas no sistema.</p>
          </div>
        </c:when>
        <c:otherwise>
          <table id="tabelaConsultas">
            <thead>
              <tr>
                <th>Data</th>
                <th>Horário</th>
                <th>Paciente</th>
                <th>Médico</th>
                <th>Status</th>
                <th>Observações</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="consulta" items="${consultas}">
                <tr>
                  <td data-label="Data:">${consulta.dataConsultaFormatada}</td>
                  <td data-label="Horário:">${consulta.horario}</td>
                  <td data-label="Paciente:">${consulta.nomePaciente}</td>
                  <td data-label="Médico:">${consulta.nomeMedico}</td>
                  <td data-label="Status:">
                    <span class="status-badge status-${consulta.status}">
                      ${consulta.status}
                    </span>
                  </td>
                  <td data-label="Observações:">
                    ${not empty consulta.observacoes ? consulta.observacoes :
                    '-'}
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </c:otherwise>
      </c:choose>
    </div>

    <script>
      // Definir datas padrão (últimos 30 dias)
      document.addEventListener('DOMContentLoaded', function () {
        const hoje = new Date()
        const trintaDiasAtras = new Date()
        trintaDiasAtras.setDate(hoje.getDate() - 30)

        document.getElementById('dataInicio').value = trintaDiasAtras
          .toISOString()
          .split('T')[0]
        document.getElementById('dataFim').value = hoje
          .toISOString()
          .split('T')[0]
      })

      function filtrarConsultas() {
        const dataInicio = document.getElementById('dataInicio').value
        const dataFim = document.getElementById('dataFim').value
        const status = document.getElementById('status').value

        const tabela = document.getElementById('tabelaConsultas')
        const linhas = tabela
          .getElementsByTagName('tbody')[0]
          .getElementsByTagName('tr')

        for (let i = 0; i < linhas.length; i++) {
          const linha = linhas[i]
          const dataConsulta = linha.cells[0].textContent
          const statusConsulta = linha.cells[4].textContent.trim().toLowerCase()

          let mostrar = true

          // Filtro por data (simplificado - em produção seria melhor usar parsing de data)
          if (dataInicio && dataConsulta < dataInicio) {
            mostrar = false
          }
          if (dataFim && dataConsulta > dataFim) {
            mostrar = false
          }

          // Filtro por status
          if (status && statusConsulta !== status) {
            mostrar = false
          }

          linha.style.display = mostrar ? '' : 'none'
        }
      }
    </script>
  </body>
</html>
