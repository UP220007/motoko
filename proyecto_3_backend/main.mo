import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Array "mo:base/Array";

actor {
  // Definición del tipo Student
  type Student = {
    id : Nat;
    firstName : Text;
    lastName : Text;
    age : Nat;
    activo : Bool;
  };

  var students : [Student] = [];

  // Método para añadir un nuevo estudiante
  public func addStudent(id : Nat, firstName : Text, lastName : Text, age : Nat, activo : Bool) : async () {
    let newStudent : Student = {
      id = id;
      firstName = firstName;
      lastName = lastName;
      age = age;
      activo = activo;
    };
    students := Array.append(students, [newStudent]);
  };

  // Método para obtener todos los estudiantes
  public query func getStudents() : async [Student] {
    return students;
  };

  // Método para obtener un estudiante por ID
  public query func getStudentById(studentId : Nat) : async ?Student {
    return Array.find<Student>(students, func (s : Student) : Bool {
      s.id == studentId
    });
  };

  // Método para eliminar un estudiante por ID
  public func deleteStudent(studentId : Text) : async () {
    students := Array.filter<Student>(students, func (s : Student) : Bool {
      s.id != studentId
    });
  };
};
