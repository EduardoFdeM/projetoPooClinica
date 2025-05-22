<%@ page contentType="text/html; charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Painel do Paciente - Clínica Médica</title>
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
        max-width: 1200px;
        margin: 20px auto;
        padding: 0;
      }
      .welcome-banner {
        background: linear-gradient(135deg, #2980b9, #1a5276);
        color: #ffffff;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        margin-bottom: 25px;
        position: relative;
        overflow: hidden;
      }
      .welcome-banner::before {
        content: '';
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><path fill="%23ffffff10" d="M0 0L100 100H0V0Z"/></svg>');
        background-size: 20px 20px;
        opacity: 0.1;
      }
      .welcome-banner h1 {
        margin: 0;
        font-size: 28px;
        font-weight: 500;
        text-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
      }
      .welcome-banner p {
        margin-top: 10px;
        opacity: 0.9;
        font-size: 16px;
      }

      .dashboard-cards {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
        gap: 25px;
        margin-bottom: 30px;
      }

      .card {
        background-color: white;
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
        display: flex;
        flex-direction: column;
        height: 100%;
        position: relative;
        border-top: 4px solid transparent;
        box-sizing: border-box;
      }

      .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
      }

      .card h2 {
        color: #2c3e50;
        margin-top: 0;
        font-size: 22px;
        font-weight: 600;
        margin-bottom: 15px;
        display: flex;
        align-items: center;
      }

      .card h2 i {
        margin-right: 10px;
        font-size: 20px;
        background-color: #f0f7fc;
        padding: 10px;
        border-radius: 50%;
        color: #3498db;
        flex-shrink: 0;
      }

      .card p {
        color: #7f8c8d;
        margin-bottom: 20px;
        line-height: 1.5;
        flex-grow: 1;
      }

      .card-footer {
        margin-top: auto;
        padding-top: 20px;
        width: 100%;
      }

      .card-button {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 14px 20px;
        background-color: #3498db;
        color: white;
        text-decoration: none;
        border-radius: 8px;
        font-weight: 500;
        transition: all 0.3s ease;
        text-align: center;
        border: none;
        cursor: pointer;
        width: 100%;
        position: relative;
        overflow: hidden;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        box-sizing: border-box;
      }

      .card-button::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(
          90deg,
          rgba(255, 255, 255, 0) 0%,
          rgba(255, 255, 255, 0.2) 50%,
          rgba(255, 255, 255, 0) 100%
        );
        transition: left 0.7s ease;
      }

      .card-button:hover {
        background-color: #2980b9;
        transform: translateY(-2px);
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
      }

      .card-button:hover::before {
        left: 100%;
      }

      .card-button i {
        margin-right: 12px;
        font-size: 18px;
        flex-shrink: 0;
      }

      .next-appointment {
        border-top-color: #3498db;
      }

      .schedule-card {
        border-top-color: #27ae60;
      }

      .profile-card {
        border-top-color: #e74c3c;
      }

      .appointment-details {
        margin: 20px 0;
        padding: 15px;
        background-color: #f8f9fa;
        border-radius: 8px;
        border-left: 4px solid #3498db;
        box-sizing: border-box;
      }

      .appointment-details p {
        margin: 8px 0;
        color: #34495e;
      }

      .appointment-label {
        font-weight: 600;
        color: #2c3e50;
        display: inline-block;
        min-width: 100px;
      }

      .no-appointment {
        background-color: #f8f9fa;
        padding: 15px;
        border-radius: 8px;
        border-left: 4px solid #95a5a6;
        font-style: italic;
        color: #7f8c8d;
        margin: 20px 0;
        box-sizing: border-box;
      }

      .empty-state {
        text-align: center;
        padding: 30px;
      }

      .empty-state i {
        font-size: 40px;
        color: #bdc3c7;
        margin-bottom: 15px;
      }

      /* Responsividade */
      @media (max-width: 768px) {
        .welcome-banner {
          padding: 20px;
        }
        .dashboard-cards {
          grid-template-columns: 1fr;
          gap: 20px;
        }
        .card {
          padding: 20px;
        }
        .card-button {
          padding: 12px 15px;
        }
        .card-button i {
          font-size: 16px;
          margin-right: 8px;
        }
      }

      @media (max-width: 480px) {
        .content {
          width: 95%;
          margin: 15px auto;
        }
        .card {
          padding: 16px;
        }
        .card h2 {
          font-size: 18px;
        }
        .card h2 i {
          font-size: 18px;
          padding: 8px;
        }
        .card-button {
          padding: 10px 12px;
          font-size: 14px;
        }
        .appointment-details {
          padding: 12px;
        }
        .no-appointment {
          padding: 12px;
        }
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/jspf/menu_paciente.jspf" />

    <div class="content">
      <div class="welcome-banner">
        <h1>Bem-vindo(a), ${sessionScope.nome}!</h1>
        <p>
          Aqui você pode gerenciar suas consultas e acessar seus dados médicos.
        </p>
      </div>

      <div class="dashboard-cards">
        <div class="card next-appointment">
          <h2><i class="fas fa-calendar-check"></i>Próxima Consulta</h2>

          <c:choose>
            <c:when test="${proximaConsulta != null}">
              <div class="appointment-details">
                <p>
                  <span class="appointment-label">Data/Hora:</span>
                  ${proximaConsulta.getFormattedDataHora()}
                </p>
                <p>
                  <span class="appointment-label">Médico:</span>
                  ${proximaConsulta.nomeProfissional}
                </p>
                <c:if test="${not empty proximaConsulta.observacoes}">
                  <p>
                    <span class="appointment-label">Observações:</span>
                    ${proximaConsulta.observacoes}
                  </p>
                </c:if>
              </div>
            </c:when>
            <c:otherwise>
              <div class="no-appointment">
                <div class="empty-state">
                  <i class="fas fa-calendar-xmark"></i>
                  <p>Você não possui consultas agendadas.</p>
                </div>
              </div>
            </c:otherwise>
          </c:choose>

          <div class="card-footer">
            <a
              href="${pageContext.request.contextPath}/minha_agenda"
              class="card-button"
            >
              <i class="fas fa-calendar-alt"></i> Ver Agenda
            </a>
          </div>
        </div>

        <div class="card schedule-card">
          <h2><i class="fas fa-calendar-plus"></i>Agendamento</h2>
          <p>
            Agende uma nova consulta com nossos especialistas de forma rápida e
            simples.
          </p>
          <div class="card-footer">
            <a
              href="${pageContext.request.contextPath}/agendarConsulta"
              class="card-button"
            >
              <i class="fas fa-calendar-plus"></i> Agendar Consulta
            </a>
          </div>
        </div>

        <div class="card profile-card">
          <h2><i class="fas fa-user-circle"></i>Meus Dados</h2>
          <p>
            Visualize e mantenha seus dados cadastrais atualizados para um
            melhor atendimento.
          </p>
          <div class="card-footer">
            <a
              href="${pageContext.request.contextPath}/meu_cadastro"
              class="card-button"
            >
              <i class="fas fa-user-edit"></i> Ver Cadastro
            </a>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
