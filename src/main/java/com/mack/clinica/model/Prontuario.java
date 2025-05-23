package com.mack.clinica.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Prontuario {
  private int id;
  private int pacienteId;
  private int medicoId;
  private String dataConsulta;
  private String horarioConsulta;
  private String anamnese;
  private String exameFisico;
  private String hipoteseDiagnostica;
  private String condutaMedica;
  private String observacoes;

  // Campos auxiliares para exibição
  private String nomePaciente;
  private String nomeMedico;

  // Construtores
  public Prontuario() {
  }

  public Prontuario(int pacienteId, int medicoId, String dataConsulta, String horarioConsulta, String anamnese,
      String exameFisico, String hipoteseDiagnostica, String condutaMedica, String observacoes) {
    this.pacienteId = pacienteId;
    this.medicoId = medicoId;
    this.dataConsulta = dataConsulta;
    this.horarioConsulta = horarioConsulta;
    this.anamnese = anamnese;
    this.exameFisico = exameFisico;
    this.hipoteseDiagnostica = hipoteseDiagnostica;
    this.condutaMedica = condutaMedica;
    this.observacoes = observacoes;
  }

  // Getters e Setters
  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public int getPacienteId() {
    return pacienteId;
  }

  public void setPacienteId(int pacienteId) {
    this.pacienteId = pacienteId;
  }

  public int getMedicoId() {
    return medicoId;
  }

  public void setMedicoId(int medicoId) {
    this.medicoId = medicoId;
  }

  public String getDataConsulta() {
    return dataConsulta;
  }

  public void setDataConsulta(String dataConsulta) {
    this.dataConsulta = dataConsulta;
  }

  public String getHorarioConsulta() {
    return horarioConsulta;
  }

  public void setHorarioConsulta(String horarioConsulta) {
    this.horarioConsulta = horarioConsulta;
  }

  public String getAnamnese() {
    return anamnese;
  }

  public void setAnamnese(String anamnese) {
    this.anamnese = anamnese;
  }

  public String getExameFisico() {
    return exameFisico;
  }

  public void setExameFisico(String exameFisico) {
    this.exameFisico = exameFisico;
  }

  public String getHipoteseDiagnostica() {
    return hipoteseDiagnostica;
  }

  public void setHipoteseDiagnostica(String hipoteseDiagnostica) {
    this.hipoteseDiagnostica = hipoteseDiagnostica;
  }

  public String getCondutaMedica() {
    return condutaMedica;
  }

  public void setCondutaMedica(String condutaMedica) {
    this.condutaMedica = condutaMedica;
  }

  public String getObservacoes() {
    return observacoes;
  }

  public void setObservacoes(String observacoes) {
    this.observacoes = observacoes;
  }

  public String getNomePaciente() {
    return nomePaciente;
  }

  public void setNomePaciente(String nomePaciente) {
    this.nomePaciente = nomePaciente;
  }

  public String getNomeMedico() {
    return nomeMedico;
  }

  public void setNomeMedico(String nomeMedico) {
    this.nomeMedico = nomeMedico;
  }

  // Métodos utilitários
  public String getDataConsultaFormatada() {
    if (dataConsulta == null || dataConsulta.isEmpty()) {
      return "";
    }

    try {
      SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
      SimpleDateFormat outputFormat = new SimpleDateFormat("dd/MM/yyyy");
      Date date = inputFormat.parse(dataConsulta);
      return outputFormat.format(date);
    } catch (ParseException e) {
      return dataConsulta;
    }
  }

  public String getDataHoraCompleta() {
    String dataFormatada = getDataConsultaFormatada();
    if (horarioConsulta != null && !horarioConsulta.isEmpty()) {
      return dataFormatada + " às " + horarioConsulta;
    }
    return dataFormatada;
  }

  @Override
  public String toString() {
    return "Prontuario{" +
        "id=" + id +
        ", pacienteId=" + pacienteId +
        ", medicoId=" + medicoId +
        ", dataConsulta='" + dataConsulta + '\'' +
        ", horarioConsulta='" + horarioConsulta + '\'' +
        ", nomePaciente='" + nomePaciente + '\'' +
        ", nomeMedico='" + nomeMedico + '\'' +
        '}';
  }
}