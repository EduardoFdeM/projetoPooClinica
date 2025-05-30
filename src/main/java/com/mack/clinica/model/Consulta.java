package com.mack.clinica.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Consulta {
  private int id;
  private int pacienteId;
  private int profissionalId;
  private LocalDateTime dataHora;
  private String status;
  private String observacoes;

  // Campos adicionais para exibição (não estão na tabela consultas, virão de um
  // JOIN)
  private String nomeProfissional;
  private String nomePaciente;
  private String nomeMedico;

  public Consulta() {
  }

  // Getters
  public int getId() {
    return id;
  }

  public int getPacienteId() {
    return pacienteId;
  }

  public int getProfissionalId() {
    return profissionalId;
  }

  public LocalDateTime getDataHora() {
    return dataHora;
  }

  public String getStatus() {
    return status;
  }

  public String getObservacoes() {
    return observacoes;
  }

  public String getNomeProfissional() {
    return nomeProfissional;
  }

  public String getNomePaciente() {
    return nomePaciente;
  }

  public String getNomeMedico() {
    return nomeMedico;
  }

  public String getFormattedDataHora() {
    if (this.dataHora != null) {
      DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
      return this.dataHora.format(formatter);
    }
    return "Data não definida";
  }

  // Métodos para compatibilidade com JSPs
  public String getDataConsultaFormatada() {
    if (this.dataHora != null) {
      DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
      return this.dataHora.format(formatter);
    }
    return "Data não definida";
  }

  public String getHorario() {
    if (this.dataHora != null) {
      DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
      return this.dataHora.format(formatter);
    }
    return "Horário não definido";
  }

  // Setters
  public void setId(int id) {
    this.id = id;
  }

  public void setPacienteId(int pacienteId) {
    this.pacienteId = pacienteId;
  }

  public void setProfissionalId(int profissionalId) {
    this.profissionalId = profissionalId;
  }

  public void setDataHora(LocalDateTime dataHora) {
    this.dataHora = dataHora;
  }

  public void setDataHoraFromString(String dataHoraStr) {
    if (dataHoraStr != null && !dataHoraStr.isEmpty()) {
      // Tenta formatos comuns, incluindo o que o datetime-local pode enviar e o
      // formato do banco
      DateTimeFormatter formatterWithSeconds = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
      DateTimeFormatter formatterWithoutSeconds = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"); // Formato de
                                                                                                     // datetime-local
      DateTimeFormatter formatterWithSubSeconds = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");

      try {
        this.dataHora = LocalDateTime.parse(dataHoraStr, formatterWithSeconds);
      } catch (Exception e1) {
        try {
          this.dataHora = LocalDateTime.parse(dataHoraStr, formatterWithoutSeconds);
        } catch (Exception e2) {
          try {
            this.dataHora = LocalDateTime.parse(dataHoraStr, formatterWithSubSeconds);
          } catch (Exception e3) {
            System.err
                .println("Formato de data/hora inválido para consulta: " + dataHoraStr + ". Erro: " + e3.getMessage());
            this.dataHora = null;
          }
        }
      }
    } else {
      this.dataHora = null;
    }
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public void setObservacoes(String observacoes) {
    this.observacoes = observacoes;
  }

  public void setNomeProfissional(String nomeProfissional) {
    this.nomeProfissional = nomeProfissional;
  }

  public void setNomePaciente(String nomePaciente) {
    this.nomePaciente = nomePaciente;
  }

  public void setNomeMedico(String nomeMedico) {
    this.nomeMedico = nomeMedico;
  }
}