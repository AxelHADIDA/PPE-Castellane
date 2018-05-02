package com.example.axel.castellaneapp;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    private Button btConnexion1, btInscription1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        this.btConnexion1 = (Button)findViewById(R.id.idConnexion1);
        this.btInscription1 = (Button)findViewById(R.id.idInscription1);

        this.btConnexion1.setOnClickListener(this);
        this.btInscription1.setOnClickListener(this);

    }

    @Override
    public void onClick(View view) {
        if (view.getId() == R.id.idConnexion1)
        {
            Intent unIntent1 = new Intent(this,Connexion.class);
            startActivity(unIntent1);
        }
        else if(view.getId()==R.id.idInscription1)
        {
            Intent unIntent2 = new Intent(this,Inscription.class);
            startActivity(unIntent2);
        }
    }
}
