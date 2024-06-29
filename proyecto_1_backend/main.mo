import Text "mo:base/Text";
import Nat "mo:base/Nat";

actor {
  var nick : Text = "hola";
  var age : Nat = 15;
  var name : Text = "";

  // query: método únicamente de lectura
  public query func greet(name : Text) : async Text {
    return "Hello estimado usuario, " # name # "!";
  };

  // update: método para actualizar el estado
  public func setNumb(texto : Nat) : async Nat {
    age := age + 14;
    return age;
  };

  public func setNickname(texto : Text) : async () {
    nick := texto;
  };

  // Método setName que recibe un texto como parámetro
  public func setName(newName : Text) : async () {
    name := newName;
  };

  // Método getName que regresa el texto previamente pasado a setName
  public query func getName() : async Text {
    return name;
  };
};
