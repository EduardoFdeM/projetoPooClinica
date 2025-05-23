-- Script para verificar e corrigir a tabela prontuarios manualmente
-- Execute este script se ainda houver problemas com a tabela

-- 1. Ver a estrutura atual da tabela (se existir)
.schema prontuarios

-- 2. Ver todos os dados da tabela (se existir)
SELECT * FROM prontuarios;

-- 3. Se houver problemas, remover e recriar a tabela
DROP TABLE IF EXISTS prontuarios;

-- 4. Criar a tabela com estrutura correta
CREATE TABLE prontuarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    paciente_id INTEGER NOT NULL,
    profissional_id INTEGER NOT NULL,
    data_consulta TEXT NOT NULL,
    anamnese TEXT,
    exame_fisico TEXT,
    hipotese_diagnostica TEXT,
    conduta_medica TEXT,
    observacoes TEXT,
    FOREIGN KEY (paciente_id) REFERENCES usuarios(id),
    FOREIGN KEY (profissional_id) REFERENCES usuarios(id)
);

-- 5. Verificar se a tabela foi criada corretamente
.schema prontuarios

-- 6. Inserir dados de teste (opcional)
-- INSERT INTO prontuarios (paciente_id, profissional_id, data_consulta, anamnese, exame_fisico, hipotese_diagnostica, conduta_medica, observacoes) 
-- VALUES (1, 2, '2024-01-15', 'Paciente relata dor de cabeça', 'Pressão arterial normal', 'Cefaleia tensional', 'Analgésico via oral', 'Retorno em 7 dias'); 