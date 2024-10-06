package com.ieseljust.pmdm.comptadorMVVM

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class ComptadorViewModel : ViewModel(){
    // Definim el LiveData per al comptador, com a una variable
    // privada i immutable, parametritzada al tipus del comptador (Int)
    // Aixi garantim que nomes es manipule des del ViewModel
    private val _comptador = MutableLiveData<Int>()

    // Definim un metode pubilc per accedir al valor del LiveData
    val comptador: LiveData<Int> get() = _comptador

    init {
        // Bloc d'inicialitzacio del comptador
        _comptador.value = 0
    }

    fun incrementarComptador() {
        // Funcio per incrementar el comptador
        _comptador.value = (_comptador.value ?: 0) + 1
    }
    fun decrementComptador(){
        //Funcio per decrementar el comptador
        _comptador.value=(_comptador.value ?:0)-1
    }

    fun resetComptador(){
        //Funcio per a reiniciar el comptador a 0
        _comptador.value=0
    }
}