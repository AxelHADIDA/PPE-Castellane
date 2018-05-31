package com.example.axel.MyAuto;

import android.content.Intent;
import android.os.AsyncTask;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

public class MesReservations extends AppCompatActivity implements View.OnClickListener {
    private ListView lesResas ;
    private static ArrayList<Reservation> mesReservations = null;
    private FloatingActionButton fabDeconnexion;
    private String email ;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mes_reservations);

        this.fabDeconnexion = (FloatingActionButton)findViewById(R.id.idDeconnexion);

        this.fabDeconnexion.setOnClickListener(this);

        this.lesResas = (ListView)findViewById(R.id.idListe);
        //recuperation de email de la page MainActivity
        this.email = this.getIntent().getStringExtra("email");

        final MesReservations mr = this;
        //affichage des reservations dans la listView
        Thread unT = new Thread(new Runnable() {
            @Override
            public void run() {
                final GetReservations uneAction = new GetReservations();
                uneAction.execute(email);
                //affichage des données
                try
                {
                    Thread.sleep(500);
                }catch(InterruptedException exp)
                {
                    Log.e("erreur", "attente");
                }
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        if (mesReservations != null)
                        {
                            //on définit une ArrayList de String
                            ArrayList<String> contenu = new ArrayList<String>();
                            for (Reservation uneResa : mesReservations)
                            {
                                contenu.add(uneResa.toString());
                            }
                            ArrayAdapter unAdpter = new ArrayAdapter(mr, android.R.layout.simple_list_item_1, contenu);
                            lesResas.setAdapter(unAdpter);
                        }
                    }
                });
            }
        });
        unT.start();

        this.lesResas.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {

                Toast.makeText(mr, mesReservations.get(i).getTitle(), Toast.LENGTH_LONG).show();
            }
        });

    }

    public static ArrayList<Reservation> getMesReservations() {
        return mesReservations;
    }

    public static void setMesReservations(ArrayList<Reservation> mesReservations) {
        MesReservations.mesReservations = mesReservations;
    }

    @Override
    public void onClick(View view) {

                finish();
                Toast.makeText(this,"déconnecté",Toast.LENGTH_SHORT).show();
        }

    }

/*********************** Classe tache asynchrone ***************/

//                                    entre , progression , sortie
class GetReservations extends AsyncTask<String, Void, ArrayList<Reservation>>
{

    @Override
    protected ArrayList<Reservation> doInBackground(String... emails) {
        String url = "http://mywork.portfolio-axel-hadida.fr/castellane/mesCours.php";
        String resultat = null ;
        String email = emails[0];
        ArrayList<Reservation> lesReservations = new ArrayList<Reservation>();

        try {
            URL uneUrl = new URL(url);
            // instanciation de la connexion
            HttpURLConnection uneUrlConnexion = (HttpURLConnection) uneUrl.openConnection();

            // specification de la methode
            uneUrlConnexion.setRequestMethod("GET");

            // ouverture de l'envoi et la reception des données
            uneUrlConnexion.setDoOutput(true);
            uneUrlConnexion.setDoInput(true);

            // on fixe le temps de connexion et d'attente
            uneUrlConnexion.setReadTimeout(10000);
            uneUrlConnexion.setConnectTimeout(10000);

            // on se connect
            uneUrlConnexion.connect();


            // envoyer les données email et mdp via un fichier de sortie
            OutputStream fichierOut = uneUrlConnexion.getOutputStream();
            BufferedWriter bufferOut = new BufferedWriter(new OutputStreamWriter(fichierOut,"UTF-8"));
            String parametres = "email="+email;
            bufferOut.write(parametres);
            bufferOut.flush();
            bufferOut.close();
            fichierOut.close();

            // lecture du resultat dans une chaine de caractere
            InputStream fichierIn = uneUrlConnexion.getInputStream();
            BufferedReader bufferIn = new BufferedReader(new InputStreamReader(fichierIn,"UTF-8"));
            // lecture des chaines contenue dans la page php
            StringBuilder sb = new StringBuilder(); // chaine dynamique a longueur variable
            String ligne = null;
            while ((ligne = bufferIn.readLine()) != null)
            {
                sb.append(ligne);
                bufferIn.close();
                fichierIn.close();
                resultat = sb.toString();

            }
            Log.e("resultat : ",resultat);

        }catch (IOException exp)
        {
            Log.e("Erreur : ", "Connexion impossible a : "+url);
        }

        if (resultat != null)
        {
            try {
                JSONArray tabJson = new JSONArray(resultat);
                for (int i = 0 ; i< tabJson.length(); i++) {
                    JSONObject unObject = tabJson.getJSONObject(i);
                    Reservation uneResa = new Reservation(
                            unObject.getString("userName"),
                            unObject.getString("userEmail"),
                            unObject.getString("start"),
                            unObject.getString("end"),
                            unObject.getString("title"),
                            unObject.getInt("userId"),
                            unObject.getInt("id")
                            );
                        lesReservations.add(uneResa);
                }
            }catch (JSONException exp)
            {
                Log.e("Erreur : ","Impossible de parser le resultat");
            }
        }
        return lesReservations;
    }

    @Override
    protected void onPostExecute(ArrayList<Reservation> reservations ) {
        MesReservations.setMesReservations(reservations);
    }
}
