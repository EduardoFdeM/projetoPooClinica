package com.mack.clinica.dao;

import com.mack.clinica.model.Usuario;
import com.mack.clinica.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletContext;

public class UsuarioDAO {

  private ServletContext context;

  public UsuarioDAO(ServletContext context) {
    this.context = context;
  }

  public Usuario getUsuarioById(int id) {
    Usuario usuario = null;
    String sql = "SELECT id, nome, email, cpf, celular, tipo, created_at, data_nascimento FROM usuarios WHERE id = ?";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setInt(1, id);
      ResultSet rs = stmt.executeQuery();

      if (rs.next()) {
        usuario = new Usuario();
        usuario.setId(rs.getInt("id"));
        usuario.setNome(rs.getString("nome"));
        usuario.setEmail(rs.getString("email"));
        usuario.setCpf(rs.getString("cpf"));
        usuario.setCelular(rs.getString("celular"));
        usuario.setTipo(rs.getString("tipo"));
        usuario.setCreatedAtFromString(rs.getString("created_at"));

        // Adicionar data de nascimento (pode ser null)
        String dataNascimentoStr = rs.getString("data_nascimento");
        if (dataNascimentoStr != null) {
          usuario.setDataNascimentoFromString(dataNascimentoStr);
        }
      }
    } catch (SQLException e) {
      System.err.println("Erro ao buscar usuário por ID: " + e.getMessage());
      e.printStackTrace();
    }
    return usuario;
  }

  /**
   * Lista todos os pacientes cadastrados
   */
  public List<Usuario> listarPacientes() {
    List<Usuario> pacientes = new ArrayList<>();
    String sql = "SELECT id, nome, email, cpf, celular, created_at, data_nascimento FROM usuarios WHERE tipo = 'paciente' ORDER BY nome";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery()) {

      while (rs.next()) {
        Usuario paciente = new Usuario();
        paciente.setId(rs.getInt("id"));
        paciente.setNome(rs.getString("nome"));
        paciente.setEmail(rs.getString("email"));
        paciente.setCpf(rs.getString("cpf"));
        paciente.setCelular(rs.getString("celular"));
        paciente.setTipo("paciente"); // Pois estamos filtrando por tipo = 'paciente'
        paciente.setCreatedAtFromString(rs.getString("created_at"));

        // Adicionar data de nascimento (pode ser null)
        String dataNascimentoStr = rs.getString("data_nascimento");
        if (dataNascimentoStr != null) {
          paciente.setDataNascimentoFromString(dataNascimentoStr);
        }

        pacientes.add(paciente);
      }
    } catch (SQLException e) {
      System.err.println("Erro ao listar pacientes: " + e.getMessage());
      e.printStackTrace();
    }
    return pacientes;
  }

  /**
   * Cria um novo paciente
   * 
   * @return ID do paciente criado ou -1 em caso de erro
   */
  public int criarPaciente(Usuario paciente) {
    int novoId = -1;
    String sql = "INSERT INTO usuarios (nome, email, cpf, celular, tipo, senha, created_at, data_nascimento) VALUES (?, ?, ?, ?, 'paciente', ?, datetime('now'), ?)";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

      stmt.setString(1, paciente.getNome());
      stmt.setString(2, paciente.getEmail());
      stmt.setString(3, paciente.getCpf());
      stmt.setString(4, paciente.getCelular());
      stmt.setString(5, paciente.getSenha());

      // Adicionar data de nascimento (pode ser null)
      if (paciente.getDataNascimento() != null) {
        stmt.setString(6, paciente.getDataNascimento().toString());
      } else {
        stmt.setNull(6, java.sql.Types.VARCHAR);
      }

      int linhasAfetadas = stmt.executeUpdate();
      if (linhasAfetadas > 0) {
        try (ResultSet rs = stmt.getGeneratedKeys()) {
          if (rs.next()) {
            novoId = rs.getInt(1);
          }
        }
      }
    } catch (SQLException e) {
      System.err.println("Erro ao criar paciente: " + e.getMessage());
      e.printStackTrace();
    }
    return novoId;
  }

  /**
   * Atualiza os dados de um paciente existente
   * 
   * @return true se a atualização foi bem-sucedida, false caso contrário
   */
  public boolean atualizarPaciente(Usuario paciente) {
    String sql = "UPDATE usuarios SET nome = ?, email = ?, cpf = ?, celular = ?, data_nascimento = ? WHERE id = ? AND tipo = 'paciente'";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setString(1, paciente.getNome());
      stmt.setString(2, paciente.getEmail());
      stmt.setString(3, paciente.getCpf());
      stmt.setString(4, paciente.getCelular());

      // Adicionar data de nascimento (pode ser null)
      if (paciente.getDataNascimento() != null) {
        stmt.setString(5, paciente.getDataNascimento().toString());
      } else {
        stmt.setNull(5, java.sql.Types.VARCHAR);
      }

      stmt.setInt(6, paciente.getId());

      int linhasAfetadas = stmt.executeUpdate();
      return linhasAfetadas > 0;
    } catch (SQLException e) {
      System.err.println("Erro ao atualizar paciente: " + e.getMessage());
      e.printStackTrace();
      return false;
    }
  }

  /**
   * Atualiza apenas os campos permitidos de um paciente (nome, email, celular,
   * data_nascimento)
   * 
   * @return true se a atualização foi bem-sucedida, false caso contrário
   */
  public boolean atualizarDadosPaciente(Usuario paciente) {
    String sql = "UPDATE usuarios SET nome = ?, email = ?, celular = ?, data_nascimento = ? WHERE id = ? AND tipo = 'paciente'";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setString(1, paciente.getNome());
      stmt.setString(2, paciente.getEmail());
      stmt.setString(3, paciente.getCelular());

      // Adicionar data de nascimento (pode ser null)
      if (paciente.getDataNascimento() != null) {
        stmt.setString(4, paciente.getDataNascimento().toString());
      } else {
        stmt.setNull(4, java.sql.Types.VARCHAR);
      }

      stmt.setInt(5, paciente.getId());

      int linhasAfetadas = stmt.executeUpdate();
      return linhasAfetadas > 0;
    } catch (SQLException e) {
      System.err.println("Erro ao atualizar dados do paciente: " + e.getMessage());
      e.printStackTrace();
      return false;
    }
  }

  /**
   * Exclui um paciente pelo ID
   * 
   * @return true se a exclusão foi bem-sucedida, false caso contrário
   */
  public boolean excluirPaciente(int id) {
    String sql = "DELETE FROM usuarios WHERE id = ? AND tipo = 'paciente'";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setInt(1, id);

      int linhasAfetadas = stmt.executeUpdate();
      return linhasAfetadas > 0;
    } catch (SQLException e) {
      System.err.println("Erro ao excluir paciente: " + e.getMessage());
      e.printStackTrace();
      return false;
    }
  }

  /**
   * Atualiza a senha de um paciente
   * 
   * @return true se a atualização foi bem-sucedida, false caso contrário
   */
  public boolean atualizarSenhaPaciente(int id, String novaSenha) {
    String sql = "UPDATE usuarios SET senha = ? WHERE id = ? AND tipo = 'paciente'";

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setString(1, novaSenha);
      stmt.setInt(2, id);

      int linhasAfetadas = stmt.executeUpdate();
      return linhasAfetadas > 0;
    } catch (SQLException e) {
      System.err.println("Erro ao atualizar senha do paciente: " + e.getMessage());
      e.printStackTrace();
      return false;
    }
  }

  /**
   * Verifica se um e-mail já existe para outro paciente (usado para validação)
   * 
   * @return true se já existe, false caso contrário
   */
  public boolean emailJaExiste(String email, Integer idExcecao) {
    String sql = "SELECT COUNT(*) as total FROM usuarios WHERE email = ? AND tipo = 'paciente'";

    // Se fornecido um ID de exceção, não considera o paciente com este ID
    if (idExcecao != null) {
      sql += " AND id != ?";
    }

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setString(1, email);

      if (idExcecao != null) {
        stmt.setInt(2, idExcecao);
      }

      ResultSet rs = stmt.executeQuery();
      if (rs.next()) {
        return rs.getInt("total") > 0;
      }
    } catch (SQLException e) {
      System.err.println("Erro ao verificar disponibilidade de email: " + e.getMessage());
      e.printStackTrace();
    }
    return false;
  }

  /**
   * Verifica se um e-mail ou CPF já existe para outro paciente (usado para
   * validação)
   * 
   * @return true se já existe, false caso contrário
   */
  public boolean emailOuCpfJaExiste(String email, String cpf, Integer idExcecao) {
    String sql = "SELECT COUNT(*) as total FROM usuarios WHERE (email = ? OR cpf = ?) AND tipo = 'paciente'";

    // Se fornecido um ID de exceção, não considera o paciente com este ID
    if (idExcecao != null) {
      sql += " AND id != ?";
    }

    try (Connection conn = DBUtil.getConnection(this.context);
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setString(1, email);
      stmt.setString(2, cpf);

      if (idExcecao != null) {
        stmt.setInt(3, idExcecao);
      }

      ResultSet rs = stmt.executeQuery();
      if (rs.next()) {
        return rs.getInt("total") > 0;
      }
    } catch (SQLException e) {
      System.err.println("Erro ao verificar disponibilidade de email/cpf: " + e.getMessage());
      e.printStackTrace();
    }
    return false;
  }

