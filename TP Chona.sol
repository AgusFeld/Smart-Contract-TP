pragma solidity ^0.8.10;

contract estudiante 
{
    string private _nombre;
    string private _apellido;
    string private _nombre_completo;
    string private _curso;
    address private _docente;
    mapping (string => uint8) private notas_materias;
    string[] private recorrerMapping; 

    constructor (string memory _nombre_, string memory _apellido_, string memory _curso_) 
    {
        _nombre = _nombre_;
        _apellido = _apellido_;
        _curso = _curso_;
        _docente = msg.sender;
    }

    function apellido() public view returns (string memory)
    {
        return _apellido;
    }

    function nombre_completo() public view returns (string memory)
    {
        return (abi.encodePacked(_nombre, " ", _apellido));
    }

    function curso() public view returns(string memory)
    {
        return _curso;
    }

    function set_nota_materia(uint8 nota, string memory materia) public 
    {
        require(msg.sender == _docente, "Solo un docente docente es capaz de poner notas");
        notas_materias[materia] = nota;
        recorrerMapping.push(materia);
    }

    function nota_materia(string memory materia) public view returns (uint8)
    { 
        return notas_materias[materia];
    } 

    function aprobo(string memory materia) public view returns (bool)
    {
        if (notas_materias[materia] >= 60)
        {
            return true;
        }
        return false;
    }

    function promedio() public view returns (uint)
    {
        uint CantidadMaterias = recorrerMapping.length;
        uint notas_totales = 0;
        
        for (uint8 i = 0; i < CantidadMaterias; i++)
        {
            notas_totales += notas_materias[recorrerMapping[i]];
        }

        return notas_totales / CantidadMaterias;
    }


}

// Opcional:

// A:
// Para que el Smart Contract acepte el promedio de los 4 bimestres se 
// necesitaría crear un array el cual indicaría el bimestre. 
// Para indicar el bimestre se necesitarían 4 mappings distintos 
// en los cuales el que utilize el contrato sería capaz de asignar 
// las notas de cada materia y asignarles un bimestre.

// B: 
// Lo que se podria hacer es que el docente ponga en un array los 
// valores como nombres de otros docentes que podrian ingresar via 
// un input, entonces siempre que alguno quiera entrar va a tener 
// que ser el docente que lo haya creado o alguno de 
// los docentes dentro del array.

// C: 

// D: