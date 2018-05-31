package com.example.axel.MyAuto;

/**
 * Created by axel on 05/03/2018.
 */

public class Client {
    private int idClient;
    private String email,mdp,nom,prenom ;

    public Client(int idClient, String email, String mdp, String nom, String prenom) {
        this.idClient = idClient;
        this.email = email;
        this.mdp = mdp;
        this.nom = nom;
        this.prenom = prenom;
    }



    public Client(String email, String mdp, String nom, String prenom) {
        this.idClient = 0;
        this.email = email;
        this.mdp = mdp;
        this.nom = nom;
        this.prenom = prenom;
    }

    public int getIdClient() {
        return idClient;
    }

    public void setIdClient(int idClient) {
        this.idClient = idClient;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMdp() {
        return mdp;
    }

    public void setMdp(String mdp) {
        this.mdp = mdp;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }
}
