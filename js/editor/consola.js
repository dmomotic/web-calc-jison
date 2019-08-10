define(function () {
    'use strict';

    var consola = document.getElementById("txt-consola");

    function append(texto){
        consola.value += texto + '\n';
    }

    function clear(){
        consola.value = '';
    }

    return {
        append: append,
        clear: clear
    };
});