<%@ page contentType="text/html; charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Painel do Administrador - Clínica Médica</title>
    <!-- Importa o CSS externo -->
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
      .dashboard-container {
        max-width: 1200px;
        margin: 20px auto;
        padding: 20px;
      }
      .welcome-section {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 30px;
        border-radius: 12px;
        margin-bottom: 30px;
        text-align: center;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      }
      .welcome-section h1 {
        margin: 0 0 10px 0;
        font-size: 2.5rem;
        font-weight: 300;
      }
      .welcome-section p {
        margin: 0;
        font-size: 1.2rem;
        opacity: 0.9;
      }
      .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
      }
      .stat-card {
        background: white;
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        display: flex;
        align-items: center;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
      }
      .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
      }
      .stat-icon {
        width: 60px;
        height: 60px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        color: white;
        margin-right: 20px;
      }
      .stat-icon.patients {
        background: linear-gradient(135deg, #667eea, #764ba2);
      }
      .stat-icon.doctors {
        background: linear-gradient(135deg, #f093fb, #f5576c);
      }
      .stat-icon.appointments {
        background: linear-gradient(135deg, #4facfe, #00f2fe);
      }
      .stat-icon.today {
        background: linear-gradient(135deg, #43e97b, #38f9d7);
      }

      .stat-content h3 {
        margin: 0 0 5px 0;
        font-size: 2rem;
        font-weight: 600;
        color: #2c3e50;
      }
      .stat-content p {
        margin: 0;
        color: #7f8c8d;
        font-weight: 500;
      }

      .quick-actions {
        background: white;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        margin-bottom: 30px;
      }
      .quick-actions h2 {
        color: #2c3e50;
        margin-bottom: 20px;
        font-weight: 600;
      }
      .actions-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 15px;
      }
      .action-btn {
        display: flex;
        align-items: center;
        padding: 15px 20px;
        background: #f8f9fa;
        border: 2px solid #e9ecef;
        border-radius: 8px;
        text-decoration: none;
        color: #495057;
        transition: all 0.3s ease;
        font-weight: 500;
      }
      .action-btn:hover {
        background: #e9ecef;
        border-color: #3498db;
        color: #3498db;
        text-decoration: none;
      }
      .action-btn i {
        margin-right: 10px;
        font-size: 1.2rem;
      }

      .recent-activity {
        background: white;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      }
      .recent-activity h2 {
        color: #2c3e50;
        margin-bottom: 20px;
        font-weight: 600;
      }
      .activity-item {
        display: flex;
        align-items: center;
        padding: 15px 0;
        border-bottom: 1px solid #f1f2f6;
      }
      .activity-item:last-child {
        border-bottom: none;
      }
      .activity-icon {
        width: 40px;
        height: 40px;
        background: #3498db;
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 15px;
        font-size: 0.9rem;
      }
      .activity-content {
        flex-grow: 1;
      }
      .activity-content h4 {
        margin: 0 0 5px 0;
        color: #2c3e50;
        font-size: 0.95rem;
      }
      .activity-content p {
        margin: 0;
        color: #7f8c8d;
        font-size: 0.85rem;
      }

      /* Responsividade */
      @media (max-width: 768px) {
        .dashboard-container {
          padding: 10px;
        }
        .welcome-section h1 {
          font-size: 2rem;
        }
        .welcome-section p {
          font-size: 1rem;
        }
        .stats-grid {
          grid-template-columns: 1fr;
        }
        .actions-grid {
          grid-template-columns: 1fr;
        }
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/jspf/menu_admin.jspf" />

    <div class="dashboard-container">
      <!-- Seção de Boas-vindas -->
      <div class="welcome-section">
        <h1>Painel do Administrador</h1>
        <p>Bem-vindo ao sistema de gestão da clínica médica</p>
      </div>

      <!-- Estatísticas -->
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-icon patients">
            <i class="fas fa-users"></i>
          </div>
          <div class="stat-content">
            <h3>${totalPacientes}</h3>
            <p>Pacientes Cadastrados</p>
          </div>
        </div>

        <div class="stat-card">
          <div class="stat-icon doctors">
            <i class="fas fa-user-md"></i>
          </div>
          <div class="stat-content">
            <h3>${totalMedicos}</h3>
            <p>Médicos Cadastrados</p>
          </div>
        </div>

        <div class="stat-card">
          <div class="stat-icon appointments">
            <i class="fas fa-calendar-alt"></i>
          </div>
          <div class="stat-content">
            <h3>${totalConsultas}</h3>
            <p>Total de Consultas</p>
          </div>
        </div>

        <div class="stat-card">
          <div class="stat-icon today">
            <i class="fas fa-file-medical-alt"></i>
          </div>
          <div class="stat-content">
            <h3>${totalFichasClinicas}</h3>
            <p>Fichas Clínicas</p>
          </div>
        </div>
      </div>

      <!-- Ações Rápidas -->
      <div class="quick-actions">
        <h2><i class="fas fa-bolt"></i> Ações Rápidas</h2>
        <div class="actions-grid">
          <a
            href="${pageContext.request.contextPath}/pacientes"
            class="action-btn"
          >
            <i class="fas fa-user-plus"></i>
            Gerenciar Pacientes
          </a>
          <a
            href="${pageContext.request.contextPath}/medicos"
            class="action-btn"
          >
            <i class="fas fa-user-md"></i>
            Gerenciar Médicos
          </a>
          <a
            href="${pageContext.request.contextPath}/consultar_agenda"
            class="action-btn"
          >
            <i class="fas fa-calendar-check"></i>
            Consultar Agenda
          </a>
          <a
            href="${pageContext.request.contextPath}/ficha_clinica"
            class="action-btn"
          >
            <i class="fas fa-file-medical"></i>
            Fichas Clínicas
          </a>
        </div>
      </div>

      <!-- Atividade Recente -->
      <div class="recent-activity">
        <h2><i class="fas fa-clock"></i> Atividade Recente</h2>

        <c:choose>
          <c:when
            test="${totalPacientes > 0 || totalMedicos > 0 || totalConsultas > 0}"
          >
            <c:if test="${totalPacientes > 0}">
              <div class="activity-item">
                <div class="activity-icon">
                  <i class="fas fa-user"></i>
                </div>
                <div class="activity-content">
                  <h4>Pacientes no Sistema</h4>
                  <p>${totalPacientes} paciente(s) cadastrado(s) no sistema</p>
                </div>
              </div>
            </c:if>

            <c:if test="${totalMedicos > 0}">
              <div class="activity-item">
                <div class="activity-icon">
                  <i class="fas fa-user-md"></i>
                </div>
                <div class="activity-content">
                  <h4>Médicos no Sistema</h4>
                  <p>${totalMedicos} médico(s) cadastrado(s) no sistema</p>
                </div>
              </div>
            </c:if>

            <c:if test="${totalFichasClinicas > 0}">
              <div class="activity-item">
                <div class="activity-icon">
                  <i class="fas fa-file-medical-alt"></i>
                </div>
                <div class="activity-content">
                  <h4>Fichas Clínicas</h4>
                  <p>${totalFichasClinicas} ficha(s) clínica(s) no sistema</p>
                </div>
              </div>
            </c:if>
          </c:when>
          <c:otherwise>
            <div class="activity-item">
              <div class="activity-icon">
                <i class="fas fa-info"></i>
              </div>
              <div class="activity-content">
                <h4>Sistema Inicializado</h4>
                <p>
                  Bem-vindo! Comece cadastrando pacientes e médicos para usar o
                  sistema.
                </p>
              </div>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>

    <script>
      // Animação para os cards de estatísticas
      document.addEventListener('DOMContentLoaded', function () {
        const cards = document.querySelectorAll('.stat-card')
        cards.forEach((card, index) => {
          setTimeout(() => {
            card.style.opacity = '0'
            card.style.transform = 'translateY(20px)'
            card.style.transition = 'opacity 0.6s ease, transform 0.6s ease'

            setTimeout(() => {
              card.style.opacity = '1'
              card.style.transform = 'translateY(0)'
            }, 100)
          }, index * 150)
        })
      })
    </script>
  </body>
</html>
