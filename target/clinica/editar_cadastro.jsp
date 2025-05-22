<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="com.mack.clinica.model.Usuario" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Editar Cadastro - Clínica Médica</title>
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/css/style.css"
    />
    <style>
      body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f0f4f8;
        color: #333;
        margin: 0;
        padding: 0;
      }
      .container {
        width: 90%;
        max-width: 800px;
        margin: 20px auto;
        padding: 25px;
        background-color: #fff;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        border-radius: 12px;
      }
      h1 {
        color: #2c3e50;
        text-align: center;
        margin-bottom: 25px;
        font-weight: 600;
      }
      .form-group {
        margin-bottom: 20px;
      }

      label {
        display: block;
        margin-bottom: 8px;
        color: #2c3e50;
        font-weight: 500;
      }

      input[type='text'],
      input[type='email'],
      input[type='tel'],
      input[type='date'] {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 6px;
        font-size: 16px;
        transition: border-color 0.3s, box-shadow 0.3s;
        box-sizing: border-box;
      }

      input[type='text']:focus,
      input[type='email']:focus,
      input[type='tel']:focus,
      input[type='date']:focus {
        border-color: #3498db;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        outline: none;
      }

      .readonly {
        background-color: #f5f5f5;
        cursor: not-allowed;
      }

      .required::after {
        content: '*';
        color: #e74c3c;
        margin-left: 4px;
      }

      .buttons {
        display: flex;
        justify-content: space-between;
        margin-top: 30px;
        gap: 15px;
      }

      .button {
        flex: 1;
        padding: 12px 25px;
        background-color: #3498db;
        color: white;
        text-decoration: none;
        border-radius: 6px;
        font-weight: 500;
        border: none;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s;
        text-align: center;
      }

      .button:hover {
        background-color: #2980b9;
      }

      .button-secondary {
        background-color: #7f8c8d;
      }

      .button-secondary:hover {
        background-color: #6c7a7d;
      }

      .error-message {
        background-color: #f8d7da;
        color: #721c24;
        padding: 15px;
        border-radius: 6px;
        margin-bottom: 20px;
        text-align: center;
      }

      .help-text {
        display: block;
        margin-top: 5px;
        color: #7f8c8d;
        font-size: 14px;
      }

      @media (max-width: 768px) {
        .container {
          width: 95%;
          padding: 15px;
        }
        .buttons {
          flex-direction: column;
        }
        .button {
          width: 100%;
        }
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/jspf/menu_paciente.jspf" />

    <div class="container">
      <h1>Editar Dados Cadastrais</h1>

      <!-- Mensagens de erro -->
      <c:if test="${erro != null}">
        <div class="error-message">
          <c:choose>
            <c:when test="${erro == 'nome_email_obrigatorios'}">
              Nome e e-mail são campos obrigatórios.
            </c:when>
            <c:when test="${erro == 'email_existente'}">
              Este e-mail já está sendo usado por outro usuário.
            </c:when>
            <c:when test="${erro == 'falha_atualizacao'}">
              Não foi possível atualizar seus dados. Por favor, tente novamente.
            </c:when>
            <c:otherwise>
              Ocorreu um erro ao processar sua solicitação. Por favor, tente
              novamente.
            </c:otherwise>
          </c:choose>
        </div>
      </c:if>

      <c:if test="${paciente != null}">
        <form
          method="post"
          action="${pageContext.request.contextPath}/meu_cadastro"
        >
          <div class="form-group">
            <label for="id">ID:</label>
            <input
              type="text"
              id="id"
              name="id"
              value="${paciente.id}"
              readonly
              class="readonly"
            />
          </div>

          <div class="form-group">
            <label for="nome" class="required">Nome Completo:</label>
            <input
              type="text"
              id="nome"
              name="nome"
              value="${paciente.nome}"
              required
            />
          </div>

          <div class="form-group">
            <label for="email" class="required">Email:</label>
            <input
              type="email"
              id="email"
              name="email"
              value="${paciente.email}"
              required
            />
          </div>

          <div class="form-group">
            <label for="cpf">CPF:</label>
            <input
              type="text"
              id="cpf"
              name="cpf"
              value="${paciente.cpf}"
              readonly
              class="readonly"
            />
            <span class="help-text">O CPF não pode ser alterado.</span>
          </div>

          <div class="form-group">
            <label for="celular">Celular:</label>
            <input
              type="tel"
              id="celular"
              name="celular"
              value="${paciente.celular}"
              pattern="[0-9]{10,11}"
              title="Digite apenas números, incluindo o DDD"
            />
            <span class="help-text"
              >Formato: apenas números com DDD (ex: 11987654321)</span
            >
          </div>

          <div class="form-group">
            <label for="dataNascimento">Data de Nascimento:</label>
            <input
              type="date"
              id="dataNascimento"
              name="dataNascimento"
              value="${paciente.dataNascimento}"
            />
          </div>

          <div class="form-group">
            <label for="tipo">Tipo de Usuário:</label>
            <input
              type="text"
              id="tipo"
              name="tipo"
              value="${paciente.tipo}"
              readonly
              class="readonly"
            />
          </div>

          <div class="buttons">
            <a
              href="${pageContext.request.contextPath}/meu_cadastro"
              class="button button-secondary"
              >Cancelar</a
            >
            <button type="submit" class="button">Salvar Alterações</button>
          </div>
        </form>
      </c:if>
    </div>

    <script>
      // Formatar a data de nascimento para o input type="date"
      document.addEventListener('DOMContentLoaded', function () {
        const dataNascimentoInput = document.getElementById('dataNascimento')
        if (dataNascimentoInput) {
          try {
            // Se a data estiver no formato brasileiro (dd/mm/yyyy), converte para o formato do input date (yyyy-mm-dd)
            const dataNascimento = '${paciente.getFormattedDataNascimento()}'
            if (
              dataNascimento &&
              dataNascimento !== 'Não informada' &&
              dataNascimento !== ''
            ) {
              const parts = dataNascimento.split('/')
              if (parts.length === 3) {
                const formattedDate = `${parts[2]}-${parts[1].padStart(
                  2,
                  '0'
                )}-${parts[0].padStart(2, '0')}`
                dataNascimentoInput.value = formattedDate
              }
            }
          } catch (e) {
            console.error('Erro ao formatar data:', e)
          }
        }
      })
    </script>
  </body>
</html>
