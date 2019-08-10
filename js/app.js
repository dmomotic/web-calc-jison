define(function (require) {
    "use strict";

    var Analizador = require('./gramatica/analizador');
    var Nodo = require('./arbol/nodo');
    var Editor = require('./editor/editor');
    var Consola = require('./editor/consola');

    //Inicializo el editor con una pestaña y su contenido
    Editor.initialize('Evaluar[1+1];\nEvaluar[1+1*2];\nEvaluar[-(1+1*6/3-5+7)];\nEvaluar[-(1+1*6/3-5+1*-2)];\nEvaluar[-(1.6+1.45)];');

    //Agrego el listene para la opcion de agregar una nueva pestaña
    document.getElementById('btn-nueva-pest').addEventListener('click', function(e){
        Editor.newBuf('top');
    });

    //Agrego listener para compilar el codigo
    document.getElementById('btn-compilar').addEventListener('click', function(e){
        Consola.clear();
        var arbol = Analizador.parse(Editor.getText());
        arbol.forEach(nodo => {
            if(nodo instanceof Nodo){
                Consola.append("El valor de la expresión es: " + nodo.ejecutar());
            }
        });
    });

});