define(['./../arbol/nodo'], function(Nodo){
	"use strict";

    class Aritmetica extends Nodo{
        constructor(opizq, op, opder) {
            super();
            this.opizq = opizq;
            this.op = op;
            this.opder = opder;
        }
        //Sobreescribiendo metodo ejecutar
        ejecutar() {
            const opizq = this.opizq instanceof Nodo ? this.opizq.ejecutar() : this.opizq;
            const opder = this.opder instanceof Nodo ? this.opder.ejecutar() : this.opder;
            switch(this.op){
                case '+':
                    return opizq + opder;
                case '-':
                    return opizq - opder;
                case '*':
                    return opizq * opder;
                case '/':
                    return opizq / opder;
                case 'negativo':
                    return opizq * -1;
            }
        }
    }

    return Aritmetica;
});