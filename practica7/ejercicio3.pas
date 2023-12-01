{3. Una remisería dispone de información acerca de los viajes realizados durante el mes de mayo de 2020.
De cada viaje se conoce: número de viaje, código de auto, dirección de origen, dirección de destino y
kilómetros recorridos durante el viaje. Esta información se encuentra ordenada por código de auto y
para un mismo código de auto pueden existir 1 o más viajes. Se pide:
a. Informar los dos códigos de auto que más kilómetros recorrieron.
b. Generar una lista nueva con los viajes de más de 5 kilómetros recorridos, ordenada por número de
viaje.}

program ejercicio3;
type
  viaje = record
    numeroDeViaje:integer;
    codigoDeAuto:integer;
    direccionDeOrigen:string;
    direccionDeDestino:string;
    kilometros:integer;
  end;

  lista = ^nodo;
  nodo = record
    dato: viaje;
    sig:lista;
  end;

  procedure leerViaje(var v:viaje);
  begin
    writeln('ingrese el viaje');
    readln(v.numeroDeViaje);
    writeln('ingrese el codigo de auto');
    readln(v.codigoDeAuto);
    writeln('ingrese la direccion de origen');
    readln(v.direccionDeOrigen);
    writeln('ingrese la direccion de destino');
    readln(v.direccionDeDestino);
    writeln('ingrese la cantidad de kilometros');
    readln(v.kilometros);
  end;

  procedure agregarOrdenadoPorViaje (var L: lista; v: viaje);
  var 
    ant, nue, act: lista;
  begin
    new (nue);
    nue^.dato := v;
    act := L;
    ant := L;
    while (act <> NIL) and (act^.dato.numeroDeViaje < v.numeroDeViaje) do begin
      ant := act;
      act := act^.sig ;
    end;
    if (ant = act)  then 
        L:= nue   
    else  
        ant^.sig  := nue; 
    nue^.sig := act ;
  end;

  procedure agregarOrdenadoPorAuto (var L: lista; v: viaje);
  var 
    ant, nue, act: lista;
  begin
    new (nue);
    nue^.dato := v;
    act := L;
    ant := L;
    while (act <> NIL) and (act^.dato.codigoDeAuto < v.codigoDeAuto) do begin
      ant := act;
      act := act^.sig ;
    end;
    if (ant = act)  then 
        L:= nue   
    else  
        ant^.sig  := nue; 
    nue^.sig := act ;
  end;
  
  procedure cargarLista(var L:lista);
  var
    v:viaje;
  begin
    leerViaje(v);
    while (v.codigoDeAuto <> 0) do begin
      agregarOrdenadoPorAuto(L,v);
      leerViaje(v);
    end;
  end;

  procedure recorrerLista(L:lista; var codigo1,codigo2:integer; var L2:lista);
  var
    max1,max2,actual,cant:integer;
  begin
    max1:= 0;
    max2:= 0;
    actual:= -1;
    while (L <> nil) do begin
      cant:= 0;
      actual:= L^.dato.codigoDeAuto;
      while (L <> nil) and (actual = L^.dato.codigoDeAuto) do begin
        cant:= cant + L^.dato.kilometros;
        if (L^.dato.kilometros > 5) then
          agregarOrdenadoPorViaje(L2,L^.dato);
        L:= L^.sig;
      end;
      if (actual > max1) then begin
        max2:= max1;
        codigo2:= codigo1;
        max1:= cant;
        codigo1:= actual;
      end
      else
        if (actual > max2) then begin
          max2:= cant;
          codigo2:= actual;
        end;
    end;
  end;
  
  procedure informarListaNueva(L:lista);
  begin
    while (L <> nil) do begin
      writeln(L^.dato.numeroDeViaje);
      L:= L^.sig;
    end;
  end;
  
var
  L,L2:lista;
  codigo1,codigo2:integer;
begin
  cargarLista(L); {se dispone, ordenada por codigo de auto, para un mismo codigo puede haber mas de un viaje}

  recorrerLista(L,codigo1,codigo2,L2);
  
  writeln(codigo1, ' y el segundo ', codigo2);
  
  informarListaNueva(L2);
end.
