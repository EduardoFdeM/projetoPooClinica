<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="com.mack.clinica.model.Usuario" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Meu Cadastro - Clínica Médica</title>
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/css/style.css"
    />
    <%-- Mantendo o CSS externo --%>
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
        max-width: 800px;
        margin: 20px auto;
        padding: 25px;
        background-color: #fff;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        border-radius: 12px;
      }
      h1 {
        color: #2c3e50;
        text-align: center;
        margin-bottom: 25px;
        font-weight: 600;
      }
      .profile-card {
        margin-bottom: 30px;
      }
      .info-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        margin-bottom: 20px;
      }
      .info-table th,
      .info-table td {
        padding: 15px;
        text-align: left;
        border-bottom: 1px solid #e9ecef;
      }
      .info-table th {
        background-color: #3498db;
        color: white;
        font-weight: 500;
        border-radius: 6px 0 0 6px;
        width: 200px;
      }
      .info-table td {
        background-color: #f8f9fa;
        border-radius: 0 6px 6px 0;
      }
      .info-table tr:last-child th,
      .info-table tr:last-child td {
        border-bottom: none;
      }
      .buttons {
        display: flex;
        justify-content: center;
        gap: 15px;
        margin-top: 30px;
      }
      .button {
        display: inline-block;
        padding: 12px 25px;
        background-color: #3498db;
        color: white;
        text-decoration: none;
        border-radius: 6px;
        font-weight: 500;
        transition: background-color 0.3s;
        border: none;
        cursor: pointer;
      }
      .button:hover {
        background-color: #2980b9;
      }
      .button-secondary {
        background-color: #7f8c8d;
      }
      .button-secondary:hover {
        background-color: #6c7a7d;
      }
      .button-edit {
        background-color: #27ae60;
      }
      .button-edit:hover {
        background-color: #219955;
      }
      .error-message {
        background-color: #f8d7da;
        color: #721c24;
        padding: 15px;
        border-radius: 6px;
        margin-bottom: 20px;
        text-align: center;
      }
      .success-message {
        background-color: #d4edda;
        color: #155724;
        padding: 15px;
        border-radius: 6px;
        margin-bottom: 20px;
        text-align: center;
      }

      @media (max-width: 768px) {
        .container {
          width: 95%;
          padding: 15px;
        }
        .info-table th {
          width: 120px;
          padding: 10px;
        }
        .info-table td {
          padding: 10px;
        }
        .buttons {
          flex-direction: column;
        }
        .button {
          width: 100%;
          text-align: center;
        }
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/jspf/menu_paciente.jspf" />

    <div class="container">
      <h1>Meus Dados Cadastrais</h1>

      <!-- Mensagens de sucesso -->
      <c:if test="${param.success != null}">
        <div class="success-message">
          <c:choose>
            <c:when test="${param.success == 'update'}">
              Seus dados foram atualizados com sucesso!
            </c:when>
            <c:otherwise> Operação realizada com sucesso. </c:otherwise>
          </c:choose>
        </div>
      </c:if>

      <c:choose>
        <c:when test="${paciente != null}">
          <div class="profile-card">
            <table class="info-table">
              <tr>
                <th>ID:</th>
                <td>${paciente.id}</td>
              </tr>
              <tr>
                <th>Nome Completo:</th>
                <td>
                  ${paciente.nome != null ? paciente.nome : "Não informado"}
                </td>
              </tr>
              <tr>
                <th>Email:</th>
                <td>
                  ${paciente.email != null ? paciente.email : "Não informado"}
                </td>
              </tr>
              <tr>
                <th>CPF:</th>
                <td>
                  ${paciente.cpf != null ? paciente.cpf : "Não informado"}
                </td>
              </tr>
              <tr>
                <th>Celular:</th>
                <td>
                  ${paciente.celular != null ? paciente.celular : "Não
                  informado"}
                </td>
              </tr>
              <tr>
                <th>Data de Nascimento:</th>
                <td>
                  ${paciente.dataNascimento != null ?
                  paciente.getFormattedDataNascimento() : "Não informada"}
                </td>
              </tr>
              <tr>
                <th>Tipo de Usuário:</th>
                <td>
                  ${paciente.tipo != null ? paciente.tipo : "Não informado"}
                </td>
              </tr>
              <tr>
                <th>Data de Criação:</th>
                <td>
                  ${paciente.formattedCreatedAt != null ?
                  paciente.formattedCreatedAt : "Não informada"}
                </td>
              </tr>
            </table>
          </div>

          <div class="buttons">
            <a
              href="${pageContext.request.contextPath}/paciente_dashboard"
              class="button button-secondary"
              >Voltar ao Painel</a
            >
            <a
              href="${pageContext.request.contextPath}/meu_cadastro?action=edit"
              class="button button-edit"
              >Editar Meus Dados</a
            >
          </div>
        </c:when>
        <c:otherwise>
          <div class="error-message">
            Não foi possível carregar os dados do seu cadastro. Por favor, tente
            novamente ou contate o suporte.
          </div>
          <div class="buttons">
            <a
              href="${pageContext.request.contextPath}/paciente_dashboard"
              class="button button-secondary"
              >Voltar ao Painel</a
            >
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </body>
</html>
