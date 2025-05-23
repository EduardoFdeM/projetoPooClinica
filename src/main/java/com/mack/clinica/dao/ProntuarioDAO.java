package com.mack.clinica.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mack.clinica.model.Prontuario;
import com.mack.clinica.util.DBUtil;

import jakarta.servlet.ServletContext;

public class ProntuarioDAO {

  private ServletContext context;

  public ProntuarioDAO(ServletContext context) {
    this.context = context;
  }

  public boolean criarProntuario(Prontuario prontuario) {
    String sql = "INSERT INTO prontuarios (paciente_id, profissional_id, data_consulta, horario_consulta, anamnese, exame_fisico, hipotese_diagnostica, conduta_medica, observacoes) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setInt(1, prontuario.getPacienteId());
      stmt.setInt(2, prontuario.getMedicoId());
      stmt.setString(3, prontuario.getDataConsulta());
      stmt.setString(4, prontuario.getHorarioConsulta());
      stmt.setString(5, prontuario.getAnamnese());
      stmt.setString(6, prontuario.getExameFisico());
      stmt.setString(7, prontuario.getHipoteseDiagnostica());
      stmt.setString(8, prontuario.getCondutaMedica());
      stmt.setString(9, prontuario.getObservacoes());

      return stmt.executeUpdate() > 0;
    } catch (SQLException e) {
      System.err.println("Erro ao criar prontuário: " + e.getMessage());
      e.printStackTrace();
      return false;
    }
  }

  public List<Prontuario> listarTodosProntuarios() {
    List<Prontuario> prontuarios = new ArrayList<>();
    String sql = "SELECT p.*, u1.nome as nome_paciente, u2.nome as nome_medico " +
        "FROM prontuarios p " +
        "LEFT JOIN usuarios u1 ON p.paciente_id = u1.id " +
        "LEFT JOIN usuarios u2 ON p.profissional_id = u2.id " +
        "ORDER BY p.data_consulta DESC";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery()) {

      while (rs.next()) {
        Prontuario prontuario = new Prontuario();
        prontuario.setId(rs.getInt("id"));
        prontuario.setPacienteId(rs.getInt("paciente_id"));
        prontuario.setMedicoId(rs.getInt("profissional_id"));
        prontuario.setDataConsulta(rs.getString("data_consulta"));
        prontuario.setHorarioConsulta(rs.getString("horario_consulta"));
        prontuario.setAnamnese(rs.getString("anamnese"));
        prontuario.setExameFisico(rs.getString("exame_fisico"));
        prontuario.setHipoteseDiagnostica(rs.getString("hipotese_diagnostica"));
        prontuario.setCondutaMedica(rs.getString("conduta_medica"));
        prontuario.setObservacoes(rs.getString("observacoes"));
        prontuario.setNomePaciente(rs.getString("nome_paciente"));
        prontuario.setNomeMedico(rs.getString("nome_medico"));
        prontuarios.add(prontuario);
      }
    } catch (SQLException e) {
      System.err.println("Erro ao listar prontuários: " + e.getMessage());
      e.printStackTrace();
    }
    return prontuarios;
  }

  public List<Prontuario> listarProntuariosPorPaciente(int pacienteId) {
    List<Prontuario> prontuarios = new ArrayList<>();
    String sql = "SELECT p.*, u1.nome as nome_paciente, u2.nome as nome_medico " +
        "FROM prontuarios p " +
        "LEFT JOIN usuarios u1 ON p.paciente_id = u1.id " +
        "LEFT JOIN usuarios u2 ON p.profissional_id = u2.id " +
        "WHERE p.paciente_id = ? " +
        "ORDER BY p.data_consulta DESC";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setInt(1, pacienteId);
      ResultSet rs = stmt.executeQuery();

      while (rs.next()) {
        Prontuario prontuario = new Prontuario();
        prontuario.setId(rs.getInt("id"));
        prontuario.setPacienteId(rs.getInt("paciente_id"));
        prontuario.setMedicoId(rs.getInt("profissional_id"));
        prontuario.setDataConsulta(rs.getString("data_consulta"));
        prontuario.setHorarioConsulta(rs.getString("horario_consulta"));
        prontuario.setAnamnese(rs.getString("anamnese"));
        prontuario.setExameFisico(rs.getString("exame_fisico"));
        prontuario.setHipoteseDiagnostica(rs.getString("hipotese_diagnostica"));
        prontuario.setCondutaMedica(rs.getString("conduta_medica"));
        prontuario.setObservacoes(rs.getString("observacoes"));
        prontuario.setNomePaciente(rs.getString("nome_paciente"));
        prontuario.setNomeMedico(rs.getString("nome_medico"));
        prontuarios.add(prontuario);
      }
    } catch (SQLException e) {
      System.err.println("Erro ao listar prontuários do paciente: " + e.getMessage());
      e.printStackTrace();
    }
    return prontuarios;
  }

  public Prontuario buscarProntuarioPorId(int id) {
    String sql = "SELECT p.*, u1.nome as nome_paciente, u2.nome as nome_medico " +
        "FROM prontuarios p " +
        "LEFT JOIN usuarios u1 ON p.paciente_id = u1.id " +
        "LEFT JOIN usuarios u2 ON p.profissional_id = u2.id " +
        "WHERE p.id = ?";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setInt(1, id);
      ResultSet rs = stmt.executeQuery();

      if (rs.next()) {
        Prontuario prontuario = new Prontuario();
        prontuario.setId(rs.getInt("id"));
        prontuario.setPacienteId(rs.getInt("paciente_id"));
        prontuario.setMedicoId(rs.getInt("profissional_id"));
        prontuario.setDataConsulta(rs.getString("data_consulta"));
        prontuario.setHorarioConsulta(rs.getString("horario_consulta"));
        prontuario.setAnamnese(rs.getString("anamnese"));
        prontuario.setExameFisico(rs.getString("exame_fisico"));
        prontuario.setHipoteseDiagnostica(rs.getString("hipotese_diagnostica"));
        prontuario.setCondutaMedica(rs.getString("conduta_medica"));
        prontuario.setObservacoes(rs.getString("observacoes"));
        prontuario.setNomePaciente(rs.getString("nome_paciente"));
        prontuario.setNomeMedico(rs.getString("nome_medico"));
        return prontuario;
      }
    } catch (SQLException e) {
      System.err.println("Erro ao buscar prontuário: " + e.getMessage());
      e.printStackTrace();
    }
    return null;
  }

  public boolean atualizarProntuario(Prontuario prontuario) {
    String sql = "UPDATE prontuarios SET anamnese = ?, exame_fisico = ?, hipotese_diagnostica = ?, conduta_medica = ?, observacoes = ? WHERE id = ?";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setString(1, prontuario.getAnamnese());
      stmt.setString(2, prontuario.getExameFisico());
      stmt.setString(3, prontuario.getHipoteseDiagnostica());
      stmt.setString(4, prontuario.getCondutaMedica());
      stmt.setString(5, prontuario.getObservacoes());
      stmt.setInt(6, prontuario.getId());

      return stmt.executeUpdate() > 0;
    } catch (SQLException e) {
      System.err.println("Erro ao atualizar prontuário: " + e.getMessage());
      e.printStackTrace();
      return false;
    }
  }

  public boolean excluirProntuario(int id) {
    String sql = "DELETE FROM prontuarios WHERE id = ?";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setInt(1, id);
      return stmt.executeUpdate() > 0;
    } catch (SQLException e) {
      System.err.println("Erro ao excluir prontuário: " + e.getMessage());
      e.printStackTrace();
      return false;
    }
  }

  /**
   * Conta o total de prontuários/fichas clínicas no sistema
   * 
   * @return número total de prontuários
   */
  public int contarTotalProntuarios() {
    String sql = "SELECT COUNT(*) as total FROM prontuarios";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery()) {

      if (rs.next()) {
        return rs.getInt("total");
      }
    } catch (SQLException e) {
      System.err.println("Erro ao contar prontuários: " + e.getMessage());
      e.printStackTrace();
    }
    return 0;
  }

  /**
   * Lista prontuários por médico específico
   * 
   * @param medicoId ID do médico
   * @return lista de prontuários do médico
   */
  public List<Prontuario> listarProntuariosPorMedico(int medicoId) {
    List<Prontuario> prontuarios = new ArrayList<>();
    String sql = "SELECT p.*, u1.nome as nome_paciente, u2.nome as nome_medico " +
        "FROM prontuarios p " +
        "LEFT JOIN usuarios u1 ON p.paciente_id = u1.id " +
        "LEFT JOIN usuarios u2 ON p.profissional_id = u2.id " +
        "WHERE p.profissional_id = ? " +
        "ORDER BY p.data_consulta DESC";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setInt(1, medicoId);
      ResultSet rs = stmt.executeQuery();

      while (rs.next()) {
        Prontuario prontuario = new Prontuario();
        prontuario.setId(rs.getInt("id"));
        prontuario.setPacienteId(rs.getInt("paciente_id"));
        prontuario.setMedicoId(rs.getInt("profissional_id"));
        prontuario.setDataConsulta(rs.getString("data_consulta"));
        prontuario.setHorarioConsulta(rs.getString("horario_consulta"));
        prontuario.setAnamnese(rs.getString("anamnese"));
        prontuario.setExameFisico(rs.getString("exame_fisico"));
        prontuario.setHipoteseDiagnostica(rs.getString("hipotese_diagnostica"));
        prontuario.setCondutaMedica(rs.getString("conduta_medica"));
        prontuario.setObservacoes(rs.getString("observacoes"));
        prontuario.setNomePaciente(rs.getString("nome_paciente"));
        prontuario.setNomeMedico(rs.getString("nome_medico"));
        prontuarios.add(prontuario);
      }
    } catch (SQLException e) {
      System.err.println("Erro ao listar prontuários do médico: " + e.getMessage());
      e.printStackTrace();
    }
    return prontuarios;
  }
}