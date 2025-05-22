package com.mack.clinica.util;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import jakarta.servlet.ServletContext;

/**
 * Utilitário para realizar migrações no banco de dados.
 */
public class DbMigrationUtil {

  /**
   * Adiciona a coluna data_nascimento à tabela usuarios, se ela ainda não
   * existir.
   * 
   * @param context O ServletContext para obter a conexão com o banco
   * @return true se a coluna foi adicionada com sucesso ou já existia, false em
   *         caso de erro
   */
  public static boolean adicionarColunaDataNascimento(ServletContext context) {
    try (Connection conn = DBUtil.getConnection(context)) {
      // Verifica se a coluna já existe
      if (!colunaExiste(conn, "usuarios", "data_nascimento")) {
        // Executa o ALTER TABLE para adicionar a coluna
        try (Statement stmt = conn.createStatement()) {
          String sql = "ALTER TABLE usuarios ADD COLUMN data_nascimento TEXT;";
          stmt.executeUpdate(sql);
          System.out.println("Coluna data_nascimento adicionada com sucesso à tabela usuarios.");
          return true;
        }
      } else {
        System.out.println("A coluna data_nascimento já existe na tabela usuarios.");
        return true;
      }
    } catch (SQLException e) {
      System.err.println("Erro ao adicionar coluna data_nascimento: " + e.getMessage());
      e.printStackTrace();
      return false;
    }
  }

  /**
   * Verifica se uma coluna existe em uma tabela.
   * 
   * @param conn   Conexão com o banco de dados
   * @param tabela Nome da tabela
   * @param coluna Nome da coluna
   * @return true se a coluna existir, false caso contrário
   */
  private static boolean colunaExiste(Connection conn, String tabela, String coluna) throws SQLException {
    DatabaseMetaData metaData = conn.getMetaData();
    try (ResultSet rs = metaData.getColumns(null, null, tabela, coluna)) {
      return rs.next(); // Se retornou algum resultado, a coluna existe
    }
  }
}