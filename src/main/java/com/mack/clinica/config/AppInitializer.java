package com.mack.clinica.config;

import com.mack.clinica.util.DbMigrationUtil;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 * Listener para executar tarefas de inicialização da aplicação.
 */
@WebListener
public class AppInitializer implements ServletContextListener {

  @Override
  public void contextInitialized(ServletContextEvent sce) {
    ServletContext context = sce.getServletContext();
    System.out.println("Inicializando a aplicação Clínica Médica...");

    // Executa migrações no banco de dados
    executarMigracoesBD(context);
  }

  @Override
  public void contextDestroyed(ServletContextEvent sce) {
    System.out.println("Encerrando a aplicação Clínica Médica...");
  }

  /**
   * Executa todas as migrações necessárias no banco de dados.
   */
  private void executarMigracoesBD(ServletContext context) {
    try {
      // Adiciona a coluna data_nascimento
      boolean colunaCriada = DbMigrationUtil.adicionarColunaDataNascimento(context);
      if (colunaCriada) {
        System.out.println("Migração de banco de dados concluída com sucesso.");
      } else {
        System.err.println("Houve um problema ao executar a migração de banco de dados.");
      }
    } catch (Exception e) {
      System.err.println("Erro ao executar migrações no banco de dados: " + e.getMessage());
      e.printStackTrace();
    }
  }
}