{4. Una maternidad dispone informacion sobre sus pacientes. De cada una se conoce: nombre, apellido y
peso registrado el primer dia de cada semana de embarazo (a lo sumo 42). La maternidad necesita un
programa que analice esta informacion, determine e informe:
a. Para cada embarazada, la semana con mayor aumento de peso.
b. El aumento de peso total de cada embarazada durante el embarazo.}

program ejercicio4;
type
  srango = 1..42;
  vector = array [srango] of real;
  paciente = record
    nya:string;
    semanas:vector;
    cantsemanas:srango;
  end;
  lista = ^nodo
  nodo = record
    dato:paciente;
    sig:lista;
  end;

  procedure recorrerVector(v:vector; diml:integer; var semanaMax:integer; var aumentoTotal:real);
  var
    i:integer;
    max:real;
  begin
    aumentoTotal:= 0;
    max:= 0;
    semanaMax:= 1;
    for i:= 2 to diml do begin
      if  ((v[i] - v[i-1]) > max) then
        max:= (v[i] - v[i-1]);
        semanamax:= i;
      aumentoTotal:= aumentoTotal + v[i];
    end;
  end;

  procedure recorrerLista(L:lista);
  begin
    while (L  <> nil) do begin
      recorrerVector(L^.dato.semanas, L^.dato.cantsemanas,semanaMax,aumentoTotal);
      writeln(L^.dato.nya);
      writeln('La semana con mayor aumento es ' , semanaMax , ' y el aumento de peso total durante del embarazo es ' , aumentoTotal);
      L:= L^.sig;
    end;
  end;

var
  L:lista;
begin
  L:= nil;
  cargarLista(L); { se dispone }

  recorrerLista(L); {recorre lista, informa semana con mayor aumento de peso y el peso total de cada embarazada}
end.
