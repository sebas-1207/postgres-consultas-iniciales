CREATE TABLE departamento(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50)
);

CREATE TABLE profesor(
	id_profesor SERIAL PRIMARY KEY,
	id_departamento INT
);

CREATE TYPE valoresSexo AS ENUM ('Masculino', 'Femenino');
CREATE TYPE valoresTipo AS ENUM ('Profesor', 'Alumno');

CREATE TABLE persona(
    id SERIAL PRIMARY KEY,
    nif VARCHAR(9),
    nombre VARCHAR(25),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50),
    ciudad VARCHAR(25),
    direccion VARCHAR(50),
    telefono VARCHAR(9),
    fecha_nacimiento DATE,
    sexo valoresSexo,
    tipo valoresTipo
);

CREATE TABLE curso_escolar(
    id SERIAL PRIMARY KEY,
    anyo_inicio DATE,
    anyo_fin DATE
);

CREATE TABLE grado(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TYPE valoresAsignatura AS ENUM ('Basica', 'Obligatoria', 'Optativa');

CREATE TABLE asignatura(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    creditos FLOAT,
    tipo valoresAsignatura,
    curso SMALLINT,
    cuatrimestre SMALLINT,
    id_profesor INT,
    id_grado INT
);

CREATE TABLE alumno_se_matricula_asignatura(
    id_alumno INT,
    id_asignatura INT,
    id_curso_escolar INT
);

