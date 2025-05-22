package com.mack.clinica.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
  // O caminho para o banco de dados SQLite.
  // Assumindo que o db.db está na raiz da pasta webapp/WEB-INF/
  // O ServletContext será usado para obter o caminho real em tempo de execução.
  private static final String SQLITE_DB_NAME = "db.db";

  static {
    try {
      // Carrega o driver JDBC do SQLite
      Class.forName("org.sqlite.JDBC");
    } catch (ClassNotFoundException e) {
      System.err.println("Driver SQLite JDBC não encontrado.");
      e.printStackTrace();
    }
  }

  public static Connection getConnection(jakarta.servlet.ServletContext context) throws SQLException {
    // Constrói o caminho absoluto para o arquivo do banco de dados
    String dbPath = context.getRealPath("/WEB-INF/" + SQLITE_DB_NAME);
    String url = "jdbc:sqlite:" + dbPath;

    // System.out.println("Tentando conectar a: " + url); // Para debug

    Connection conn = null;
    try {
      conn = DriverManager.getConnection(url);
      // System.out.println("Conexão com SQLite estabelecida com sucesso."); // Para
      // debug
    } catch (SQLException e) {
      System.err.println("Erro ao conectar ao SQLite: " + e.getMessage());
      System.err.println("Caminho do banco: " + dbPath);
      throw e; // Re-lança a exceção para que a camada superior possa tratar
    }
    return conn;
  }

  public static void closeConnection(Connection conn) {
    if (conn != null) {
      try {
        conn.close();
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }
  }
}