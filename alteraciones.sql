ALTER TABLE profesor
ADD CONSTRAINT fk_departamento_profesor
FOREIGN KEY (id_departamento)
REFERENCES departamento(id);

ALTER TABLE profesor
ADD CONSTRAINT fk_persona_profesor
FOREIGN KEY (id_profesor)
REFERENCES persona(id);

ALTER TABLE asignatura
ADD CONSTRAINT fk_profesor_asignatura
FOREIGN KEY (id_profesor)
REFERENCES profesor(id);

ALTER TABLE asignatura
ADD CONSTRAINT fk_grado_asignatura
FOREIGN KEY (id_grado)
REFERENCES grado(id);

ALTER TABLE alumno_se_matricula_asignatura
ADD CONSTRAINT fk_persona_alumno_se_matricula_asignatura
FOREIGN KEY (id_alumno)
REFERENCES persona(id);

ALTER TABLE alumno_se_matricula_asignatura
ADD CONSTRAINT fk_curso_escolar_alumno_se_matricula_asignatura
FOREIGN KEY (id_curso_escolar)
REFERENCES curso_escolar(id);

ALTER TABLE alumno_se_matricula_asignatura
ADD CONSTRAINT fk_asignatura_alumno_se_matricula_asignatura
FOREIGN KEY (id_asignatura)
REFERENCES asignatura(id);
