<%@ page contentType="text/html; charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login - Clínica Médica</title>
    <link rel="stylesheet" type="text/css" href="css/index.css" />
  </head>
  <body>
    <div class="login-container">
      <div class="logo">
        <h1>Clínica Médica</h1>
      </div>

      <h2>Acesso ao Sistema</h2>

      <c:if test="${param.erro != null}">
        <div class="error-message">
          <c:choose>
            <c:when test="${param.erro == 'login'}">
              Email ou senha incorretos. Tente novamente.
            </c:when>
            <c:when test="${param.erro == 'tipo'}">
              Tipo de usuário não autorizado.
            </c:when>
            <c:when test="${param.erro == 'sessao'}">
              Sua sessão expirou. Por favor, faça login novamente.
            </c:when>
            <c:otherwise>
              Ocorreu um erro. Por favor, tente novamente.
            </c:otherwise>
          </c:choose>
        </div>
      </c:if>

      <form method="post" action="loginAction">
        <div class="input-group">
          <label for="email">E-mail:</label>
          <input
            type="email"
            id="email"
            name="email"
            required
            autofocus
            placeholder="Digite seu e-mail"
          />
        </div>

        <div class="input-group">
          <label for="senha">Senha:</label>
          <input
            type="password"
            id="senha"
            name="senha"
            required
            placeholder="Digite sua senha"
          />
        </div>

        <button type="submit">Entrar no Sistema</button>
      </form>

      <p class="info-text">
        Entre com suas credenciais para acessar o sistema médico.
      </p>
    </div>
  </body>
</html>
