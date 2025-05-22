<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="java.util.List" %> <%@ page import="com.mack.clinica.model.Usuario" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gerenciar Pacientes - Clínica Médica</title>
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
      .alert-success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
      }
      .alert-danger {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
      }
      .actions-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
      }
      .btn {
        display: inline-block;
        font-weight: 400;
        text-align: center;
        vertical-align: middle;
        cursor: pointer;
        padding: 10px 20px;
        font-size: 0.9rem;
        line-height: 1.5;
        border-radius: 5px;
        transition: all 0.15s ease-in-out;
        text-decoration: none;
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
      .btn-danger {
        color: #fff;
        background-color: #e74c3c;
        border: 1px solid #e74c3c;
      }
      .btn-danger:hover {
        background-color: #c0392b;
        border-color: #c0392b;
      }
      .btn-secondary {
        color: #fff;
        background-color: #6c757d;
        border: 1px solid #6c757d;
      }
      .btn-secondary:hover {
        background-color: #5a6268;
        border-color: #5a6268;
      }
      .btn-sm {
        padding: 5px 10px;
        font-size: 0.82rem;
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
      .actions {
        display: flex;
        gap: 10px;
        justify-content: center;
      }
      .icon-button {
        background-color: transparent;
        border: none;
        padding: 5px;
        cursor: pointer;
        transition: transform 0.2s;
        font-size: 1.1rem;
      }
      .icon-button:hover {
        transform: scale(1.2);
      }
      .edit-icon {
        color: #3498db;
      }
      .delete-icon {
        color: #e74c3c;
      }
      .search-bar {
        display: flex;
        gap: 10px;
        margin-bottom: 20px;
      }
      .search-bar input {
        flex-grow: 1;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 0.9rem;
      }
      .search-bar button {
        padding: 10px 15px;
        background-color: #3498db;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
      }
      .search-bar button:hover {
        background-color: #2980b9;
      }
      .no-patients {
        text-align: center;
        padding: 20px;
        background-color: #f8f9fa;
        border-radius: 5px;
        margin-top: 20px;
        color: #6c757d;
      }

      /* Responsividade para tabelas em dispositivos móveis */
      @media screen and (max-width: 768px) {
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
        .actions {
          justify-content: flex-end;
        }
        .actions-container {
          flex-direction: column;
          gap: 10px;
          align-items: stretch;
        }
        .btn {
          text-align: center;
          margin-bottom: 5px;
        }
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/jspf/menu_admin.jspf" />

    <div class="container">
      <h1>Gerenciamento de Pacientes</h1>

      <!-- Alertas de Sucesso/Erro -->
      <c:if test="${param.success != null}">
        <div class="alert alert-success">
          <c:choose>
            <c:when test="${param.success == 'create'}">
              Paciente cadastrado com sucesso!
            </c:when>
            <c:when test="${param.success == 'update'}">
              Dados do paciente atualizados com sucesso!
            </c:when>
            <c:when test="${param.success == 'delete'}">
              Paciente excluído com sucesso!
            </c:when>
          </c:choose>
        </div>
      </c:if>

      <c:if test="${param.error != null}">
        <div class="alert alert-danger">
          <c:choose>
            <c:when test="${param.error == 'paciente_nao_encontrado'}">
              Paciente não encontrado.
            </c:when>
            <c:when test="${param.error == 'falha_criar'}">
              Erro ao cadastrar o paciente. Tente novamente.
            </c:when>
            <c:when test="${param.error == 'falha_atualizar'}">
              Erro ao atualizar o paciente. Tente novamente.
            </c:when>
            <c:when test="${param.error == 'falha_deletar'}">
              Erro ao excluir o paciente. Tente novamente.
            </c:when>
            <c:otherwise>
              Ocorreu um erro. Por favor, tente novamente.
            </c:otherwise>
          </c:choose>
        </div>
      </c:if>

      <div class="actions-container">
        <a
          href="${pageContext.request.contextPath}/pacientes?action=new"
          class="btn btn-primary"
        >
          <i class="fas fa-plus"></i> Novo Paciente
        </a>
      </div>

      <c:choose>
        <c:when test="${empty pacientes}">
          <div class="no-patients">
            <p>Nenhum paciente cadastrado.</p>
          </div>
        </c:when>
        <c:otherwise>
          <table>
            <thead>
              <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Email</th>
                <th>CPF</th>
                <th>Celular</th>
                <th>Ações</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="paciente" items="${pacientes}">
                <tr>
                  <td data-label="ID:">${paciente.id}</td>
                  <td data-label="Nome:">${paciente.nome}</td>
                  <td data-label="Email:">${paciente.email}</td>
                  <td data-label="CPF:">${paciente.cpf}</td>
                  <td data-label="Celular:">
                    ${paciente.celular != null ? paciente.celular : '-'}
                  </td>
                  <td data-label="Ações:" class="actions">
                    <a
                      href="${pageContext.request.contextPath}/pacientes?action=edit&id=${paciente.id}"
                      class="icon-button edit-icon"
                      title="Editar"
                    >
                      <i class="fas fa-edit"></i>
                    </a>
                    <a
                      href="#"
                      onclick="confirmarExclusao(${paciente.id})"
                      class="icon-button delete-icon"
                      title="Excluir"
                    >
                      <i class="fas fa-trash-alt"></i>
                    </a>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </c:otherwise>
      </c:choose>
    </div>

    <script>
      function confirmarExclusao(id) {
        if (
          confirm(
            'Tem certeza que deseja excluir este paciente? Esta ação não pode ser desfeita.'
          )
        ) {
          window.location.href =
            '${pageContext.request.contextPath}/pacientes?action=delete&id=' +
            id
        }
      }
    </script>
  </body>
</html>
