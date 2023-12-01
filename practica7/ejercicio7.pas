{7. La Facultad de Informatica desea procesar la informacion de los alumnos que finalizaron la carrera de
Analista Programador Universitario. Para ello se debera leer la informacion de cada alumno, a saber:
numero de alumno, apellido, nombres, direccion de correo electronico, anio de ingreso, anio de egreso
y las notas obtenidas en cada una de las 24 materias que aprobo (los aplazos no se registran).
1. Realizar un modulo que lea y almacene la informacion de los alumnos hasta que se ingrese el
alumno con numero de alumno -1, el cual no debe procesarse. Las 24 notas correspondientes a
cada alumno deben quedar ordenadas de forma descendente.
2. Una vez leida y almacenada la informacion del inciso 1, se solicita calcular e informar:
a. El promedio de notas obtenido por cada alumno.
b. La cantidad de alumnos ingresantes 2012 cuyo numero de alumno esta compuesto
unicamente por digitos impares.
c. El apellido, nombres y direccion de correo electronico de los dos alumnos que mas rapido
se recibieron (o sea, que tardaron menos anios)
3. Realizar un modulo que, dado un numero de alumno leido desde teclado, lo busque y elimine de
la estructura generada en el inciso 1. El alumno puede no existir}

program ejercicio7;
type
  vector = array [1..24] of real;

  alumno = record
    numeroDeAlumno:integer;
    ayn:string;
    correo:string;
    anioDeIngreso:integer;
    anioDeEgreso:integer;
    notas:vector;
  end;
  
  lista = ^nodo;
  nodo = record
    dato:alumno;
    sig:lista;
  end;

  procedure leerNotas(var v:vector);
  var
    i:integer;
  begin
  end;

  procedure leerAlumno(var a:alumno);
  var
    i:integer;
  begin
    read(c.numeroDeAlumno);
    if (c.numeroDeAlumno <> -1) then begin
      read(c.ayn);
      read(c.correo);
      read(c.anioDeIngreso);
      read(c.anioDeEgreso);
      leerNotas(c.notas);  {lee las 24 notas y las devuelve ordenadas}
    end;
  end;

  procedure cargarLista(var L:lista);
  var
    a:alumno;
  begin
    leerAlumno(a);   {lee los campos y debe devolver el vector de notas ordenado en forma descendente}
    while (a.numeroDeAlumno <> -1) do begin
      agregarAdelante(L, a);
      leerAlumno(a);
    end;
  end;

  procedure recorrerLista(L:lista);
  var
    cant2012:integer;
  begin
    while (L <> nil ) do begin
      informarPromedio(L^.dato.notas);

      if (cumpleImpares2012(L^.dato.numeroDeAlumno, L^.dato.anioDeIngreso)) then
        cant2012:= cant2012 + 1;

      calcularDosMinimos(L^.dato, ayn1, ayn2, correo1, correo2, min1, min2);
      L:= L^.sig;
    end;
  end;

var
  L:lista;
begin
  cargarLista(L); {carga lista con alumnos, las notas de cada alumno deben quedar ordenadas de forma descendente en su vector}

  recorrerLista(L); {recorre lista, informa promedio de notas de cada alumno, cantidad ingresantes 2012 con numero digitos impares, dos mas rapidos en recibirse}

  eliminar(L); {lee un numero de alumno desde teclado lo busca en la lista y si esta lo elimina}

end.