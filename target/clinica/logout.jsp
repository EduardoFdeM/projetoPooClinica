<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ page session="true" %>
<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Logout - Clínica Médica</title>
    <meta
      http-equiv="refresh"
      content="3;URL=${pageContext.request.contextPath}/index.jsp"
    />
    <style>
      body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #3498db, #2c3e50);
        text-align: center;
        margin: 0;
        padding: 20px;
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
      }

      .logout-container {
        background-color: white;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        width: 90%;
        max-width: 450px;
        transition: all 0.3s ease;
      }

      .logout-container:hover {
        transform: translateY(-2px);
        box-shadow: 0 15px 40px rgba(0, 0, 0, 0.25);
      }

      .logo {
        margin-bottom: 25px;
      }

      .logo h1 {
        color: #2c3e50;
        margin: 0;
        font-size: 28px;
        font-weight: 600;
        letter-spacing: -0.5px;
      }

      h2 {
        color: #2c3e50;
        margin-top: 0;
        margin-bottom: 20px;
        font-size: 22px;
        font-weight: 500;
      }

      p {
        color: #7f8c8d;
        font-size: 16px;
        margin-bottom: 30px;
        line-height: 1.5;
      }

      .loader {
        display: inline-block;
        width: 50px;
        height: 50px;
        border: 3px solid rgba(52, 152, 219, 0.2);
        border-radius: 50%;
        border-top-color: #3498db;
        animation: spin 1s ease-in-out infinite;
        margin-bottom: 25px;
      }

      @keyframes spin {
        to {
          transform: rotate(360deg);
        }
      }

      .redirect-link {
        display: inline-block;
        color: #3498db;
        text-decoration: none;
        font-weight: 500;
        font-size: 14px;
        transition: all 0.3s ease;
      }

      .redirect-link:hover {
        text-decoration: underline;
        color: #2980b9;
      }

      /* Responsividade */
      @media screen and (max-width: 480px) {
        .logout-container {
          padding: 30px 25px;
          margin: 15px;
          max-width: 90%;
        }

        .logo h1 {
          font-size: 24px;
        }

        h2 {
          font-size: 20px;
        }

        p {
          font-size: 15px;
        }
      }
    </style>
  </head>
  <body>
    <% // Invalida a sessão atual session.invalidate(); %>

    <div class="logout-container">
      <div class="logo">
        <h1>Clínica Médica</h1>
      </div>

      <h2>Logout Realizado</h2>
      <p>
        Você foi desconectado com sucesso. Redirecionando para a página de
        login...
      </p>

      <div class="loader"></div>

      <a
        href="${pageContext.request.contextPath}/index.jsp"
        class="redirect-link"
      >
        Clique aqui se não for redirecionado automaticamente
      </a>
    </div>
  </body>
</html>
