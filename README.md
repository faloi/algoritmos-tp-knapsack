El objetivo de este trabajo es desarrollar sencillos algoritmos Branch and Bound y metaheuristica GRASP para el problema de la mochila binaria.

Concretamente deberán cumplir con los siguientes puntos.

1) Desarrollar un GRASP para el problema de la mochila. Para el mismo se deberán proponer dos heurísticas de búsqueda local distintas y elegir una probando cual funciona mejor en el marco del grasp. Los criterios de corte del GRASP deberían estar adaptados a cada una ya que si una es produce soluciones de mejor calidad pero a mayor costo de tiempo computacional, quizás convenga reducir la cantidad de iteraciones GRASP totales.

2) Decidir un criterio de subdivisión en problemas (o branching). Ejemplos: incluir o no incluir un determinado ítem en la solución, incluir o no dos ítems determinados en la solucion.

3) De acuerdo al criterio determinado en el punto anterior, dar un algoritmo para elegir concretamente en cada nodo del árbol como dividir el subproblema. Volviendo a los ejemplos del punto anterior, en el primer caso su algoritmo deberá decidir cuál de los ítems aún no usados será el elegido para dividir el nodo actual. En el caso del segundo ejemplo, se tratará de elegir entre los pares de ítems para los que aún no se tomó una decisión.

Será necesario que argumenten la opción elegida. En ese sentido, será deseable probar con al menos dos ideas y elegir una en base a resultados computacionales.

4) Desarrollar una relajación para el problema de la mochila que utilice la información que se tiene en cada nodo acerca de las soluciones allí consideradas.

5) Desarrollar una "heurística primal", es decir una heurística que, partiendo de la información que se tiene en cada nodo acerca de las solciones allí consideradas, genera una solución apta para ese nodo y de la mejor calidad posible en cuanto a la función objetivo.

6) Utilizar lo desarrollado en los puntos anteriores en un Branch and bound, es decir un algoritmo que, con algun criterio a desarrollar por ustedes (que puede ser trivial) tome el proximo nodo a analizar, ejecute para él la heurisitica primal y la relajación, propague esta información a los ancestros y genere dos nuevos nodos o bien pode el subarbol actual.

7) Aplicar lo obtenido sobre un conjunto de instancias que les pasamos adjuntas. Hacer lo mismo sobre el backtracking desarrollado en las practicas y el grasp trabajado en el punto 1. Comparar los resultados obtenidos en cuanto a velocidad y efectividad.

Para el 6/7 deberan mostrar informalmente los primeros 3 puntos y para el 11/7 hasta el 6 inclusive y consultar sus ideas para el 7. Los restantes dias serán para realizar el punto 7 y presentar correctamente el trabajo realizado.