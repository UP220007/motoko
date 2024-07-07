import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface Alumno {
  'id' : bigint,
  'nombres' : string,
  'apellido_paterno' : string,
  'fecha_nacimiento' : string,
  'carrera_id' : bigint,
  'grupo' : string,
  'apellido_materno' : string,
  'cuatrimestre_en_curso' : bigint,
  'fecha_inscripcion' : string,
}
export interface Calificacion {
  'id' : bigint,
  'oportunidad' : string,
  'alumno_id' : bigint,
  'materia_id' : bigint,
  'calificacion' : [] | [bigint],
  'aprobada' : boolean,
}
export interface Carrera { 'id' : bigint, 'nombre' : string }
export interface Docente { 'id' : bigint, 'nombre' : string }
export interface Horario {
  'id' : bigint,
  'dia' : string,
  'turno' : string,
  'docente_id' : bigint,
  'cuatrimestre' : string,
  'hora_inicio' : string,
  'materia_id' : bigint,
  'salon' : string,
  'hora_fin' : string,
}
export interface Materia {
  'id' : bigint,
  'nombre' : string,
  'carrera_id' : bigint,
}
export interface MateriaDocente {
  'id' : bigint,
  'docente_id' : bigint,
  'materia_id' : bigint,
}
export interface _SERVICE {
  'addAlumno' : ActorMethod<
    [string, string, bigint, bigint, string, string, string, bigint, string],
    undefined
  >,
  'addCalificacion' : ActorMethod<
    [bigint, boolean, [] | [bigint], bigint, bigint, string],
    undefined
  >,
  'addCarrera' : ActorMethod<[bigint, string], undefined>,
  'addDocente' : ActorMethod<[bigint, string], undefined>,
  'addHorario' : ActorMethod<
    [string, string, bigint, string, string, bigint, bigint, string, string],
    undefined
  >,
  'addMateria' : ActorMethod<[bigint, bigint, string], undefined>,
  'addMateriaDocente' : ActorMethod<[bigint, bigint, bigint], undefined>,
  'asignarGrupoAlumno' : ActorMethod<[bigint, string], undefined>,
  'buscarAlumnoPorId' : ActorMethod<[bigint], [] | [Alumno]>,
  'buscarAlumnosPorFechaInscripcion' : ActorMethod<[string], Array<Alumno>>,
  'buscarAlumnosPorGrupo' : ActorMethod<[string], Array<Alumno>>,
  'buscarCalificacionesPorAlumno' : ActorMethod<[bigint], Array<Calificacion>>,
  'buscarCarreraPorNombre' : ActorMethod<[string], Array<Carrera>>,
  'buscarDocentePorNombre' : ActorMethod<[string], Array<Docente>>,
  'buscarHorariosPorCuatrimestre' : ActorMethod<[string], Array<Horario>>,
  'buscarHorariosPorCuatrimestreYDia' : ActorMethod<
    [string, string],
    Array<Horario>
  >,
  'buscarHorariosPorDia' : ActorMethod<[string], Array<Horario>>,
  'buscarHorariosPorDocente' : ActorMethod<[bigint], Array<Horario>>,
  'buscarHorariosPorDocenteYMateria' : ActorMethod<
    [bigint, bigint],
    Array<Horario>
  >,
  'buscarHorariosPorMateria' : ActorMethod<[bigint], Array<Horario>>,
  'buscarHorariosPorSalon' : ActorMethod<[string], Array<Horario>>,
  'buscarHorariosPorSalonYCarrera' : ActorMethod<
    [string, bigint],
    Array<Horario>
  >,
  'buscarHorariosPorTurno' : ActorMethod<[string], Array<Horario>>,
  'buscarMateriaPorNombre' : ActorMethod<[string], Array<Materia>>,
  'buscarMateriasPorCarrera' : ActorMethod<[bigint], Array<Materia>>,
  'calcularPromedioAlumno' : ActorMethod<[bigint], [] | [bigint]>,
  'calcularPromedioPorCarrera' : ActorMethod<[bigint], [] | [bigint]>,
  'calcularPromedioPorMateria' : ActorMethod<[bigint], [] | [bigint]>,
  'editarAlumno' : ActorMethod<
    [bigint, string, string, bigint, bigint, string, string, string, string],
    undefined
  >,
  'editarCalificacion' : ActorMethod<
    [bigint, bigint, boolean, [] | [bigint], bigint, string],
    undefined
  >,
  'editarCarrera' : ActorMethod<[bigint, string], undefined>,
  'editarDocente' : ActorMethod<[bigint, string], undefined>,
  'editarDocentePorMateria' : ActorMethod<[bigint, bigint, bigint], undefined>,
  'editarHorario' : ActorMethod<
    [bigint, string, string, bigint, string, string, bigint, string, string],
    undefined
  >,
  'editarMateria' : ActorMethod<[bigint, bigint, string], undefined>,
  'eliminarAlumno' : ActorMethod<[bigint], undefined>,
  'eliminarCalificacion' : ActorMethod<[bigint], undefined>,
  'eliminarCarrera' : ActorMethod<[bigint], undefined>,
  'eliminarDocente' : ActorMethod<[bigint], undefined>,
  'eliminarHorario' : ActorMethod<[bigint], undefined>,
  'eliminarMateria' : ActorMethod<[bigint], undefined>,
  'eliminarMateriaDocente' : ActorMethod<[bigint], undefined>,
  'getAlumnos' : ActorMethod<[], Array<Alumno>>,
  'getCalificaciones' : ActorMethod<[], Array<Calificacion>>,
  'getCarreras' : ActorMethod<[], Array<Carrera>>,
  'getDocentes' : ActorMethod<[], Array<Docente>>,
  'getHorarios' : ActorMethod<[], Array<Horario>>,
  'getMaterias' : ActorMethod<[], Array<Materia>>,
  'getMateriasDocentes' : ActorMethod<[], Array<MateriaDocente>>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
