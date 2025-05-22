package com.mack.clinica.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Modelo que representa o usuário do sistema.
 */
public class Usuario {
    private int id;
    private String nome;
    private String email;
    private String cpf;
    private String celular;
    private String tipo; // paciente, admin, medico
    private String senha; // Only for authentication, not usually for display
    private LocalDateTime createdAt;
    private LocalDate dataNascimento; // Data de nascimento do usuário

    // Construtor padrão
    public Usuario() {
    }

    // Construtor com todos os campos (exceto senha para evitar exposição)
    public Usuario(int id, String nome, String email, String cpf, String celular, String tipo,
            LocalDateTime createdAt, LocalDate dataNascimento) {
        this.id = id;
        this.nome = nome;
        this.email = email;
        this.cpf = cpf;
        this.celular = celular;
        this.tipo = tipo;
        this.createdAt = createdAt;
        this.dataNascimento = dataNascimento;
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getNome() {
        return nome;
    }

    public String getEmail() {
        return email;
    }

    public String getCpf() {
        return cpf;
    }

    public String getCelular() {
        return celular;
    }

    public String getTipo() {
        return tipo;
    }

    public String getSenha() {
        return senha;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public LocalDate getDataNascimento() {
        return dataNascimento;
    }

    public String getFormattedCreatedAt() {
        if (this.createdAt != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
            return this.createdAt.format(formatter);
        }
        return "";
    }

    public String getFormattedDataNascimento() {
        if (this.dataNascimento != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            return this.dataNascimento.format(formatter);
        }
        return "";
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public void setCelular(String celular) {
        this.celular = celular;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public void setDataNascimento(LocalDate dataNascimento) {
        this.dataNascimento = dataNascimento;
    }

    // Setter para String (útil ao preencher a partir de formulários)
    public void setDataNascimentoFromString(String dataNascimentoString) {
        if (dataNascimentoString != null && !dataNascimentoString.isEmpty()) {
            try {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                this.dataNascimento = LocalDate.parse(dataNascimentoString, formatter);
            } catch (Exception e) {
                // Tenta com o formato brasileiro
                try {
                    DateTimeFormatter alternativeFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                    this.dataNascimento = LocalDate.parse(dataNascimentoString, alternativeFormatter);
                } catch (Exception ex) {
                    System.err.println("Formato de data inválido para dataNascimento: " + dataNascimentoString);
                    this.dataNascimento = null;
                }
            }
        } else {
            this.dataNascimento = null;
        }
    }

    // Setter para String (útil ao ler do banco)
    public void setCreatedAtFromString(String createdAtString) {
        if (createdAtString != null && !createdAtString.isEmpty()) {
            // Ajuste o pattern conforme o formato no banco. Ex: "yyyy-MM-dd HH:mm:ss"
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            try {
                this.createdAt = LocalDateTime.parse(createdAtString, formatter);
            } catch (Exception e) {
                // Tenta com um pattern que pode vir do SQLite (sem sub-segundos)
                try {
                    DateTimeFormatter alternativeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                    this.createdAt = LocalDateTime.parse(createdAtString, alternativeFormatter);
                } catch (Exception ex) {
                    System.err.println("Formato de data inválido para createdAt: " + createdAtString);
                    this.createdAt = null;
                }
            }
        } else {
            this.createdAt = null;
        }
    }
}
