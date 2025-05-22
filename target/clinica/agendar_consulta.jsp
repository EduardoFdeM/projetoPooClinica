<%@ page contentType="text/html; charset=UTF-8" language="java" %> <%@ page
import="java.util.List" %> <%@ page import="com.mack.clinica.model.Usuario" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Agendar Consulta</title>
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
      .content {
        width: 90%;
        max-width: 800px;
        margin: 20px auto;
        padding: 30px;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      }
      h1 {
        color: #2c3e50;
        text-align: center;
        margin-bottom: 30px;
        font-weight: 600;
      }
      .form-container {
        display: flex;
        flex-direction: column;
        gap: 22px;
      }
      .form-group {
        margin-bottom: 5px;
      }
      label {
        display: block;
        margin-bottom: 10px;
        font-weight: 500;
        color: #2c3e50;
        font-size: 16px;
      }
      select,
      input,
      textarea {
        width: 100%;
        padding: 13px 15px;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-size: 16px;
        background-color: #f9fafb;
        transition: all 0.3s ease;
        color: #2c3e50;
      }
      select:focus,
      input:focus,
      textarea:focus {
        outline: none;
        border-color: #3498db;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        background-color: white;
      }
      textarea {
        min-height: 120px;
        resize: vertical;
      }
      .button-container {
        margin-top: 10px;
        text-align: center;
      }
      button {
        background-color: #3498db;
        color: white;
        padding: 14px 28px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 16px;
        font-weight: 500;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 100%;
      }
      button:hover {
        background-color: #2980b9;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      }
      button i {
        margin-right: 8px;
      }
      .alert {
        padding: 18px;
        margin-bottom: 25px;
        border-radius: 8px;
        position: relative;
        padding-left: 55px;
      }
      .alert::before {
        font-family: 'Font Awesome 6 Free';
        font-weight: 900;
        position: absolute;
        left: 20px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 22px;
      }
      .alert-danger {
        background-color: #fef2f2;
        color: #991b1b;
        border-left: 4px solid #ef4444;
      }
      .alert-danger::before {
        content: '\f071'; /* exclamation triangle */
        color: #ef4444;
      }
      .alert-info {
        background-color: #eff6ff;
        color: #1e40af;
        border-left: 4px solid #3b82f6;
      }
      .alert-info::before {
        content: '\f05a'; /* info circle */
        color: #3b82f6;
      }
      .field-icon {
        margin-right: 10px;
        color: #3498db;
        width: 20px;
        text-align: center;
      }
      @media (max-width: 768px) {
        .content {
          width: 95%;
          padding: 20px;
        }
        button {
          padding: 12px 20px;
        }
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/jspf/menu_paciente.jspf" />

    <div class="content">
      <h1>Agendar Consulta</h1>

      <!-- Mensagens de erro -->
      <c:if test="${param.error != null}">
        <div class="alert alert-danger">
          <c:choose>
            <c:when test="${param.error == 'falha'}">
              Não foi possível agendar a consulta. Verifique a disponibilidade
              da data e horário e tente novamente.
            </c:when>
            <c:otherwise>
              Ocorreu um erro ao processar sua solicitação. Por favor, tente
              novamente.
            </c:otherwise>
          </c:choose>
        </div>
      </c:if>

      <!-- Informações para o usuário -->
      <div class="alert alert-info">
        Selecione o médico e o horário desejado para sua consulta. As consultas
        têm duração de 1 hora.
      </div>

      <form
        method="post"
        action="${pageContext.request.contextPath}/agendarConsulta"
        class="form-container"
      >
        <div class="form-group">
          <label for="profissionalId"
            ><i class="fas fa-user-md field-icon"></i>Médico:</label
          >
          <select id="profissionalId" name="profissionalId" required>
            <option value="">Selecione o médico</option>
            <c:forEach var="medico" items="${medicos}">
              <option value="${medico.id}">${medico.nome}</option>
            </c:forEach>
          </select>
        </div>

        <div class="form-group">
          <label for="dataHora"
            ><i class="fas fa-calendar-alt field-icon"></i>Data e Hora:</label
          >
          <input
            type="datetime-local"
            id="dataHora"
            name="dataHora"
            required
            min="${now}"
          />
        </div>

        <div class="form-group">
          <label for="observacoes"
            ><i class="fas fa-clipboard-list field-icon"></i>Observações:</label
          >
          <textarea
            id="observacoes"
            name="observacoes"
            placeholder="Descreva o motivo da consulta, sintomas ou outras informações importantes para o médico"
          ></textarea>
        </div>

        <div class="button-container">
          <button type="submit">
            <i class="fas fa-check-circle"></i>Agendar Consulta
          </button>
        </div>
      </form>
    </div>

    <script>
      // Define a data mínima como hoje
      const today = new Date()
      today.setMinutes(today.getMinutes() - today.getTimezoneOffset())
      document.getElementById('dataHora').min = today.toISOString().slice(0, 16)
    </script>
  </body>
</html>
