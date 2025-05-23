package com.mack.clinica.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

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
      // Cria a tabela prontuarios se ela não existir
      createProntuariosTableIfNotExists(conn);
      // System.out.println("Conexão com SQLite estabelecida com sucesso."); // Para
      // debug
    } catch (SQLException e) {
      System.err.println("Erro ao conectar ao SQLite: " + e.getMessage());
      System.err.println("Caminho do banco: " + dbPath);
      throw e; // Re-lança a exceção para que a camada superior possa tratar
    }
    return conn;
  }

  private static void createProntuariosTableIfNotExists(Connection conn) {
    try (Statement stmt = conn.createStatement()) {
      // Primeiro, vamos verificar se a tabela existe e tem a estrutura correta
      // Se houver erro, vamos recriar a tabela
      try {
        // Tenta fazer uma consulta simples para verificar se as colunas existem
        stmt.executeQuery(
            "SELECT id, paciente_id, profissional_id, data_consulta, horario_consulta, anamnese, exame_fisico, hipotese_diagnostica, conduta_medica, observacoes FROM prontuarios LIMIT 1")
            .close();
        System.out.println("Tabela prontuarios já existe com estrutura correta.");
      } catch (SQLException e) {
        // Se der erro, a tabela não existe ou tem estrutura incorreta
        System.out.println("Tabela prontuarios não existe ou tem estrutura incorreta. Recriando...");

        // Remove a tabela se existir
        try {
          stmt.execute("DROP TABLE IF EXISTS prontuarios");
        } catch (SQLException dropError) {
          System.err.println("Erro ao remover tabela prontuarios: " + dropError.getMessage());
        }

        // Cria a tabela com a estrutura correta
        String createTableSQL = "CREATE TABLE prontuarios (" +
            "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
            "paciente_id INTEGER NOT NULL, " +
            "profissional_id INTEGER NOT NULL, " +
            "data_consulta TEXT NOT NULL, " +
            "horario_consulta TEXT, " +
            "anamnese TEXT, " +
            "exame_fisico TEXT, " +
            "hipotese_diagnostica TEXT, " +
            "conduta_medica TEXT, " +
            "observacoes TEXT, " +
            "FOREIGN KEY (paciente_id) REFERENCES usuarios(id), " +
            "FOREIGN KEY (profissional_id) REFERENCES usuarios(id)" +
            ")";

        stmt.execute(createTableSQL);
        System.out.println("Tabela prontuarios criada com sucesso com estrutura correta.");
      }
    } catch (SQLException e) {
      System.err.println("Erro ao verificar/criar tabela prontuarios: " + e.getMessage());
      e.printStackTrace();
    }
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