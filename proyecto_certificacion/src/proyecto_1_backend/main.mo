import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Array "mo:base/Array";

actor {
  // Definición de tipos para las tablas
  type Alumno = {
      apellido_materno : Text;
      apellido_paterno : Text;
      carrera_id : Nat; // Nullable Nat
      cuatrimestre_en_curso : Nat; // Nullable Nat
      fecha_inscripcion : Text;
      fecha_nacimiento : Text;
      grupo : Text; // Nullable Text
      id : Nat;
      nombres : Text;
  };

  type Calificacion = {
      alumno_id : Nat; // Nullable Nat
      aprobada : Bool;
      calificacion : ?Nat; // Nullable Nat
      id : Nat;
      materia_id : Nat; // Nullable Nat
      oportunidad : Text; // Enum, debería ser definido como tipo si es un conjunto finito de valores
  };

  type Carrera = {
      id : Nat;
      nombre : Text;
  };

  type Docente = {
      id : Nat;
      nombre : Text;
  };

  type Horario = {
      cuatrimestre : Text;
      dia : Text; // Enum
      docente_id : Nat; // Nullable Nat
      hora_fin : Text;
      hora_inicio : Text;
      id : Nat;
      materia_id : Nat; // Nullable Nat
      salon : Text;
      turno : Text; // Enum
  };

  type Materia = {
      carrera_id : Nat; // Nullable Nat
      id : Nat;
      nombre : Text;
  };

  type MateriaDocente = {
      docente_id : Nat; // Nullable Nat
      id : Nat;
      materia_id : Nat; // Nullable Nat
  };

  // Variables para almacenar los datos
  var alumnos : [Alumno] = [];
  var calificaciones : [Calificacion] = [];
  var carreras : [Carrera] = [];
  var docentes : [Docente] = [];
  var horarios : [Horario] = [];
  var materias : [Materia] = [];
  var materiasDocentes : [MateriaDocente] = [];

  // Funciones para manipular los datos
  public func addAlumno(
    apellido_materno : Text,
    apellido_paterno : Text,
    carrera_id : Nat,
    cuatrimestre_en_curso : Nat,
    fecha_inscripcion : Text,
    fecha_nacimiento : Text,
    grupo : Text,
    id : Nat,
    nombres : Text
  ) : async () {
    let newAlumno : Alumno = {
      apellido_materno = apellido_materno;
      apellido_paterno = apellido_paterno;
      carrera_id = carrera_id;
      cuatrimestre_en_curso = cuatrimestre_en_curso;
      fecha_inscripcion = fecha_inscripcion;
      fecha_nacimiento = fecha_nacimiento;
      grupo = grupo;
      id = id;
      nombres = nombres;
    };
    alumnos := Array.append(alumnos, [newAlumno]);
  };

  public query func getAlumnos() : async [Alumno] {
    return alumnos;
  };

  public func addCalificacion(
    alumno_id : Nat,
    aprobada : Bool,
    calificacion : ?Nat,
    id : Nat,
    materia_id : Nat,
    oportunidad : Text
  ) : async () {
    let newCalificacion : Calificacion = {
      alumno_id = alumno_id;
      aprobada = aprobada;
      calificacion = calificacion;
      id = id;
      materia_id = materia_id;
      oportunidad = oportunidad;
    };
    calificaciones := Array.append(calificaciones, [newCalificacion]);
  };

  public query func buscarAlumnoPorId(idBuscado : Nat) : async ?Alumno {
    let alumnoEncontrado = Array.find(alumnos, func(buscarAlumno : Alumno) : Bool {
      return buscarAlumno.id == idBuscado;
    });
    return alumnoEncontrado;
  };



  public query func getCalificaciones() : async [Calificacion] {
    return calificaciones;
  };

  public query func buscarCalificacionesPorAlumno(alumnoId : Nat) : async [Calificacion] {
    let calificacionesAlumno = Array.filter(calificaciones, func(buscarCalificacion : Calificacion) : Bool {
      return buscarCalificacion.alumno_id == alumnoId;
    });
    return calificacionesAlumno;
  };

  public func editarCalificacion(
    id : Nat,
    alumno_id : Nat,
    aprobada : Bool,
    newCalificacion : ?Nat,
    materia_id : Nat,
    oportunidad : Text
  ) : async () {
    var encontrado = false;
    calificaciones := Array.map(calificaciones, func(calificacion : Calificacion) : Calificacion {
      if (calificacion.id == id) {
        encontrado := true;
        return {
          alumno_id = alumno_id;
          aprobada = aprobada;
          calificacion = newCalificacion;
          id = id;
          materia_id = materia_id;
          oportunidad = oportunidad;
        };
      } else {
        return calificacion;
      }
    });
    if (not encontrado) {
      return var _error: Text = "Calificación con el id especificado no encontrada";
    }
  };

  public func eliminarCalificacion(id : Nat) : async () {
    calificaciones := Array.filter<Calificacion>(calificaciones, func(calificacion : Calificacion) : Bool {
      calificacion.id != id
    });
  };

  public func editarAlumno(
    id : Nat,
    apellido_materno : Text,
    apellido_paterno : Text,
    carrera_id : Nat,
    cuatrimestre_en_curso : Nat,
    fecha_inscripcion : Text,
    fecha_nacimiento : Text,
    grupo : Text,
    nombres : Text
  ) : async () {
    var encontrado = false;
    let nuevosAlumnos = Array.map<Alumno, Alumno>(alumnos, func(alumno : Alumno) : Alumno {
      if (alumno.id == id) {
        encontrado := true;
        {
          apellido_materno = apellido_materno;
          apellido_paterno = apellido_paterno;
          carrera_id = carrera_id;
          cuatrimestre_en_curso = cuatrimestre_en_curso;
          fecha_inscripcion = fecha_inscripcion;
          fecha_nacimiento = fecha_nacimiento;
          grupo = grupo;
          id = id;
          nombres = nombres;
        }
      } else {
        alumno
      }
    });
    
    if (not encontrado) {
      return var _error: Text = "Alumno con el id especificado no encontrado";
    } else {
      alumnos := nuevosAlumnos;
    }
  };

  public func eliminarAlumno(id : Nat) : async () {
    alumnos := Array.filter<Alumno>(alumnos, func(alumno : Alumno) : Bool {
      alumno.id != id
    });
  };


  public func addCarrera(
    id : Nat,
    nombre : Text
  ) : async () {
    let newCarrera : Carrera = {
      id = id;
      nombre = nombre;
    };
    carreras := Array.append(carreras, [newCarrera]);
  };

  public query func getCarreras() : async [Carrera] {
    return carreras;
  };

  public func addDocente(
    id : Nat,
    nombre : Text
  ) : async () {
    let newDocente : Docente = {
      id = id;
      nombre = nombre;
    };
    docentes := Array.append(docentes, [newDocente]);
  };

  public query func getDocentes() : async [Docente] {
    return docentes;
  };

  public func addHorario(
    cuatrimestre : Text,
    dia : Text,
    docente_id : Nat,
    hora_fin : Text,
    hora_inicio : Text,
    id : Nat,
    materia_id : Nat,
    salon : Text,
    turno : Text
  ) : async () {
    let newHorario : Horario = {
      cuatrimestre = cuatrimestre;
      dia = dia;
      docente_id = docente_id;
      hora_fin = hora_fin;
      hora_inicio = hora_inicio;
      id = id;
      materia_id = materia_id;
      salon = salon;
      turno = turno;
    };
    horarios := Array.append(horarios, [newHorario]);
  };

  public query func getHorarios() : async [Horario] {
    return horarios;
  };

  public query func buscarHorariosPorMateria(materiaId : Nat) : async [Horario] {
    let horariosMateria = Array.filter(horarios, func (horario : Horario) : Bool {
      return horario.materia_id == materiaId;
    });
    return horariosMateria;
  };

  public query func buscarHorariosPorDocente(docenteId : Nat) : async [Horario] {
    let horariosDocente = Array.filter(horarios, func (horario : Horario) : Bool {
      return horario.docente_id == docenteId;
    });
    return horariosDocente;
  };

  public query func buscarHorariosPorSalonYCarrera(salon : Text, carreraId : Nat) : async [Horario] {
    let horariosSalonCarrera = Array.filter(horarios, func (horario : Horario) : Bool {
      return horario.salon == salon and
            (Array.filter(materias, func (materia : Materia) : Bool {
              return materia.id == horario.materia_id and materia.carrera_id == carreraId;
            }).size() > 0);
    });
    return horariosSalonCarrera;
  };

  public func editarHorario(
    id : Nat,
    cuatrimestre : Text,
    dia : Text,
    docente_id : Nat,
    hora_fin : Text,
    hora_inicio : Text,
    materia_id : Nat,
    salon : Text,
    turno : Text
  ) : async () {
    var encontrado = false;
    let nuevosHorarios = Array.map<Horario, Horario>(horarios, func(horario : Horario) : Horario {
      if (horario.id == id) {
        encontrado := true;
        {
          cuatrimestre = cuatrimestre;
          dia = dia;
          docente_id = docente_id;
          hora_fin = hora_fin;
          hora_inicio = hora_inicio;
          id = id;
          materia_id = materia_id;
          salon = salon;
          turno = turno;
        };
      } else {
        horario
      }
    });
    
    if (encontrado) {
      horarios := nuevosHorarios;
    } else {
      return var _error: Text = "Horario con el id especificado no encontrado";
    }
  };

  public func eliminarHorario(id : Nat) : async () {
    horarios := Array.filter<Horario>(horarios, func(horario : Horario) : Bool {
      horario.id != id
    });
  };

  public func addMateria(
    carrera_id : Nat,
    id : Nat,
    nombre : Text
  ) : async () {
    let newMateria : Materia = {
      carrera_id = carrera_id;
      id = id;
      nombre = nombre;
    };
    materias := Array.append(materias, [newMateria]);
  };

  public func editarMateria(
    id : Nat,
    carrera_id : Nat,
    nombre : Text
  ) : async () {
    var encontrado = false;
    materias := Array.map(materias, func(materia : Materia) : Materia {
      if (materia.id == id) {
        encontrado := true;
        return {
          carrera_id = carrera_id;
          id = id;
          nombre = nombre;
        };
      } else {
        return materia;
      }
    });
    if (not encontrado) {
      return var _error: Text = "Materia con el id especificado no encontrada";
    }
  };

  public func eliminarMateria(id : Nat) : async () {
    materias := Array.filter<Materia>(materias, func(materia : Materia) : Bool {
      materia.id != id
    });
  };

  public func editarCarrera(
    id : Nat,
    nombre : Text
  ) : async () {
    var encontrado = false;
    carreras := Array.map(carreras, func(carrera : Carrera) : Carrera {
      if (carrera.id == id) {
        encontrado := true;
        return {
          id = id;
          nombre = nombre;
        };
      } else {
        return carrera;
      }
    });
    if (not encontrado) {
      return var _error: Text = "carrera con el id especificado no encontrado";
    }
  };

  public func eliminarCarrera(id : Nat) : async () {
    carreras := Array.filter<Carrera>(carreras, func(carrera : Carrera) : Bool {
      carrera.id != id
    });
  };

  public query func getMaterias() : async [Materia] {
    return materias;
  };

  public func addMateriaDocente(
    docente_id : Nat,
    id : Nat,
    materia_id : Nat
  ) : async () {
    let newMateriaDocente : MateriaDocente = {
      docente_id = docente_id;
      id = id;
      materia_id = materia_id;
    };
    materiasDocentes := Array.append(materiasDocentes, [newMateriaDocente]);
  };

  public query func getMateriasDocentes() : async [MateriaDocente] {
    return materiasDocentes;
  };

  public func editarDocente(
    id : Nat,
    nombre : Text
  ) : async () {
    var encontrado = false;
    docentes := Array.map(docentes, func(docente : Docente) : Docente {
      if (docente.id == id) {
        encontrado := true;
        return {
          id = id;
          nombre = nombre;
        };
      } else {
        return docente;
      }
    });
    if (not encontrado) {
      return var _error: Text = "Docente con el id especificado no encontrado";
    }
  };

  public func eliminarDocente(id : Nat) : async () {
    docentes := Array.filter<Docente>(docentes, func(docente : Docente) : Bool {
      docente.id != id
    });
  };

  public func editarDocentePorMateria(
    id : Nat,
    docente_id : Nat,
    materia_id : Nat
  ) : async () {
    var encontrado = false;
    materiasDocentes := Array.map(materiasDocentes, func(relacion : MateriaDocente) : MateriaDocente {
      if (relacion.id == id) {
        encontrado := true;
        return {
          id = id;
          docente_id = docente_id;
          materia_id = materia_id;
        };
      } else {
        return relacion;
      }
    });
    if (not encontrado) {
      return var _error: Text = "carrera por docente ID especificado no encontrado";
    }
  };

  public func eliminarMateriaDocente(id : Nat) : async () {
    materiasDocentes := Array.filter<MateriaDocente>(materiasDocentes, func(materiaDocente : MateriaDocente) : Bool {
      materiaDocente.id != id
    });
  };

  public query func buscarHorariosPorDia(diaBuscado : Text) : async [Horario] {
    let horariosDia = Array.filter(horarios, func (horario : Horario) : Bool {
      return horario.dia == diaBuscado;
    });
    return horariosDia;
  };

  public query func buscarHorariosPorCuatrimestre(cuatrimestreBuscado : Text) : async [Horario] {
    let horariosCuatrimestre = Array.filter(horarios, func (horario : Horario) : Bool {
      return horario.cuatrimestre == cuatrimestreBuscado;
    });
    return horariosCuatrimestre;
  };

  public query func buscarAlumnosPorGrupo(grupoBuscado : Text) : async [Alumno] {
    let alumnosGrupo = Array.filter(alumnos, func (alumno : Alumno) : Bool {
      return alumno.grupo == grupoBuscado;
    });
    return alumnosGrupo;
  };

  public query func buscarAlumnosPorFechaInscripcion(fechaBuscada : Text) : async [Alumno] {
    let alumnosFechaInscripcion = Array.filter(alumnos, func (alumno : Alumno) : Bool {
      return alumno.fecha_inscripcion == fechaBuscada;
    });
    return alumnosFechaInscripcion;
  };

  public query func calcularPromedioAlumno(alumnoId : Nat) : async ?Nat {
      let calificacionesAlumno = Array.filter(calificaciones, func(c : Calificacion) : Bool {
          c.alumno_id == alumnoId;
      });

      let initial : (Nat, Nat) = (0, 0);

      let (suma, contador) = Array.foldLeft<Calificacion, (Nat, Nat)>(calificacionesAlumno, initial, func((accSuma, accContador) : (Nat, Nat), c : Calificacion) : (Nat, Nat) {
          switch (c.calificacion) {
              case (?calif) {
                  (accSuma + calif, accContador + 1)
              };
              case null {
                  (accSuma, accContador)
              };
          };
      });

      if (contador == 0) {
          return null;
      } else {
          return ?(suma / contador);
      };
  };

  public func asignarGrupoAlumno(alumnoId: Nat, nuevoGrupo: Text) : async () {
    var encontrado = false;
    alumnos := Array.map(alumnos, func(alumno : Alumno) : Alumno {
      if (alumno.id == alumnoId) {
        encontrado := true;
        return {
          apellido_materno = alumno.apellido_materno;
          apellido_paterno = alumno.apellido_paterno;
          carrera_id = alumno.carrera_id;
          cuatrimestre_en_curso = alumno.cuatrimestre_en_curso;
          fecha_inscripcion = alumno.fecha_inscripcion;
          fecha_nacimiento = alumno.fecha_nacimiento;
          grupo = nuevoGrupo;
          id = alumno.id;
          nombres = alumno.nombres;
        };
      } else {
        return alumno;
      };
    });
    if (not encontrado) {
      return var _error: Text = "Alumno con el id especificado no encontrado";
    };
  };

  public query func buscarHorariosPorSalon(salonBuscado: Text) : async [Horario] {
    return Array.filter(horarios, func (horario : Horario) : Bool {
      return horario.salon == salonBuscado;
    });
  };

  public query func buscarMateriasPorCarrera(carreraId: Nat) : async [Materia] {
    return Array.filter(materias, func (materia : Materia) : Bool {
      return materia.carrera_id == carreraId;
    });
  };

  public query func calcularPromedioPorMateria(materiaId: Nat) : async ?Nat {
    let calificacionesMateria = Array.filter(calificaciones, func (c : Calificacion) : Bool {
      return c.materia_id == materiaId;
    });

    let initial: (Nat, Nat) = (0, 0);

    let (suma, contador) = Array.foldLeft<Calificacion, (Nat, Nat)>(calificacionesMateria, initial, func((accSuma, accContador) : (Nat, Nat), c : Calificacion) : (Nat, Nat) {
      switch (c.calificacion) {
        case (?calif) {
          (accSuma + calif, accContador + 1)
        };
        case null {
          (accSuma, accContador)
        };
      };
    });

    if (contador == 0) {
      return null;
    } else {
      return ?(suma / contador);
    };
  };

  public query func buscarMateriaPorNombre(nombreBuscado: Text) : async [Materia] {
    return Array.filter(materias, func (materia : Materia) : Bool {
      return materia.nombre == nombreBuscado;
    });
  };

  public query func buscarDocentePorNombre(nombreBuscado: Text) : async [Docente] {
    return Array.filter(docentes, func (docente : Docente) : Bool {
      return docente.nombre == nombreBuscado;
    });
  };

  public query func buscarCarreraPorNombre(nombreBuscado: Text) : async [Carrera] {
    return Array.filter(carreras, func (carrera : Carrera) : Bool {
      return carrera.nombre == nombreBuscado;
    });
  };

  public query func buscarHorariosPorTurno(turnoBuscado: Text) : async [Horario] {
    return Array.filter(horarios, func (horario : Horario) : Bool {
      return horario.turno == turnoBuscado;
    });
  };

  public query func buscarHorariosPorDocenteYMateria(docenteId: Nat, materiaId: Nat) : async [Horario] {
    return Array.filter(horarios, func (horario : Horario) : Bool {
      return horario.docente_id == docenteId and horario.materia_id == materiaId;
    });
  };

  public query func calcularPromedioPorCarrera(carreraId: Nat) : async ?Nat {
    let materiasCarrera = Array.filter(materias, func (materia : Materia) : Bool {
      return materia.carrera_id == carreraId;
    });

    var suma: Nat = 0;
    var contador: Nat = 0;

    for (materia in materiasCarrera.vals()) {
      let calificacionesMateria = Array.filter(calificaciones, func (calificacion : Calificacion) : Bool {
        return calificacion.materia_id == materia.id;
      });

      for (calificacion in calificacionesMateria.vals()) {
        switch (calificacion.calificacion) {
          case (?calif) {
            suma += calif;
            contador += 1;
          };
          case null {};
        };
      };
    };

    if (contador == 0) {
      return null;
    } else {
      return ?(suma / contador);
    };
  };

  public query func buscarHorariosPorCuatrimestreYDia(cuatrimestreBuscado: Text, diaBuscado: Text) : async [Horario] {
    return Array.filter(horarios, func (horario : Horario) : Bool {
      return horario.cuatrimestre == cuatrimestreBuscado and horario.dia == diaBuscado;
    });
  };

};