# **Consultas PostgreSQL** 

## **Consultas sobre una tabla**
1. Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos. El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.

   ```sql
   SELECT apellido1, apellido2, nombre
   FROM persona
   WHERE tipo = 'alumno'
   ORDER BY apellido1, apellido2, nombre;
   ```

2. Averigua el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.

     ```sql
     SELECT nombre, apellido1, apellido2
     FROM persona
     WHERE tipo = 'alumno' AND telefono IS NULL;
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

5. Devuelve un listado con los datos de todas las alumnas que se han matriculado alguna vez en el Grado en Ingeniería Informática (Plan 2015).

     ```sql
     SELECT nombre
     FROM asignatura
     WHERE curso = 3 AND cuatrimestre = 1 AND id_grado = 7;
     ```

## **Consultas multitabla (Composición interna)**
1. Devuelve un listado con los datos de todas las alumnas que se han matriculado alguna vez en el Grado en Ingeniería Informática (Plan 2015).
   ```sql
   SELECT DISTINCT persona.*
   FROM persona
   JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno
   JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
   JOIN grado ON asignatura.id_grado = grado.id
   WHERE persona.tipo = 'alumno' AND sexo ='M' AND grado.nombre= 'Grado en Ingeniería Informática (Plan 2015)';
   ```
   
2. Devuelve un listado con todas las asignaturas ofertadas en el Grado en Ingeniería Informática (Plan 2015).

     ```sql
     SELECT asignatura.nombre
     FROM asignatura
     JOIN grado ON asignatura.id_grado = grado.id
     WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';
     ```

3. Devuelve un listado de los profesores junto con el nombre del departamento al que están vinculados. El listado debe devolver cuatro columnas, primer apellido, segundo apellido, nombre y nombre del departamento. El resultado estará ordenado alfabéticamente de menor a mayor por los apellidos y el nombre.

     ```sql
     SELECT persona.nombre, departamento.nombre
     FROM persona, profesor, departamento
     WHERE persona.id = profesor.id_profesor
     AND profesor.id_departamento = departamento.id
     AND persona.tipo = 'profesor'
     ORDER BY persona.apellido1, persona.apellido2, persona.nombre;
     ```

4. Devuelve un listado con el nombre de las asignaturas, año de inicio y año de fin del curso escolar del alumno con nif 26902806M.

     ```sql
     SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin
     FROM alumno_se_matricula_asignatura
     JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id
     JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
     JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
     WHERE persona.nif = '26902806M';
     ```

5. Devuelve un listado con el nombre de todos los departamentos que tienen profesores que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).

     ```sql
     SELECT DISTINCT departamento.nombre
     FROM departamento
     JOIN profesor ON departamento.id = profesor.id_departamento
     JOIN asignatura ON profesor.id = asignatura.id_profesor
     JOIN grado ON asignatura.id_grado = grado.id
     WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';
     ```

6. Devuelve un listado con todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2018/2019.

     ```sql
     SELECT DISTINCT persona.nombre 
     FROM persona
     JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno
     JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
     WHERE anyo_inicio = '2018' AND anyo_fin = '2019';
     ```

## **Consultas multitabla (Composición externa)**     
1. Devuelve un listado con los nombres de todos los profesores y los departamentos que tienen vinculados. El listado también debe mostrar aquellos profesores que no tienen ningún departamento asociado. El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor. El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y el nombre.
   ```sql
   SELECT departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre
   FROM persona
   LEFT JOIN profesor ON persona.id = profesor.id_profesor
   LEFT JOIN departamento ON profesor.id_departamento = departamento.id
   WHERE persona.tipo = 'profesor'
   ORDER BY departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre;
   ```
   
2. Devuelve un listado con los profesores que no están asociados a un departamento.

     ```sql
     SELECT persona.nombre
     FROM persona
     LEFT JOIN profesor ON persona.id = profesor.id_profesor
     WHERE profesor.id IS NULL AND persona.tipo = 'profesor';
     ```

3. Devuelve un listado con los departamentos que no tienen profesores asociados.

     ```sql
     SELECT departamento.nombre
     FROM departamento
     LEFT JOIN profesor ON departamento.id = profesor.id_departamento
     WHERE profesor.id IS NULL;
     ```

4. Devuelve un listado con los profesores que no imparten ninguna asignatura.

     ```sql
     SELECT persona.nombre, persona.apellido1, persona.apellido2
     FROM persona
     LEFT JOIN profesor ON persona.id = profesor.id_profesor
     LEFT JOIN asignatura ON profesor.id = asignatura.id_profesor
     WHERE asignatura.id IS NULL
     AND persona.tipo = 'profesor';
     ```

5. Devuelve un listado con las asignaturas que no tienen un profesor asignado.

     ```sql
     SELECT asignatura.nombre
     FROM asignatura
     LEFT JOIN profesor ON asignatura.id_profesor = profesor.id
     WHERE profesor.id IS NULL;
     ```

6. Devuelve un listado con todos los departamentos que tienen alguna asignatura que no se haya impartido en ningún curso escolar. El resultado debe mostrar el nombre del departamento y el nombre de la asignatura que no se haya impartido nunca.

     ```sql
     SELECT DISTINCT departamento.nombre 
     FROM departamento
     INNER JOIN profesor ON departamento.id = profesor.id_departamento
     INNER JOIN asignatura ON profesor.id = asignatura.id_profesor
     LEFT JOIN alumno_se_matricula_asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura
     WHERE alumno_se_matricula_asignatura.id_asignatura IS NULL;
     ```

## **Consultas resumen**     
1. Devuelve el número total de alumnas que hay.
   ```sql
   SELECT COUNT(*) AS total_alumnas
   FROM persona
   WHERE tipo = 'alumno' AND sexo = 'M';
   ```
   
2. Calcula cuántos alumnos nacieron en 2005.

     ```sql
     SELECT COUNT(*) 
     FROM persona
     WHERE tipo = 'alumno' AND EXTRACT(YEAR FROM fecha_nacimiento) = 2005;
     ```

3. Calcula cuántos profesores hay en cada departamento. El resultado sólo debe mostrar dos columnas, una con el nombre del departamento y otra con el número de profesores que hay en ese departamento. El resultado sólo debe incluir los departamentos que tienen profesores asociados y deberá estar ordenado de mayor a menor por el número de profesores.

     ```sql
     SELECT departamento.nombre, COUNT(profesor.id)
     FROM departamento
     JOIN profesor ON departamento.id = profesor.id_departamento
     GROUP BY departamento.nombre
     ORDER BY COUNT(profesor.id) DESC;
     
     ```

4. Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos. Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. Estos departamentos también tienen que aparecer en el listado.

     ```sql
     SELECT departamento.nombre, COUNT(profesor.id_departamento)
     FROM departamento
     LEFT JOIN profesor ON departamento.id = profesor.id_departamento
     GROUP BY departamento.nombre;
     ```

5. Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas. Estos grados también tienen que aparecer en el listado. El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.

     ```sql
     SELECT grado.nombre, COUNT(asignatura.id_grado) AS num_asignaturas
     FROM grado
     LEFT JOIN asignatura ON grado.id = asignatura.id_grado
     GROUP BY grado.nombre
     ORDER BY num_asignaturas DESC;
     ```

6. Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno, de los grados que tengan más de 40 asignaturas asociadas.

     ```sql
     SELECT grado.nombre, COUNT(asignatura.id_grado) AS num_asignaturas
     FROM grado
     JOIN asignatura ON grado.id = asignatura.id_grado
     GROUP BY grado.nombre
     HAVING COUNT(asignatura.id_grado) > 40;
     ```

7. Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos que hay para cada tipo de asignatura. El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que hay de ese tipo. Ordene el resultado de mayor a menor por el número total de crédidos.

     ```sql
     SELECT grado.nombre, asignatura.tipo, SUM(asignatura.creditos)
     FROM grado
     JOIN asignatura ON grado.id = asignatura.id_grado
     GROUP BY grado.nombre, asignatura.tipo
     ORDER BY SUM(asignatura.creditos) DESC;
     ```

8. Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. El resultado deberá mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.

     ```sql
     SELECT curso_escolar.anyo_inicio, COUNT(persona.id)
     FROM persona
     JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno
     LEFT JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
     JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
     WHERE persona.tipo = 'alumno'
     GROUP BY curso_escolar.anyo_inicio;
     ```

9. Devuelve un listado con el número de asignaturas que imparte cada profesor. El listado debe tener en cuenta aquellos profesores que no imparten ninguna asignatura. El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. El resultado estará ordenado de mayor a menor por el número de asignaturas.

     ```sql
     SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2, COUNT(asignatura.id) AS numero_asignaturas
     FROM profesor
     LEFT JOIN asignatura ON profesor.id = asignatura.id_profesor
     JOIN persona ON profesor.id_profesor = persona.id
     WHERE persona.tipo = 'profesor'
     GROUP BY persona.id, persona.nombre, persona.apellido1, persona.apellido2
     ORDER BY numero_asignaturas DESC;
     ```

## **Subconsultas**     
1. Devuelve todos los datos del alumno más joven.
   ```sql
   SELECT *
   FROM persona
   WHERE fecha_nacimiento = (SELECT MIN(fecha_nacimiento) FROM persona WHERE tipo = 'alumno');
   ```
   
2. Devuelve un listado con los profesores que no están asociados a un departamento.
   ```sql
   SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2
   FROM persona
   WHERE persona.tipo = 'profesor'
   AND persona.id NOT IN (SELECT id_profesor FROM profesor WHERE id_departamento IS NOT NULL);
   ```
   
3. Devuelve un listado con los departamentos que no tienen profesores asociados.
   ```sql
   SELECT departamento.id, departamento.nombre
   FROM departamento
   WHERE departamento.id NOT IN (SELECT id_departamento FROM profesor);
   ```
   
4. Devuelve un listado con los profesores que tienen un departamento asociado y que no imparten ninguna asignatura.
   ```sql
   SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2
   FROM persona
   JOIN profesor ON persona.id = profesor.id_profesor
   WHERE profesor.id_departamento IS NOT NULL
   AND persona.id NOT IN (SELECT id_profesor FROM asignatura);
   ```
   
5. Devuelve un listado con las asignaturas que no tienen un profesor asignado.
   ```sql
   SELECT asignatura.nombre
   FROM asignatura
   WHERE asignatura.id_profesor IS NULL;
   ```
   
6. Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.
   ```sql
   SELECT DISTINCT departamento.nombre
   FROM departamento 
   LEFT JOIN profesor  ON departamento.id = profesor.id_departamento
   LEFT JOIN asignatura ON asignatura.id_profesor = profesor.id_profesor
   LEFT JOIN alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
   WHERE alumno_se_matricula_asignatura.id_curso_escolar IS NULL AND asignatura.curso IS NULL;
   ```