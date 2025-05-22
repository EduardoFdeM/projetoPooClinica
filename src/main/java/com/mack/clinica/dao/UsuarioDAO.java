package com.mack.clinica.dao;

import com.mack.clinica.model.Usuario;
import com.mack.clinica.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletContext;

public class UsuarioDAO {

  private ServletContext context;

  public UsuarioDAO(ServletContext context) {
    this.context = context;
  }

  public Usuario getUsuarioById(int id) {
    Usuario usuario = null;
    String sql = "SELECT id, nome, email, cpf, celular, tipo, created_at FROM usuarios WHERE id = ?";

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
      }
    } catch (SQLException e) {
      System.err.println("Erro ao buscar usuário por ID: " + e.getMessage());
      e.printStackTrace();
    }
    return usuario;
  }

  // Outros métodos CRUD (create, update, delete, listAll) podem ser adicionados
  // aqui
  // por exemplo, getUsuarioByEmailParaLogin, createUsuario, updateUsuario,
  // deleteUsuario, getAllUsuarios, etc.
}