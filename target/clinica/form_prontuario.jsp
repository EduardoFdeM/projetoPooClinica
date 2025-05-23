<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${prontuario != null ? 'Editar' : 'Nova'} Ficha Clínica - Clínica Médica</title>
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
        .form-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .form-section h3 {
            color: #2c3e50;
            margin: 0 0 15px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #e9ecef;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
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
        textarea.form-control {
            min-height: 120px;
            resize: vertical;
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
            border: none;
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
        
        /* Responsividade */
        @media screen and (max-width: 768px) {
            .container {
                width: 95%;
                padding: 15px;
            }
            .form-row {
                grid-template-columns: 1fr;
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
        <h1><i class="fas fa-file-medical"></i> ${prontuario != null ? 'Editar' : 'Nova'} Ficha Clínica</h1>
        
        <!-- Alertas de Erro -->
        <c:if test="${param.error != null}">
            <div class="alert alert-danger">
                <c:choose>
                    <c:when test="${param.error == 'campos_obrigatorios'}">
                        Preencha todos os campos obrigatórios.
                    </c:when>
                    <c:when test="${param.error == 'falha_criar'}">
                        Erro ao criar ficha clínica. Tente novamente.
                    </c:when>
                    <c:when test="${param.error == 'falha_atualizar'}">
                        Erro ao atualizar ficha clínica. Tente novamente.
                    </c:when>
                    <c:otherwise>
                        Ocorreu um erro. Tente novamente.
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/ficha_clinica">
            <c:choose>
                <c:when test="${prontuario != null}">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${prontuario.id}">
                </c:when>
                <c:otherwise>
                    <input type="hidden" name="action" value="create">
                </c:otherwise>
            </c:choose>

            <!-- Informações Básicas -->
            <div class="form-section">
                <h3><i class="fas fa-info-circle"></i> Informações Básicas</h3>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="pacienteId">Paciente<span class="required">*</span></label>
                        <select id="pacienteId" name="pacienteId" class="form-control" required ${prontuario != null ? 'disabled' : ''}>
                            <option value="">Selecione o paciente</option>
                            <c:forEach var="paciente" items="${pacientes}">
                                <option value="${paciente.id}" ${prontuario != null && prontuario.pacienteId == paciente.id ? 'selected' : ''}>
                                    ${paciente.nome}
                                </option>
                            </c:forEach>
                        </select>
                        <c:if test="${prontuario != null}">
                            <input type="hidden" name="pacienteId" value="${prontuario.pacienteId}">
                        </c:if>
                    </div>

                    <div class="form-group">
                        <label for="medicoId">Médico<span class="required">*</span></label>
                        <select id="medicoId" name="medicoId" class="form-control" required ${prontuario != null ? 'disabled' : ''}>
                            <option value="">Selecione o médico</option>
                            <c:forEach var="medico" items="${medicos}">
                                <option value="${medico.id}" ${prontuario != null && prontuario.medicoId == medico.id ? 'selected' : ''}>
                                    ${medico.nome}
                                </option>
                            </c:forEach>
                        </select>
                        <c:if test="${prontuario != null}">
                            <input type="hidden" name="medicoId" value="${prontuario.medicoId}">
                        </c:if>
                    </div>
                </div>

                <c:if test="${prontuario == null}">
                    <div class="form-group">
                        <label for="dataConsulta">Data da Consulta<span class="required">*</span></label>
                        <input type="date" id="dataConsulta" name="dataConsulta" class="form-control" required
                               value="${prontuario != null ? prontuario.dataConsulta : ''}">
                    </div>
                </c:if>

                <c:if test="${prontuario == null}">
                    <div class="form-group">
                        <label for="horarioConsulta">Horário da Consulta</label>
                        <input type="time" id="horarioConsulta" name="horarioConsulta" class="form-control"
                               value="${prontuario != null ? prontuario.horarioConsulta : ''}"
                               placeholder="Ex: 14:30">
                    </div>
                </c:if>
            </div>

            <!-- Anamnese -->
            <div class="form-section">
                <h3><i class="fas fa-clipboard-list"></i> Anamnese</h3>
                
                <div class="form-group">
                    <label for="anamnese">História Clínica e Queixa Principal</label>
                    <textarea id="anamnese" name="anamnese" class="form-control" 
                              placeholder="Descreva a história clínica do paciente, queixa principal, história da doença atual...">${prontuario != null ? prontuario.anamnese : ''}</textarea>
                </div>
            </div>

            <!-- Exame Físico -->
            <div class="form-section">
                <h3><i class="fas fa-stethoscope"></i> Exame Físico</h3>
                
                <div class="form-group">
                    <label for="exameFisico">Dados do Exame Físico</label>
                    <textarea id="exameFisico" name="exameFisico" class="form-control" 
                              placeholder="Sinais vitais, exame físico geral e específico...">${prontuario != null ? prontuario.exameFisico : ''}</textarea>
                </div>
            </div>

            <!-- Diagnóstico e Conduta -->
            <div class="form-section">
                <h3><i class="fas fa-diagnoses"></i> Diagnóstico e Conduta</h3>
                
                <div class="form-group">
                    <label for="hipoteseDiagnostica">Hipótese Diagnóstica</label>
                    <textarea id="hipoteseDiagnostica" name="hipoteseDiagnostica" class="form-control" 
                              placeholder="Diagnóstico principal e diagnósticos diferenciais...">${prontuario != null ? prontuario.hipoteseDiagnostica : ''}</textarea>
                </div>

                <div class="form-group">
                    <label for="condutaMedica">Conduta Médica</label>
                    <textarea id="condutaMedica" name="condutaMedica" class="form-control" 
                              placeholder="Prescrições, orientações, solicitação de exames...">${prontuario != null ? prontuario.condutaMedica : ''}</textarea>
                </div>
            </div>

            <!-- Observações -->
            <div class="form-section">
                <h3><i class="fas fa-comment-medical"></i> Observações Adicionais</h3>
                
                <div class="form-group">
                    <label for="observacoes">Observações</label>
                    <textarea id="observacoes" name="observacoes" class="form-control" 
                              placeholder="Observações gerais, recomendações para retorno...">${prontuario != null ? prontuario.observacoes : ''}</textarea>
                </div>
            </div>

            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/ficha_clinica" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Cancelar
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Salvar Ficha Clínica
                </button>
            </div>
        </form>
    </div>

    <script>
        // Definir data atual como padrão
        document.addEventListener('DOMContentLoaded', function() {
            const dataConsulta = document.getElementById('dataConsulta');
            if (dataConsulta && !dataConsulta.value) {
                const hoje = new Date().toISOString().split('T')[0];
                dataConsulta.value = hoje;
            }
        });
    </script>
</body>
</html>