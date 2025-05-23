<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Configurações - Clínica Médica</title>
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
      .config-sections {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
        gap: 20px;
      }
      .config-section {
        background: white;
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        border: 2px solid #e9ecef;
      }
      .section-header {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
        padding-bottom: 15px;
        border-bottom: 2px solid #f8f9fa;
      }
      .section-icon {
        width: 50px;
        height: 50px;
        background: linear-gradient(135deg, #667eea, #764ba2);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        color: white;
        margin-right: 15px;
      }
      .config-section h3 {
        color: #2c3e50;
        margin: 0;
        font-weight: 600;
      }
      .form-group {
        margin-bottom: 20px;
      }
      .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 500;
        color: #2c3e50;
      }
      .form-control {
        width: 100%;
        padding: 12px;
        font-size: 1rem;
        line-height: 1.5;
        color: #495057;
        background-color: #fff;
        border: 1px solid #ced4da;
        border-radius: 6px;
        transition: border-color 0.15s ease-in-out;
      }
      .form-control:focus {
        border-color: #4299e1;
        outline: 0;
        box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.25);
      }
      .btn {
        display: inline-block;
        padding: 12px 24px;
        background-color: #3498db;
        color: white;
        text-decoration: none;
        border-radius: 6px;
        transition: background-color 0.3s;
        font-weight: 500;
        border: none;
        cursor: pointer;
        font-size: 0.9rem;
      }
      .btn:hover {
        background-color: #2980b9;
        text-decoration: none;
      }
      .btn-success {
        background-color: #27ae60;
      }
      .btn-success:hover {
        background-color: #219a54;
      }
      .btn-danger {
        background-color: #e74c3c;
      }
      .btn-danger:hover {
        background-color: #c0392b;
      }
      .coming-soon {
        background: linear-gradient(135deg, #f093fb, #f5576c);
        color: white;
        padding: 30px;
        border-radius: 12px;
        text-align: center;
        margin-bottom: 20px;
      }
      .coming-soon h2 {
        margin: 0 0 15px 0;
        font-size: 2rem;
      }
      .coming-soon p {
        margin: 0;
        font-size: 1.1rem;
        opacity: 0.9;
      }
      .system-info {
        background-color: #f8f9fa;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 20px;
      }
      .info-item {
        display: flex;
        justify-content: space-between;
        padding: 8px 0;
        border-bottom: 1px solid #e9ecef;
      }
      .info-item:last-child {
        border-bottom: none;
      }
      .info-label {
        font-weight: 500;
        color: #495057;
      }
      .info-value {
        color: #6c757d;
      }
      .toggle-switch {
        position: relative;
        width: 60px;
        height: 30px;
        background-color: #ccc;
        border-radius: 15px;
        cursor: pointer;
        transition: background-color 0.3s;
      }
      .toggle-switch.active {
        background-color: #3498db;
      }
      .toggle-switch::before {
        content: '';
        position: absolute;
        width: 24px;
        height: 24px;
        border-radius: 50%;
        background-color: white;
        top: 3px;
        left: 3px;
        transition: transform 0.3s;
      }
      .toggle-switch.active::before {
        transform: translateX(30px);
      }

      /* Responsividade */
      @media screen and (max-width: 768px) {
        .config-sections {
          grid-template-columns: 1fr;
        }
        .coming-soon h2 {
          font-size: 1.5rem;
        }
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/jspf/menu_admin.jspf" />

    <div class="container">
      <h1><i class="fas fa-cog"></i> Configurações do Sistema</h1>

      <!-- Seção em Desenvolvimento -->
      <div class="coming-soon">
        <h2><i class="fas fa-tools"></i> Em Desenvolvimento</h2>
        <p>
          O módulo de Configurações está sendo desenvolvido e estará disponível
          em breve.
        </p>
      </div>

      <!-- Informações do Sistema -->
      <div class="system-info">
        <h3><i class="fas fa-info-circle"></i> Informações do Sistema</h3>
        <div class="info-item">
          <span class="info-label">Versão do Sistema:</span>
          <span class="info-value">1.0.0</span>
        </div>
        <div class="info-item">
          <span class="info-label">Banco de Dados:</span>
          <span class="info-value">SQLite</span>
        </div>
        <div class="info-item">
          <span class="info-label">Servidor:</span>
          <span class="info-value">Jetty</span>
        </div>
        <div class="info-item">
          <span class="info-label">Java Version:</span>
          <span class="info-value"
            ><%=System.getProperty("java.version")%></span
          >
        </div>
      </div>

      <!-- Seções de Configuração -->
      <div class="config-sections">
        <!-- Configurações Gerais -->
        <div class="config-section">
          <div class="section-header">
            <div class="section-icon">
              <i class="fas fa-cogs"></i>
            </div>
            <h3>Configurações Gerais</h3>
          </div>

          <form>
            <div class="form-group">
              <label for="nomeClinica">Nome da Clínica:</label>
              <input
                type="text"
                id="nomeClinica"
                class="form-control"
                value="Clínica Médica"
                placeholder="Nome da clínica"
              />
            </div>

            <div class="form-group">
              <label for="endereco">Endereço:</label>
              <input
                type="text"
                id="endereco"
                class="form-control"
                placeholder="Endereço da clínica"
              />
            </div>

            <div class="form-group">
              <label for="telefone">Telefone:</label>
              <input
                type="tel"
                id="telefone"
                class="form-control"
                placeholder="(11) 1234-5678"
              />
            </div>

            <button
              type="button"
              class="btn btn-success"
              onclick="alert('Funcionalidade em desenvolvimento!')"
            >
              <i class="fas fa-save"></i> Salvar Alterações
            </button>
          </form>
        </div>

        <!-- Configurações de Email -->
        <div class="config-section">
          <div class="section-header">
            <div class="section-icon">
              <i class="fas fa-envelope"></i>
            </div>
            <h3>Configurações de Email</h3>
          </div>

          <form>
            <div class="form-group">
              <label for="smtpHost">Servidor SMTP:</label>
              <input
                type="text"
                id="smtpHost"
                class="form-control"
                placeholder="smtp.gmail.com"
              />
            </div>

            <div class="form-group">
              <label for="smtpPort">Porta SMTP:</label>
              <input
                type="number"
                id="smtpPort"
                class="form-control"
                placeholder="587"
              />
            </div>

            <div class="form-group">
              <label for="emailUsuario">Email do Sistema:</label>
              <input
                type="email"
                id="emailUsuario"
                class="form-control"
                placeholder="sistema@clinica.com"
              />
            </div>

            <button
              type="button"
              class="btn btn-success"
              onclick="alert('Funcionalidade em desenvolvimento!')"
            >
              <i class="fas fa-save"></i> Salvar Configurações
            </button>
          </form>
        </div>

        <!-- Configurações de Segurança -->
        <div class="config-section">
          <div class="section-header">
            <div class="section-icon">
              <i class="fas fa-shield-alt"></i>
            </div>
            <h3>Configurações de Segurança</h3>
          </div>

          <div class="form-group">
            <label>Autenticação em Duas Etapas:</label>
            <div class="toggle-switch" onclick="toggleSetting(this)"></div>
          </div>

          <div class="form-group">
            <label>Logs de Acesso:</label>
            <div
              class="toggle-switch active"
              onclick="toggleSetting(this)"
            ></div>
          </div>

          <div class="form-group">
            <label>Bloqueio por Tentativas:</label>
            <div
              class="toggle-switch active"
              onclick="toggleSetting(this)"
            ></div>
          </div>

          <button
            type="button"
            class="btn btn-success"
            onclick="alert('Funcionalidade em desenvolvimento!')"
          >
            <i class="fas fa-save"></i> Aplicar Configurações
          </button>
        </div>

        <!-- Backup e Manutenção -->
        <div class="config-section">
          <div class="section-header">
            <div class="section-icon">
              <i class="fas fa-database"></i>
            </div>
            <h3>Backup e Manutenção</h3>
          </div>

          <div class="form-group">
            <label>Backup Automático:</label>
            <div
              class="toggle-switch active"
              onclick="toggleSetting(this)"
            ></div>
          </div>

          <div class="form-group">
            <label for="backupFrequencia">Frequência do Backup:</label>
            <select id="backupFrequencia" class="form-control">
              <option value="diario">Diário</option>
              <option value="semanal">Semanal</option>
              <option value="mensal">Mensal</option>
            </select>
          </div>

          <div style="display: flex; gap: 10px; margin-top: 20px">
            <button
              type="button"
              class="btn"
              onclick="alert('Funcionalidade em desenvolvimento!')"
            >
              <i class="fas fa-download"></i> Backup Manual
            </button>
            <button
              type="button"
              class="btn btn-danger"
              onclick="alert('Funcionalidade em desenvolvimento!')"
            >
              <i class="fas fa-broom"></i> Limpar Logs
            </button>
          </div>
        </div>

        <!-- Configurações da Interface -->
        <div class="config-section">
          <div class="section-header">
            <div class="section-icon">
              <i class="fas fa-palette"></i>
            </div>
            <h3>Interface do Usuário</h3>
          </div>

          <div class="form-group">
            <label for="tema">Tema:</label>
            <select id="tema" class="form-control">
              <option value="claro">Claro</option>
              <option value="escuro">Escuro</option>
              <option value="auto">Automático</option>
            </select>
          </div>

          <div class="form-group">
            <label for="idioma">Idioma:</label>
            <select id="idioma" class="form-control">
              <option value="pt-BR">Português (Brasil)</option>
              <option value="en-US">English (US)</option>
              <option value="es-ES">Español</option>
            </select>
          </div>

          <button
            type="button"
            class="btn btn-success"
            onclick="alert('Funcionalidade em desenvolvimento!')"
          >
            <i class="fas fa-save"></i> Aplicar Tema
          </button>
        </div>

        <!-- Configurações de Notificações -->
        <div class="config-section">
          <div class="section-header">
            <div class="section-icon">
              <i class="fas fa-bell"></i>
            </div>
            <h3>Notificações</h3>
          </div>

          <div class="form-group">
            <label>Notificações por Email:</label>
            <div
              class="toggle-switch active"
              onclick="toggleSetting(this)"
            ></div>
          </div>

          <div class="form-group">
            <label>Alertas de Sistema:</label>
            <div
              class="toggle-switch active"
              onclick="toggleSetting(this)"
            ></div>
          </div>

          <div class="form-group">
            <label>Lembrete de Consultas:</label>
            <div
              class="toggle-switch active"
              onclick="toggleSetting(this)"
            ></div>
          </div>

          <button
            type="button"
            class="btn btn-success"
            onclick="alert('Funcionalidade em desenvolvimento!')"
          >
            <i class="fas fa-save"></i> Salvar Preferências
          </button>
        </div>
      </div>
    </div>

    <script>
      function toggleSetting(element) {
        element.classList.toggle('active')
      }

      // Adicionar animações aos cards
      document.addEventListener('DOMContentLoaded', function () {
        const sections = document.querySelectorAll('.config-section')
        sections.forEach((section, index) => {
          setTimeout(() => {
            section.style.opacity = '0'
            section.style.transform = 'translateY(20px)'
            section.style.transition = 'opacity 0.6s ease, transform 0.6s ease'

            setTimeout(() => {
              section.style.opacity = '1'
              section.style.transform = 'translateY(0)'
            }, 100)
          }, index * 150)
        })
      })
    </script>
  </body>
</html>
