{1. Una productora nacional realiza un casting de personas para la selección de actores extras de una nueva
película, para ello se debe leer y almacenar la información de las personas que desean participar de
dicho casting. De cada persona se lee: DNI, apellido y nombre, edad y el código de género de actuación
que prefiere (1: drama, 2: romántico, 3: acción, 4: suspenso, 5: terror). La lectura finaliza cuando llega
una persona con DNI 33555444, la cual debe procesarse.
Una vez finalizada la lectura de todas las personas, se pide:
a. Informar la cantidad de personas cuyo DNI contiene más dígitos pares que impares.
b. Informar los dos códigos de género más elegidos.
c. Realizar un módulo que reciba un DNI, lo busque y lo elimine de la estructura. El DNI puede no
existir. Invocar dicho módulo en el programa principaln.}

program ejercicio1practica7;
type
  crango = 1..5; {rango especial para tener ordenados por genero de actuacion}

  persona = record {registro persona con todos sus datos}
    dni:integer;
    apeynom:string;
    edad:integer;
    codigo: crango;
  end;
  
  vector = array [crango] of integer;
  
  lista = ^nodo; {hago una lista para guardar las personas por que nose la cantidad total}
  nodo = record
    dato: persona;
    sig:lista;
  end;

procedure leerPersona(var P:persona);
begin
  writeln('Ingrese el dni');
  readln(P.dni);
  writeln('Ingrese el apeynom');
  readln(P.apeynom);
  writeln('Ingrese la edad');
  readln(P.edad);
  writeln('Ingrese el codigo de genero');
  readln(P.codigo);
end;

procedure agregarAdelante(var L:lista ; P:persona);
var
  nue:lista;
begin
  new(nue);
  nue^.dato:= P;
  nue^.sig:= L;
  L:= nue;
end;

procedure cargarLista(var L:lista);
var
  P:persona;
begin
  repeat
    leerPersona(P);
    agregarAdelante(L,P);
  until (P.dni = 335)
end;

procedure inicializarVector(var V:vector);
var
  i:integer;
begin
  for i:= 1 to 5 do
    v[i]:= 0;
end;

procedure dosMaximos(v:vector; var codigo1,codigo2:integer);
var
  i,max1,max2:integer;
begin
  codigo1:= 0;
  codigo2:= 0;
  max1:= 0;
  max2:= 0;
  for i:= 1 to 5 do begin
    if (v[i] > max1) then begin
      max2:= max1;
      codigo2:= codigo1;
      max1:= v[i];
      codigo1:= i;
    end
    else 
      if (v[i] > max2) then begin
        max2:= v[i];
        codigo2:= i;
      end;
  end;
end;

function masParesQueImpares(num:integer):boolean;
var
  pares,impares:integer;
begin
  pares:= 0;
  impares:= 0;
  while (num <> 0) do begin
    if ((num mod 10) mod 2 = 0) then
      pares:= pares + 1
    else
      impares:= impares + 1;
    num:= num div 10;
  masParesQueImpares:= (pares > impares);
  end;
end;

procedure recorrerLista(L:lista; var V:vector; var cant:integer);
begin
  while (L <> nil) do begin
    if (masParesQueImpares(L^.dato.dni)) then
      cant:= cant + 1;
    V[L^.dato.codigo]:= V[L^.dato.codigo] + 1;
    L:= L^.sig;
  end;
end;

procedure eliminarDNI (var L:lista ; dni:integer);
var
  act,ant:lista;
begin
  act:=L; 
  while (act <> nil) and (act^.dato.dni <> dni) do begin
    ant:= act; 
    act:= act^.sig;
  end;
  if (act <> nil) then begin
    if (act = L) then 
      L:= L^.sig
    else
      ant^.sig:= act^.sig;
    dispose (act);
    writeln('el dni fue eliminado')
  end
  else
    writeln('no se encontraba ese dni en la lista');
end;

var
  V:vector;
  L:lista;
  dni,cantMasParesQueImpares,codigo1,codigo2:integer;
begin
  cargarLista(L); {carga la lista de personas}
  
  inicializarVector(V); {inicializa en 0 todas las posiciones del vector}
  recorrerLista(L,V,cantMasParesQueImpares); {recorre la lista, devuelve esa cant, y carga el vector dividido por generos}
  
  dosMaximos(V,codigo1,codigo2); {me devuelve los dos generos del vector con mas personas cargadas}
  
  writeln('Ingrese el dni que quiera eliminar'); {lee un dni, lo busca y si lo encuentra lo elimina, si no, informa que no pudo}
  readln(dni);
  eliminarDNI(L,dni);
  
  writeln('la cantidad de dni mas pares que impares es ',cantMasParesQueImpares);
  
  writeln('el codigo con mas personas es ',codigo1,' y el segundo es ',codigo2);
end.
