# Calculadora Web - Jison

Editor de código implementado con sistema de pestañas, que permite la interpretación de un leguaje que realiza las operaciones aritméticas básicas.

Ejemplo de entrada

```javascript
Evaluar[1+1];
Evaluar[1+1*2];
Evaluar[-(1+1*6/3-5+7)];
Evaluar[-(1+1*6/3-5+1*-2)];
Evaluar[-(1.6+1.45)];
```

Salida

```javascript
El valor de la expresión es: 2
El valor de la expresión es: 3
El valor de la expresión es: -5
El valor de la expresión es: 4
El valor de la expresión es: -3.05
```

La implementación de las operaciones aritméticas no fue llevada a cabo como comúnmente se hace al colocar las operaciones directamente en las acciones de la gramática, sino que, se realizó la creación de nodos representados a través de clases, para la creación de una lista (nuestro AST), y posteriormente recorremos la lista de nodos para calcular las operaciones y obtener los resultados. Esto nos facilita la ampliación de funcionalidades para el lenguaje, siempre y cuando trabajemos bajo el mismo patrón.



Elaborado con:

- Jison, como analizador léxico y sintáctico.
- RequireJS, librería utilizada para la modularización de la estructura completa del proyecto.
- Codemirror, como editor de código embebido en la aplicación.

### **NOTA**

Para cualquier ampliación del lenguaje reconocido, leer la observación agregada al final del archivo  [analizador.jison](js\gramatica\analizador.jison) ubicado en  [js/gramatica](js\gramatica) 

------

Diego Momotic

diegomomotic@gmail.com









