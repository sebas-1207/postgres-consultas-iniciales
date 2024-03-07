CREATE TABLE departamento(
	id INT PRIMARY KEY,
	nombre VARCHAR(50)
);

CREATE TABLE profesor(
	id INT PRIMARY KEY,
	id_profesor INT,
	id_departamento INT
);

CREATE TYPE valoresSexo AS ENUM ('H', 'M');
CREATE TYPE valoresTipo AS ENUM ('profesor', 'alumno');

CREATE TABLE persona(
    id INT PRIMARY KEY,
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
    id INT PRIMARY KEY,
    anyo_inicio INTEGER,
    anyo_fin INTEGER
);

CREATE TABLE grado(
    id INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TYPE valoresAsignatura AS ENUM ('básica', 'obligatoria', 'optativa');

CREATE TABLE asignatura(
    id INT PRIMARY KEY,
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

