<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <title>Painel do Administrador</title>
    <!-- Importa o CSS externo -->
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/css/style.css"
    />
  </head>
  <body>
    <jsp:include page="/WEB-INF/jspf/menu_admin.jspf" />

    <!-- Conteúdo principal -->
    <div class="content">
      <h1>Painel do Administrador</h1>
      <p>
        Bem-vindo ao painel administrativo. Aqui você poderá gerenciar pacientes
        e consultas.
      </p>
    </div>
  </body>
</html>
