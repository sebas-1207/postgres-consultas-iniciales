# **Consultas PostgreSQL** 

1. Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos. El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.

   ```sql
   SELECT apellido1, apellido2, nombre
   FROM persona
   WHERE tipo = 'Alumno'
   ORDER BY apellido1, apellido2, nombre;
   ```

2. Averigua el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.

     ```sql
     SELECT nombre, apellido1, apellido2
     FROM persona
     WHERE tipo = 'Alumno' AND telefono IS NULL;
     ```

3. Devuelve el listado de los alumnos que nacieron en 1999.

     ```sql
     SELECT nombre, apellido1, apellido2
     FROM persona
     WHERE tipo = 'Alumno' AND EXTRACT(YEAR FROM fecha_nacimiento) = 1999;
     ```

4. Devuelve el listado de profesores que no han dado de alta su número de teléfono en la base de datos y además su nif termina en K.

     ```sql
     SELECT nombre, apellido1, apellido2
     FROM persona
     WHERE tipo = 'Profesor' AND telefono IS NULL AND nif LIKE '%K';
     ```
     
5. Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.

     ```sql
     SELECT nombre
     FROM asignatura
     WHERE curso = 3 AND cuatrimestre = 1 AND id_grado = 7;
     ```
