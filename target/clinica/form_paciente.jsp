<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.mack.clinica.model.Usuario" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${paciente != null ? 'Editar' : 'Cadastrar'} Paciente - Clínica Médica</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
            max-width: 800px;
            margin: 20px auto;
            padding: 25px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        h1 {
            color: #2c3e50;
            margin-bottom: 25px;
            font-weight: 600;
            text-align: center;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
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
        .btn-group {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        .btn {
            display: inline-block;
            font-weight: 400;
            text-align: center;
            vertical-align: middle;
            cursor: pointer;
            padding: 10px 20px;
            font-size: 1rem;
            line-height: 1.5;
            border-radius: 5px;
            transition: all 0.15s ease-in-out;
            text-decoration: none;
        }
        .btn-primary {
            color: #fff;
            background-color: #3498db;
            border: 1px solid #3498db;
        }
        .btn-primary:hover {
            background-color: #2980b9;
            border-color: #2980b9;
        }
        .btn-secondary {
            color: #fff;
            background-color: #6c757d;
            border: 1px solid #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #5a6268;
        }
        .alert {
            padding: 12px 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: 500;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .required {
            color: #e74c3c;
            margin-left: 5px;
        }
        .help-text {
            display: block;
            margin-top: 5px;
            font-size: 0.875rem;
            color: #6c757d;
        }
        
        /* Responsividade */
        @media screen and (max-width: 768px) {
            .container {
                width: 95%;
                padding: 15px;
            }
            .btn-group {
                flex-direction: column;
                gap: 10px;
            }
            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/jspf/menu_admin.jspf" />

    <div class="container">
        <h1>${paciente != null ? 'Editar' : 'Cadastrar'} Paciente</h1>
        
        <!-- Alertas de Erro -->
        <c:if test="${param.error != null}">
            <div class="alert alert-danger">
                <c:choose>
                    <c:when test="${param.error == 'campos_obrigatorios'}">
                        Preencha todos os campos obrigatórios.
                    </c:when>
                    <c:when test="${param.error == 'email_cpf_existente'}">
                        Email ou CPF já cadastrado para outro paciente.
                    </c:when>
                    <c:when test="${param.error == 'falha_criar'}">
                        Erro ao cadastrar paciente. Tente novamente.
                    </c:when>
                    <c:when test="${param.error == 'falha_atualizar'}">
                        Erro ao atualizar paciente. Tente novamente.
                    </c:when>
                    <c:otherwise>
                        Ocorreu um erro. Tente novamente.
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/pacientes">
            <c:choose>
                <c:when test="${paciente != null}">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${paciente.id}">
                </c:when>
                <c:otherwise>
                    <input type="hidden" name="action" value="create">
                </c:otherwise>
            </c:choose>

            <div class="form-group">
                <label for="nome">Nome Completo<span class="required">*</span></label>
                <input type="text" id="nome" name="nome" class="form-control" required
                       value="${paciente != null ? paciente.nome : ''}">
            </div>

            <div class="form-group">
                <label for="email">Email<span class="required">*</span></label>
                <input type="email" id="email" name="email" class="form-control" required
                       value="${paciente != null ? paciente.email : ''}">
            </div>

            <div class="form-group">
                <label for="cpf">CPF<span class="required">*</span></label>
                <input type="text" id="cpf" name="cpf" class="form-control" required
                       pattern="[0-9]{11}" title="Digite apenas os 11 números do CPF"
                       value="${paciente != null ? paciente.cpf : ''}">
                <small class="help-text">Digite apenas os números, sem pontos ou traços.</small>
            </div>

            <div class="form-group">
                <label for="celular">Celular</label>
                <input type="tel" id="celular" name="celular" class="form-control"
                       pattern="[0-9]{10,11}" title="Digite o DDD seguido do número"
                       value="${paciente != null ? paciente.celular : ''}">
                <small class="help-text">Digite apenas os números, incluindo o DDD.</small>
            </div>

            <div class="form-group">
                <label for="senha">${paciente != null ? 'Nova Senha (deixe em branco para manter a atual)' : 'Senha'}<span class="${paciente != null ? '' : 'required'}">*</span></label>
                <input type="password" id="senha" name="senha" class="form-control" 
                       ${paciente != null ? '' : 'required'}>
                <c:if test="${paciente != null}">
                    <small class="help-text">Preencha apenas se desejar alterar a senha atual.</small>
                </c:if>
            </div>

            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/pacientes" class="btn btn-secondary">Cancelar</a>
                <button type="submit" class="btn btn-primary">Salvar</button>
            </div>
        </form>
    </div>
</body>
</html> 