package com.mack.clinica.dao;

import com.mack.clinica.model.Consulta;
import com.mack.clinica.util.DBUtil;
import jakarta.servlet.ServletContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ConsultaDAO {

  private ServletContext context;

  public ConsultaDAO(ServletContext context) {
    this.context = context;
  }

  public List<Consulta> getConsultasByPacienteId(int pacienteId) {
    List<Consulta> consultas = new ArrayList<>();
    // SQL que junta a tabela consultas com a tabela usuarios para pegar o nome do
    // profissional
    String sql = "SELECT c.id, c.paciente_id, c.profissional_id, c.data_hora, c.status, c.observacoes, u.nome AS nome_profissional "
        +
        "FROM consultas c " +
        "JOIN usuarios u ON c.profissional_id = u.id " +
        "WHERE c.paciente_id = ? " +
        "ORDER BY c.data_hora DESC"; // Ordena pelas mais recentes primeiro

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setInt(1, pacienteId);
      ResultSet rs = stmt.executeQuery();

      while (rs.next()) {
        Consulta consulta = new Consulta();
        consulta.setId(rs.getInt("id"));
        consulta.setPacienteId(rs.getInt("paciente_id"));
        consulta.setProfissionalId(rs.getInt("profissional_id"));
        consulta.setDataHoraFromString(rs.getString("data_hora"));
        consulta.setStatus(rs.getString("status"));
        consulta.setObservacoes(rs.getString("observacoes"));
        consulta.setNomeProfissional(rs.getString("nome_profissional"));
        consultas.add(consulta);
      }
    } catch (SQLException e) {
      System.err.println("Erro ao buscar consultas do paciente: " + e.getMessage());
      e.printStackTrace();
    }
    return consultas;
  }

  // Outros métodos como getConsultaById, updateStatusConsulta, etc., podem ser
  // adicionados aqui.
}