<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="com.mack.clinica.model.Usuario" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Meu Cadastro - Clínica Médica</title>
    <link rel="stylesheet" href="css/style.css" />
    <%-- Mantendo o CSS externo --%>
    <style>
      body {
        font-family: Arial, sans-serif;
        background-color: #f4f7f6;
        color: #333;
        margin: 0;
        padding: 0;
      }
      .container {
        width: 80%;
        margin: 20px auto;
        padding: 20px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
      }
      h1 {
        color: #0056b3;
        text-align: center;
        margin-bottom: 20px;
      }
      table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
      }
      th,
      td {
        padding: 12px;
        border: 1px solid #ddd;
        text-align: left;
      }
      th {
        background-color: #007bff;
        color: white;
      }
      td {
        background-color: #f9f9f9;
      }
      .button-container {
        text-align: center;
        margin-top: 20px;
      }
      .button {
        background-color: #007bff;
        color: white;
        padding: 10px 20px;
        text-decoration: none;
        border-radius: 5px;
        border: none;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s ease;
      }
      .button:hover {
        background-color: #0056b3;
      }
      .button-edit {
        background-color: #28a745; /* Verde para editar */
      }
      .button-edit:hover {
        background-color: #1e7e34;
      }

      /* Estilo para o link de voltar */
      .back-link {
        display: inline-block;
        margin-bottom: 20px;
        padding: 8px 15px;
        background-color: #6c757d; /* Cinza */
        color: white;
        text-decoration: none;
        border-radius: 5px;
        font-size: 14px;
      }
      .back-link:hover {
        background-color: #545b62;
      }
    </style>
  </head>
  <body>
    <% Usuario paciente = (Usuario) request.getAttribute("paciente"); String
    basePath = request.getContextPath(); %>

    <div class="container">
      <h1>Meus Dados Cadastrais</h1>

      <a href="<%= basePath %>/paciente_dashboard.jsp" class="back-link"
        >&laquo; Voltar ao Painel</a
      >

      <% if (paciente != null) { %>
      <table>
        <tr>
          <th>Campo</th>
          <th>Informação</th>
        </tr>
        <tr>
          <td>ID:</td>
          <td><%= paciente.getId() %></td>
        </tr>
        <tr>
          <td>Nome Completo:</td>
          <td>
            <%= paciente.getNome() != null ? paciente.getNome() : "Não
            informado" %>
          </td>
        </tr>
        <tr>
          <td>Email:</td>
          <td>
            <%= paciente.getEmail() != null ? paciente.getEmail() : "Não
            informado" %>
          </td>
        </tr>
        <tr>
          <td>CPF:</td>
          <td>
            <%= paciente.getCpf() != null ? paciente.getCpf() : "Não informado"
            %>
          </td>
        </tr>
        <tr>
          <td>Celular:</td>
          <td>
            <%= paciente.getCelular() != null ? paciente.getCelular() : "Não
            informado" %>
          </td>
        </tr>
        <tr>
          <td>Tipo de Usuário:</td>
          <td>
            <%= paciente.getTipo() != null ? paciente.getTipo() : "Não
            informado" %>
          </td>
        </tr>
        <tr>
          <td>Data de Criação:</td>
          <td>
            <%= paciente.getFormattedCreatedAt() != null ?
            paciente.getFormattedCreatedAt() : "Não informada" %>
          </td>
        </tr>
      </table>

      <div class="button-container">
        <%-- Futuramente, adicionar um botão para editar os dados --%> <%--
        <a href="editar_cadastro.jsp" class="button button-edit"
          >Editar Cadastro</a
        >
        --%>
      </div>

      <% } else { %>
      <p>
        Não foi possível carregar os dados do seu cadastro. Por favor, tente
        novamente ou contate o suporte.
      </p>
      <% } %>

      <div class="button-container" style="margin-top: 30px">
        <a href="logout.jsp" class="button">Sair</a>
      </div>
    </div>
  </body>
</html>
