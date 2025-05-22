package com.mack.clinica.model;

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

    // Construtor padrão
    public Usuario() {
    }

    // Construtor com todos os campos (exceto senha para evitar exposição)
    public Usuario(int id, String nome, String email, String cpf, String celular, String tipo,
            LocalDateTime createdAt) {
        this.id = id;
        this.nome = nome;
        this.email = email;
        this.cpf = cpf;
        this.celular = celular;
        this.tipo = tipo;
        this.createdAt = createdAt;
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

    public String getFormattedCreatedAt() {
        if (this.createdAt != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
            return this.createdAt.format(formatter);
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
