package com.pmdm.ieseljust.comptador

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat

class MainActivity : AppCompatActivity() {

    private var comptador=0
    private lateinit var textViewContador: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()

        setContentView(R.layout.activity_main)

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        // Referencia al TextView
         textViewContador=findViewById<TextView>(R.id.textViewComptador)
        // Referencia al boto d'Open
        val btOpen=findViewById<Button>(R.id.btOpen)

        // Inicialitzem el TextView amb el comptador a 0
        textViewContador.text=comptador.toString() // Estem fent una assignacio directament o accedinta algun metode?

        // Referencia al botón suma
        val btAdd=findViewById<Button>(R.id.btAdd)

        //Referencia botón resta
        val btRem=findViewById<Button>(R.id.btRest)

        // Referencia al botón reset
        val btRes=findViewById<Button>(R.id.btReset)

        // Asociaciamos una expresióin lambda como
        // respuesta (callback) al evento Clic sobre
        // el botón
        btAdd.setOnClickListener {
            comptador++
            textViewContador.text=comptador.toString()
        }
        /* Resta*/
        btRem.setOnClickListener {
            comptador--
            textViewContador.text=comptador.toString()
        }

        /* Igualar a 0 */
        btRes.setOnClickListener {
            comptador=0
            textViewContador.text=comptador.toString()
        }

        btOpen.setOnClickListener{
            val intent = Intent(baseContext, MostraComptadorActivity::class.java)
            intent.putExtra("comptador", comptador)
            startActivity(intent)
        }

        btOpen.setOnClickListener {
            Intent(baseContext, MostraComptadorActivity::class.java).apply {
                putExtra("comptador", comptador)
                startActivity(this)
            }
        }
        if(savedInstanceState !=null){
            comptador= savedInstanceState.getInt("comptador",0)
            actualizarContador()
        }
    }

    //Guardem la activitat comptador
    override fun onSaveInstanceState(estat: Bundle) {
        super.onSaveInstanceState(estat)
        estat.putInt("compatdor",comptador)
    }

    //Quan reiniciem la activitat la restaurem al estat anterior
    override fun onRestoreInstanceState(estat: Bundle) {
        super.onRestoreInstanceState(estat)
        comptador = estat.getInt("comptador", 0)
        actualizarContador()
    }

    //Actualizar Comptador
    private fun actualizarContador() {
        textViewContador.text = comptador.toString()
    }
}