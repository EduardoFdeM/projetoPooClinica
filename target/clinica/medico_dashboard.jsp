<%@ page contentType="text/html; charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Painel do Médico - Clínica Médica</title>
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
        background: linear-gradient(135deg, #27ae60, #229954);
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
        color: #27ae60;
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
        background-color: #27ae60;
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

      .card-button:hover {
        background-color: #229954;
        transform: translateY(-2px);
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
      }

      .card-button i {
        margin-right: 12px;
        font-size: 18px;
        flex-shrink: 0;
      }

      .agenda-card {
        border-top-color: #27ae60;
      }

      .patients-card {
        border-top-color: #3498db;
      }

      .records-card {
        border-top-color: #e74c3c;
      }

      .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
        gap: 15px;
        margin: 20px 0;
      }

      .stat-item {
        background-color: #f8f9fa;
        padding: 15px;
        border-radius: 8px;
        text-align: center;
        border-left: 4px solid #27ae60;
      }

      .stat-number {
        font-size: 24px;
        font-weight: bold;
        color: #27ae60;
        display: block;
      }

      .stat-label {
        font-size: 12px;
        color: #6c757d;
        text-transform: uppercase;
        margin-top: 5px;
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
        .stats-grid {
          grid-template-columns: repeat(2, 1fr);
        }
      }

      @media (max-width: 480px) {
        .content {
          width: 95%;
          margin: 15px auto;
        }
        .stats-grid {
          grid-template-columns: 1fr;
        }
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/jspf/menu_medico.jspf" />

    <div class="content">
      <div class="welcome-banner">
        <h1>Dr(a). ${sessionScope.nome}</h1>
        <p>
          Bem-vindo(a) ao seu painel médico. Gerencie suas consultas e
          prontuários.
        </p>
      </div>

      <div class="dashboard-cards">
        <div class="card agenda-card">
          <h2><i class="fas fa-calendar-check"></i>Minha Agenda</h2>
          <div class="stats-grid">
            <div class="stat-item">
              <span class="stat-number">${consultasHoje}</span>
              <span class="stat-label">Hoje</span>
            </div>
            <div class="stat-item">
              <span class="stat-number">${consultasSemana}</span>
              <span class="stat-label">Esta Semana</span>
            </div>
            <div class="stat-item">
              <span class="stat-number">${totalConsultas}</span>
              <span class="stat-label">Total</span>
            </div>
          </div>
          <div class="card-footer">
            <a
              href="${pageContext.request.contextPath}/minha_agenda_medico"
              class="card-button"
            >
              <i class="fas fa-calendar-alt"></i> Ver Agenda Completa
            </a>
          </div>
        </div>

        <div class="card patients-card">
          <h2><i class="fas fa-users"></i>Meus Pacientes</h2>
          <p>
            Acesse a lista completa de pacientes que você já atendeu e seus
            históricos médicos.
          </p>
          <div class="card-footer">
            <a
              href="${pageContext.request.contextPath}/meus_pacientes"
              class="card-button"
            >
              <i class="fas fa-user-injured"></i> Ver Pacientes
            </a>
          </div>
        </div>

        <div class="card records-card">
          <h2><i class="fas fa-file-medical"></i>Prontuários</h2>
          <p>Gerencie os prontuários e fichas clínicas dos seus pacientes.</p>
          <div class="card-footer">
            <a
              href="${pageContext.request.contextPath}/meus_prontuarios"
              class="card-button"
            >
              <i class="fas fa-clipboard-list"></i> Ver Prontuários
            </a>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