/**   * Lista todos os médicos cadastrados   */  public List<Usuario> listarMedicos() {    List<Usuario> medicos = new ArrayList<>();    String sql = "SELECT id, nome, email, cpf, celular, created_at, data_nascimento FROM usuarios WHERE tipo = 'medico' ORDER BY nome";    try (Connection conn = DBUtil.getConnection(this.context);        PreparedStatement stmt = conn.prepareStatement(sql);        ResultSet rs = stmt.executeQuery()) {      while (rs.next()) {        Usuario medico = new Usuario();        medico.setId(rs.getInt("id"));        medico.setNome(rs.getString("nome"));        medico.setEmail(rs.getString("email"));        medico.setCpf(rs.getString("cpf"));        medico.setCelular(rs.getString("celular"));        medico.setTipo("medico"); // Pois estamos filtrando por tipo = 'medico'        medico.setCreatedAtFromString(rs.getString("created_at"));        // Adicionar data de nascimento (pode ser null)        String dataNascimentoStr = rs.getString("data_nascimento");        if (dataNascimentoStr != null) {          medico.setDataNascimentoFromString(dataNascimentoStr);        }        medicos.add(medico);      }    } catch (SQLException e) {      System.err.println("Erro ao listar médicos: " + e.getMessage());      e.printStackTrace();    }    return medicos;  }  /**   * Cria um novo médico   *    * @return ID do médico criado ou -1 em caso de erro   */  public int criarMedico(Usuario medico) {    int novoId = -1;    String sql = "INSERT INTO usuarios (nome, email, cpf, celular, tipo, senha, created_at, data_nascimento) VALUES (?, ?, ?, ?, 'medico', ?, datetime('now'), ?)";    try (Connection conn = DBUtil.getConnection(this.context);        PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {      stmt.setString(1, medico.getNome());      stmt.setString(2, medico.getEmail());      stmt.setString(3, medico.getCpf());      stmt.setString(4, medico.getCelular());      stmt.setString(5, medico.getSenha());      // Adicionar data de nascimento (pode ser null)      if (medico.getDataNascimento() != null) {        stmt.setString(6, medico.getDataNascimento().toString());      } else {        stmt.setNull(6, java.sql.Types.VARCHAR);      }      int linhasAfetadas = stmt.executeUpdate();      if (linhasAfetadas > 0) {        try (ResultSet rs = stmt.getGeneratedKeys()) {          if (rs.next()) {            novoId = rs.getInt(1);          }        }      }    } catch (SQLException e) {      System.err.println("Erro ao criar médico: " + e.getMessage());      e.printStackTrace();    }    return novoId;  }  /**   * Atualiza os dados de um médico existente   *    * @return true se a atualização foi bem-sucedida, false caso contrário   */  public boolean atualizarMedico(Usuario medico) {    String sql = "UPDATE usuarios SET nome = ?, email = ?, cpf = ?, celular = ?, data_nascimento = ? WHERE id = ? AND tipo = 'medico'";    try (Connection conn = DBUtil.getConnection(this.context);        PreparedStatement stmt = conn.prepareStatement(sql)) {      stmt.setString(1, medico.getNome());      stmt.setString(2, medico.getEmail());      stmt.setString(3, medico.getCpf());      stmt.setString(4, medico.getCelular());      // Adicionar data de nascimento (pode ser null)      if (medico.getDataNascimento() != null) {        stmt.setString(5, medico.getDataNascimento().toString());      } else {        stmt.setNull(5, java.sql.Types.VARCHAR);      }      stmt.setInt(6, medico.getId());      int linhasAfetadas = stmt.executeUpdate();      return linhasAfetadas > 0;    } catch (SQLException e) {      System.err.println("Erro ao atualizar médico: " + e.getMessage());      e.printStackTrace();      return false;    }  }  /**   * Exclui um médico pelo ID   *    * @return true se a exclusão foi bem-sucedida, false caso contrário   */  public boolean excluirMedico(int id) {    String sql = "DELETE FROM usuarios WHERE id = ? AND tipo = 'medico'";    try (Connection conn = DBUtil.getConnection(this.context);        PreparedStatement stmt = conn.prepareStatement(sql)) {      stmt.setInt(1, id);      int linhasAfetadas = stmt.executeUpdate();      return linhasAfetadas > 0;    } catch (SQLException e) {      System.err.println("Erro ao excluir médico: " + e.getMessage());      e.printStackTrace();      return false;    }  }  /**   * Atualiza a senha de um médico   *    * @return true se a atualização foi bem-sucedida, false caso contrário   */  public boolean atualizarSenhaMedico(int id, String novaSenha) {    String sql = "UPDATE usuarios SET senha = ? WHERE id = ? AND tipo = 'medico'";    try (Connection conn = DBUtil.getConnection(this.context);        PreparedStatement stmt = conn.prepareStatement(sql)) {      stmt.setString(1, novaSenha);      stmt.setInt(2, id);      int linhasAfetadas = stmt.executeUpdate();      return linhasAfetadas > 0;    } catch (SQLException e) {      System.err.println("Erro ao atualizar senha do médico: " + e.getMessage());      e.printStackTrace();      return false;    }  }  /**   * Verifica se um e-mail ou CPF já existe para outro médico (usado para validação)   *    * @return true se já existe, false caso contrário   */  public boolean emailOuCpfJaExisteMedico(String email, String cpf, Integer idExcecao) {    String sql = "SELECT COUNT(*) as total FROM usuarios WHERE (email = ? OR cpf = ?) AND tipo = 'medico'";    // Se fornecido um ID de exceção, não considera o médico com este ID    if (idExcecao != null) {      sql += " AND id != ?";    }    try (Connection conn = DBUtil.getConnection(this.context);        PreparedStatement stmt = conn.prepareStatement(sql)) {      stmt.setString(1, email);      stmt.setString(2, cpf);      if (idExcecao != null) {        stmt.setInt(3, idExcecao);      }      ResultSet rs = stmt.executeQuery();      if (rs.next()) {        return rs.getInt("total") > 0;      }    } catch (SQLException e) {      System.err.println("Erro ao verificar disponibilidade de email/cpf para médico: " + e.getMessage());      e.printStackTrace();    }    return false;  }}