## **Eventos geométricos interactivos en 2D y detección de colisiones en Processing**

### **Descripción del Proyecto**

El objetivo de este proyecto fue implementar dos formas geométricas interactivas, cada una respondiendo a la entrada del mouse al cambiar su posición, tamaño y color. Cuando estas formas colisionan, se desencadena un evento que provoca un cambio en el fondo. Además, la forma más grande se superpone dinámicamente sobre la más pequeña, manteniendo un efecto de superposición realista. El programa también asegura que el fondo cambie solo una vez tras la colisión, evitando parpadeos rápidos que podrían ser molestos o inseguros para los espectadores.

### **Conceptos Clave**

Vamos a profundizar en los conceptos principales detrás del proyecto:

1. **Interacción con el Mouse:**
   La posición y el tamaño de las formas geométricas se controlan mediante las coordenadas X e Y del mouse. A medida que mueves el mouse, las formas ajustan su tamaño en función de estas coordenadas, haciendo que la interacción sea fluida y receptiva. Así es como logramos esto en el código:

   ```java
   // Obtener las dimensiones y posiciones de los eventos geométricos basados en la posición del mouse
   int w1 = mouseY / 2 + 30;  // Ancho y alto de la primera forma, dependiente de mouseY
   int h1 = w1;               // Mantener la forma proporcional (cuadrado o círculo)
   int x1 = mouseX;           // Posición X de la primera forma, dependiente de mouseX
   int y1 = height / 2;       // La posición Y está fija en el centro de la pantalla
   ```

   A medida que el mouse se mueve, el ancho y el alto de la primera forma (`w1`, `h1`) se establecen dinámicamente en función de la posición Y del mouse, mientras que la posición X (`x1`) sigue el valor de `mouseX`.

2. **Eventos Geométricos:**
   Cada forma geométrica se trata como un "evento geométrico". En nuestro programa, tenemos dos tipos de formas geométricas: rectángulos y elipses. Estos eventos cambian de tamaño y color a medida que mueves el mouse, creando un efecto visual dinámico:

   ```java
   /* Esta función dibuja el evento geométrico según su tipo y color
    * type == 1: Rectángulo
    * type == 2: Elipse */
   void drawGeometricEvent(int x, int y, int w, int h, float r, float g, float b, int type) {
     fill(r, g, b, 204);  // Establecer el color de relleno con algo de transparencia

     // Elegir la forma según el parámetro type
     if (type == 1) {
       // Dibujar un rectángulo si type es 1
       rect(x, y, w, h);
     } else if (type == 2) {
       // Dibujar una elipse si type es 2
       ellipse(x, y, w, h);
     }
   }
   ```

   En esta función, el color del evento geométrico se determina por los valores `r`, `g` y `b`, y la forma se elige según el parámetro `type` (ya sea `rect()` o `ellipse()`).

3. **Detección de Colisiones:**
   Cuando las dos formas se intersectan o "colisionan", ocurre un evento especial: el color del fondo cambia. Para lograr esto, el programa verifica si las dos formas se superponen comparando sus posiciones y tamaños:

   ```java
   /* Esta función verifica colisiones entre dos formas rectangulares.
    * Devuelve true si las formas se superponen y false en caso contrario. */
   boolean checkCollision(int x1, int y1, int w1, int h1, int x2, int y2, int w2, int h2) {
     // Verificar si la distancia entre los centros de las formas es menor que la suma de sus medios anchos y altos
     // Esta simple comprobación de colisión de caja delimitadora funciona tanto para rectángulos como para círculos
     return abs(x1 - x2) < (w1 / 2 + w2 / 2) && abs(y1 - y2) < (h1 / 2 + h2 / 2);
   }
   ```

   Esta simple comprobación de colisión de caja delimitadora devuelve `true` si las dos formas se superponen, lo que desencadena el cambio de color del fondo.

4. **Superposición por Tamaño:**
   Una característica interesante de este proyecto es la superposición de formas. La forma más grande siempre aparece encima de la más pequeña, lo cual se logra controlando el orden de dibujo:

   ```java
   // Lógica de superposición: La forma más grande se dibuja al final para asegurarse de que se superponga a la más pequeña
   if (w1 > w2) {
     // Dibujar la segunda forma primero
     drawGeometricEvent(x2, y2, w2, h2, rColor2, gColor2, bColor2, 2);
     // Dibujar la primera forma al final
     drawGeometricEvent(x1, y1, w1, h1, rColor1, gColor1, bColor1, 1);
   } else {
     // Dibujar la primera forma primero
     drawGeometricEvent(x1, y1, w1, h1, rColor1, gColor1, bColor1, 1);
     // Dibujar la segunda forma al final
     drawGeometricEvent(x2, y2, w2, h2, rColor2, gColor2, bColor2, 2);
   }
   ```

   Aquí, el programa compara los anchos de las dos formas (`w1` y `w2`) y determina cuál dibujar al final. La forma más grande se dibuja al final para asegurarse de que aparezca en la parte superior.

5. **Efecto de Desvanecimiento y Transiciones Suaves de Color:**
   En lugar de cambios de color instantáneos, este proyecto utiliza transiciones suaves tanto para las formas como para el fondo. Logramos esto usando la función [`lerp()`](https://processing.org/reference/lerp_.html), que interpola gradualmente entre los colores:

   ```java
   rColor1 = lerp(rColor1, random(255), 0.02);  // Transición suave para el color rojo en la forma 1
   gColor1 = lerp(gColor1, random(255), 0.02);  // Transición suave para el color verde en la forma 1
   bColor1 = lerp(bColor1, random(255), 0.02);  // Transición suave para el color azul en la forma 1
   ```

   La función [`lerp()`](https://processing.org/reference/lerp_.html) interpola entre el valor de color actual y un nuevo valor aleatorio, creando una transición suave o efecto de "desvanecimiento" a lo largo del tiempo.

6. **Control de Cambios de Fondo en Colisión:**
   Para evitar parpadeos rápidos del fondo cuando las formas colisionan, el programa asegura que el fondo solo cambie una vez por evento de colisión:

   ```java
   // Manejar el cambio de color de fondo en la colisión
   if (isColliding) {
     // Cambiar el fondo solo una vez cuando las formas colisionen
     if (!hasChangedBg) {
       // Establecer un nuevo color de fondo aleatorio
       bgRColor = random(255);
       bgGColor = random(255);
       bgBColor = random(255);

       // Marcar que el fondo ha cambiado
       hasChangedBg = true;
     }
   } else {
     // Restablecer el indicador si las formas ya no están colisionando
     hasChangedBg = false;
   }
   ```

   El indicador `hasChangedBg` asegura que el color del fondo solo cambie una vez cuando las formas colisionan y no siga cambiando mientras permanecen en contacto. Esto previene parpadeos rápidos, especialmente cuando el mouse está quieto, mejorando la experiencia del usuario.
