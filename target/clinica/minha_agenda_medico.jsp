<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minha Agenda - Clínica Médica</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
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
        .alert {
            padding: 12px 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: 500;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            background-color: white;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #e9ecef;
        }
        th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #495057;
        }
        tr:hover {
            background-color: #f8f9fa;
        }
        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            text-align: center;
            min-width: 80px;
        }
        .status-agendada {
            background-color: #cce5ff;
            color: #0066cc;
        }
        .status-confirmada {
            background-color: #d4edda;
            color: #155724;
        }
        .status-realizada {
            background-color: #e2e3e5;
            color: #383d41;
        }
        .status-cancelada {
            background-color: #f5c6cb;
            color: #721c24;
        }
        .status-select {
            padding: 4px 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 0.9rem;
        }
        .btn {
            display: inline-block;
            padding: 6px 12px;
            font-size: 0.9rem;
            text-decoration: none;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-sm {
            padding: 4px 8px;
            font-size: 0.8rem;
        }
        .no-consultations {
            text-align: center;
            padding: 40px;
            background-color: #f8f9fa;
            border-radius: 8px;
            color: #6c757d;
        }
        .no-consultations i {
            font-size: 3rem;
            margin-bottom: 15px;
            color: #bbb;
        }
        
        /* Responsividade */
        @media screen and (max-width: 768px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }
            thead tr {
                position: absolute;
                top: -9999px;
                left: -9999px;
            }
            tr {
                border: 1px solid #ddd;
                margin-bottom: 10px;
                border-radius: 5px;
                overflow: hidden;
            }
            td {
                border: none;
                border-bottom: 1px solid #eee;
                position: relative;
                padding-left: 50%;
                white-space: normal;
                text-align: right;
            }
            td:before {
                position: absolute;
                top: 12px;
                left: 10px;
                width: 45%;
                padding-right: 10px;
                white-space: nowrap;
                text-align: left;
                font-weight: bold;
                content: attr(data-label);
            }
            td:last-child {
                border-bottom: 0;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/jspf/menu_medico.jspf" />

    <div class="container">
        <h1><i class="fas fa-calendar-check"></i> Minha Agenda Médica</h1>

        <!-- Alertas de Sucesso/Erro -->
        <c:if test="${param.success != null}">
            <div class="alert alert-success">
                <c:choose>
                    <c:when test="${param.success == 'status_updated'}">
                        Status da consulta atualizado com sucesso!
                    </c:when>
                </c:choose>
            </div>
        </c:if>

        <c:if test="${param.error != null}">
            <div class="alert alert-danger">
                <c:choose>
                    <c:when test="${param.error == 'update_failed'}">
                        Erro ao atualizar status da consulta.
                    </c:when>
                    <c:when test="${param.error == 'internal_error'}">
                        Erro interno do sistema. Tente novamente.
                    </c:when>
                    <c:otherwise>
                        Ocorreu um erro. Tente novamente.
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${empty consultas}">
                <div class="no-consultations">
                    <i class="fas fa-calendar-times"></i>
                    <h3>Nenhuma consulta agendada</h3>
                    <p>Você não possui consultas agendadas no momento.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Data/Hora</th>
                            <th>Paciente</th>
                            <th>Status</th>
                            <th>Observações</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="consulta" items="${consultas}">
                            <tr>
                                <td data-label="Data/Hora:">
                                    ${consulta.formattedDataHora}
                                </td>
                                <td data-label="Paciente:">
                                    ${consulta.nomePaciente}
                                </td>
                                <td data-label="Status:">
                                    <span class="status-badge status-${consulta.status}">
                                        <c:choose>
                                            <c:when test="${consulta.status == 'agendada'}">Agendada</c:when>
                                            <c:when test="${consulta.status == 'confirmada'}">Confirmada</c:when>
                                            <c:when test="${consulta.status == 'realizada'}">Realizada</c:when>
                                            <c:when test="${consulta.status == 'cancelada'}">Cancelada</c:when>
                                            <c:otherwise>${consulta.status}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>
                                <td data-label="Observações:">
                                    ${not empty consulta.observacoes ? consulta.observacoes : '-'}
                                </td>
                                <td data-label="Ações:">
                                    <form style="display: inline-block;" method="get" action="${pageContext.request.contextPath}/minha_agenda_medico">
                                        <input type="hidden" name="action" value="update_status">
                                        <input type="hidden" name="consultaId" value="${consulta.id}">
                                        <select name="status" class="status-select" onchange="this.form.submit()">
                                            <option value="agendada" ${consulta.status == 'agendada' ? 'selected' : ''}>Agendada</option>
                                            <option value="confirmada" ${consulta.status == 'confirmada' ? 'selected' : ''}>Confirmada</option>
                                            <option value="realizada" ${consulta.status == 'realizada' ? 'selected' : ''}>Realizada</option>
                                            <option value="cancelada" ${consulta.status == 'cancelada' ? 'selected' : ''}>Cancelada</option>
                                        </select>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        // Confirma a mudança de status
        document.querySelectorAll('.status-select').forEach(select => {
            select.addEventListener('change', function(e) {
                if (!confirm('Tem certeza que deseja alterar o status desta consulta?')) {
                    // Reverter para o valor original se cancelar
                    this.selectedIndex = this.getAttribute('data-original-index');
                    e.preventDefault();
                    return false;
                }
            });
            
            // Salva o índice original
            select.setAttribute('data-original-index', select.selectedIndex);
        });
    </script>
</body>
</html> 