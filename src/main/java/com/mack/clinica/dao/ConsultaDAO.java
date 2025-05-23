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

  /**
   * Conta todas as consultas no sistema
   * 
   * @return número total de consultas
   */
  public int contarTodasConsultas() {
    String sql = "SELECT COUNT(*) as total FROM consultas";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery()) {

      if (rs.next()) {
        return rs.getInt("total");
      }
    } catch (SQLException e) {
      System.err.println("Erro ao contar consultas: " + e.getMessage());
      e.printStackTrace();
    }
    return 0;
  }

  /**
   * Conta o número de consultas para hoje
   * 
   * @return número de consultas de hoje
   */
  public int contarConsultasHoje() {
    String sql = "SELECT COUNT(*) as total FROM consultas WHERE DATE(data_hora) = DATE('now')";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery()) {

      if (rs.next()) {
        return rs.getInt("total");
      }
    } catch (SQLException e) {
      System.err.println("Erro ao contar consultas de hoje: " + e.getMessage());
      e.printStackTrace();
    }
    return 0;
  }

  /**
   * Lista todas as consultas (para administradores)
   * 
   * @return lista de todas as consultas com informações de paciente e
   *         profissional
   */
  public List<Consulta> listarTodasConsultas() {
    List<Consulta> consultas = new ArrayList<>();
    String sql = "SELECT c.id, c.paciente_id, c.profissional_id, c.data_hora, c.status, c.observacoes, " +
        "u1.nome AS nome_paciente, u2.nome AS nome_profissional " +
        "FROM consultas c " +
        "JOIN usuarios u1 ON c.paciente_id = u1.id " +
        "JOIN usuarios u2 ON c.profissional_id = u2.id " +
        "ORDER BY c.data_hora DESC";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery()) {

      while (rs.next()) {
        Consulta consulta = new Consulta();
        consulta.setId(rs.getInt("id"));
        consulta.setPacienteId(rs.getInt("paciente_id"));
        consulta.setProfissionalId(rs.getInt("profissional_id"));
        consulta.setDataHoraFromString(rs.getString("data_hora"));
        consulta.setStatus(rs.getString("status"));
        consulta.setObservacoes(rs.getString("observacoes"));
        consulta.setNomeProfissional(rs.getString("nome_profissional"));
        consulta.setNomePaciente(rs.getString("nome_paciente"));
        consulta.setNomeMedico(rs.getString("nome_profissional")); // nomeMedico é um alias para nomeProfissional
        consultas.add(consulta);
      }
    } catch (SQLException e) {
      System.err.println("Erro ao listar todas as consultas: " + e.getMessage());
      e.printStackTrace();
    }
    return consultas;
  }

  /**
   * Lista consultas por médico/profissional
   * 
   * @param profissionalId ID do médico/profissional
   * @return lista de consultas do médico
   */
  public List<Consulta> getConsultasByProfissionalId(int profissionalId) {
    List<Consulta> consultas = new ArrayList<>();
    String sql = "SELECT c.id, c.paciente_id, c.profissional_id, c.data_hora, c.status, c.observacoes, " +
        "u.nome AS nome_paciente " +
        "FROM consultas c " +
        "JOIN usuarios u ON c.paciente_id = u.id " +
        "WHERE c.profissional_id = ? " +
        "ORDER BY c.data_hora ASC";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setInt(1, profissionalId);
      ResultSet rs = stmt.executeQuery();

      while (rs.next()) {
        Consulta consulta = new Consulta();
        consulta.setId(rs.getInt("id"));
        consulta.setPacienteId(rs.getInt("paciente_id"));
        consulta.setProfissionalId(rs.getInt("profissional_id"));
        consulta.setDataHoraFromString(rs.getString("data_hora"));
        consulta.setStatus(rs.getString("status"));
        consulta.setObservacoes(rs.getString("observacoes"));
        consulta.setNomePaciente(rs.getString("nome_paciente"));
        consultas.add(consulta);
      }
    } catch (SQLException e) {
      System.err.println("Erro ao buscar consultas do profissional: " + e.getMessage());
      e.printStackTrace();
    }
    return consultas;
  }

  /**
   * Atualiza o status de uma consulta
   * 
   * @param consultaId ID da consulta
   * @param novoStatus Novo status da consulta
   * @return true se a atualização foi bem-sucedida
   */
  public boolean atualizarStatusConsulta(int consultaId, String novoStatus) {
    String sql = "UPDATE consultas SET status = ? WHERE id = ?";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setString(1, novoStatus);
      stmt.setInt(2, consultaId);

      return stmt.executeUpdate() > 0;
    } catch (SQLException e) {
      System.err.println("Erro ao atualizar status da consulta: " + e.getMessage());
      e.printStackTrace();
      return false;
    }
  }

  /**
   * Busca uma consulta por ID
   * 
   * @param consultaId ID da consulta
   * @return consulta encontrada ou null
   */
  public Consulta getConsultaById(int consultaId) {
    String sql = "SELECT c.id, c.paciente_id, c.profissional_id, c.data_hora, c.status, c.observacoes, " +
        "u1.nome AS nome_paciente, u2.nome AS nome_profissional " +
        "FROM consultas c " +
        "JOIN usuarios u1 ON c.paciente_id = u1.id " +
        "JOIN usuarios u2 ON c.profissional_id = u2.id " +
        "WHERE c.id = ?";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setInt(1, consultaId);
      ResultSet rs = stmt.executeQuery();

      if (rs.next()) {
        Consulta consulta = new Consulta();
        consulta.setId(rs.getInt("id"));
        consulta.setPacienteId(rs.getInt("paciente_id"));
        consulta.setProfissionalId(rs.getInt("profissional_id"));
        consulta.setDataHoraFromString(rs.getString("data_hora"));
        consulta.setStatus(rs.getString("status"));
        consulta.setObservacoes(rs.getString("observacoes"));
        consulta.setNomePaciente(rs.getString("nome_paciente"));
        consulta.setNomeMedico(rs.getString("nome_profissional"));
        return consulta;
      }
    } catch (SQLException e) {
      System.err.println("Erro ao buscar consulta por ID: " + e.getMessage());
      e.printStackTrace();
    }
    return null;
  }

  // Outros métodos como getConsultaById, updateStatusConsulta, etc., podem ser
  // adicionados aqui.
}