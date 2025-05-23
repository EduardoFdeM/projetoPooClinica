package com.mack.clinica.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mack.clinica.util.DBUtil;
import jakarta.servlet.ServletContext;

public class AgendarConsultaDAO {

    private ServletContext context;

    public AgendarConsultaDAO(ServletContext context) {
        this.context = context;
    }

    public boolean agendarConsulta(int pacienteId, int profissionalId, String dataHora, String observacoes) {
        String sql = "INSERT INTO consultas (paciente_id, profissional_id, data_hora, status, observacoes) VALUES (?, ?, ?, 'agendada', ?)";

        try (Connection conn = DBUtil.getConnection(this.context)) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, pacienteId);
            stmt.setInt(2, profissionalId);
            stmt.setString(3, dataHora);
            stmt.setString(4, observacoes != null ? observacoes : "");
            int linhasAfetadas = stmt.executeUpdate();
            System.out.println("Linhas afetadas: " + linhasAfetadas);
            return linhasAfetadas > 0;
        } catch (SQLException e) {
            System.err.println("Erro ao agendar consulta: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public List<Usuario> listarMedicos() {
        List<Usuario> medicos = new ArrayList<>();
        String sql = "SELECT id, nome FROM usuarios WHERE tipo = 'medico'";

        try (Connection conn = DBUtil.getConnection(this.context);
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                medicos.add(u);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar médicos: " + e.getMessage());
        }

        return medicos;
    }

}
