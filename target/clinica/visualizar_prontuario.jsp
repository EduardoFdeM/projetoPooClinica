<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Visualizar Prontuário - Clínica Médica</title>
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
        max-width: 900px;
        margin: 20px auto;
        padding: 25px;
        background: white;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      }
      h1 {
        color: #2c3e50;
        margin-bottom: 25px;
        font-weight: 600;
        text-align: center;
      }
      .patient-header {
        background: linear-gradient(135deg, #e74c3c, #c0392b);
        color: white;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 25px;
      }
      .patient-name {
        font-size: 1.5rem;
        font-weight: 600;
        margin-bottom: 10px;
      }
      .consultation-info {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 15px;
        opacity: 0.9;
      }
      .info-item {
        display: flex;
        align-items: center;
        gap: 8px;
      }
      .section {
        background-color: #f8f9fa;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 20px;
      }
      .section-title {
        color: #2c3e50;
        margin: 0 0 15px 0;
        padding-bottom: 10px;
        border-bottom: 2px solid #e9ecef;
        display: flex;
        align-items: center;
        gap: 10px;
        font-weight: 600;
      }
      .section-content {
        line-height: 1.6;
        color: #495057;
        white-space: pre-wrap;
      }
      .empty-content {
        color: #6c757d;
        font-style: italic;
      }
      .btn-group {
        display: flex;
        justify-content: center;
        margin-top: 30px;
      }
      .btn {
        display: inline-block;
        padding: 12px 24px;
        font-size: 1rem;
        text-decoration: none;
        border-radius: 5px;
        transition: all 0.2s;
        border: none;
        cursor: pointer;
      }
      .btn-secondary {
        background-color: #6c757d;
        color: white;
      }
      .btn-secondary:hover {
        background-color: #5a6268;
      }

      /* Responsividade */
      @media screen and (max-width: 768px) {
        .container {
          width: 95%;
          padding: 15px;
        }
        .consultation-info {
          grid-template-columns: 1fr;
        }
        .patient-name {
          font-size: 1.3rem;
        }
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/jspf/menu_medico.jspf" />

    <div class="container">
      <h1><i class="fas fa-file-medical"></i> Prontuário Médico</h1>

      <c:if test="${prontuario != null}">
        <!-- Cabeçalho do Paciente -->
        <div class="patient-header">
          <div class="patient-name">
            <i class="fas fa-user-injured"></i> ${prontuario.nomePaciente}
          </div>
          <div class="consultation-info">
            <div class="info-item">
              <i class="fas fa-calendar-day"></i>
              <span>Data: ${prontuario.dataHoraCompleta}</span>
            </div>
            <div class="info-item">
              <i class="fas fa-user-md"></i>
              <span>Médico: ${prontuario.nomeMedico}</span>
            </div>
          </div>
        </div>

        <!-- Anamnese -->
        <div class="section">
          <h3 class="section-title">
            <i class="fas fa-clipboard-list"></i> Anamnese
          </h3>
          <div class="section-content">
            <c:choose>
              <c:when test="${not empty prontuario.anamnese}">
                ${prontuario.anamnese}
              </c:when>
              <c:otherwise>
                <span class="empty-content">Nenhuma informação registrada</span>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <!-- Exame Físico -->
        <div class="section">
          <h3 class="section-title">
            <i class="fas fa-stethoscope"></i> Exame Físico
          </h3>
          <div class="section-content">
            <c:choose>
              <c:when test="${not empty prontuario.exameFisico}">
                ${prontuario.exameFisico}
              </c:when>
              <c:otherwise>
                <span class="empty-content">Nenhuma informação registrada</span>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <!-- Hipótese Diagnóstica -->
        <div class="section">
          <h3 class="section-title">
            <i class="fas fa-diagnoses"></i> Hipótese Diagnóstica
          </h3>
          <div class="section-content">
            <c:choose>
              <c:when test="${not empty prontuario.hipoteseDiagnostica}">
                ${prontuario.hipoteseDiagnostica}
              </c:when>
              <c:otherwise>
                <span class="empty-content">Nenhuma informação registrada</span>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <!-- Conduta Médica -->
        <div class="section">
          <h3 class="section-title">
            <i class="fas fa-prescription"></i> Conduta Médica
          </h3>
          <div class="section-content">
            <c:choose>
              <c:when test="${not empty prontuario.condutaMedica}">
                ${prontuario.condutaMedica}
              </c:when>
              <c:otherwise>
                <span class="empty-content">Nenhuma informação registrada</span>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <!-- Observações -->
        <div class="section">
          <h3 class="section-title">
            <i class="fas fa-comment-medical"></i> Observações
          </h3>
          <div class="section-content">
            <c:choose>
              <c:when test="${not empty prontuario.observacoes}">
                ${prontuario.observacoes}
              </c:when>
              <c:otherwise>
                <span class="empty-content">Nenhuma observação registrada</span>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </c:if>

      <div class="btn-group">
        <a
          href="${pageContext.request.contextPath}/meus_prontuarios"
          class="btn btn-secondary"
        >
          <i class="fas fa-arrow-left"></i> Voltar aos Prontuários
        </a>
      </div>
    </div>
  </body>
</html>
