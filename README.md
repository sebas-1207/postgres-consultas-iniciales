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
