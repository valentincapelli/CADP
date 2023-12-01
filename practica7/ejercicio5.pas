{5. Una empresa de transporte de cargas dispone de la informacion de su flota compuesta por 100
camiones. De cada camion se tiene: patente, anio de fabricacion y capacidad (peso maximo en
toneladas que puede transportar).
Realizar un programa que lea y almacene la informacion de los viajes realizados por la empresa. De
cada viaje se lee: codigo de viaje, codigo del camion que lo realizo (1..100), distancia en kilometros
recorrida, ciudad de destino, anio en que se realizo el viaje y DNI del chofer. La lectura finaliza cuando
se lee el codigo de viaje -1.
Una vez leida y almacenada la informacion, se pide:
1. Informar la patente del camion que mas kilometros recorridos posee y la patente del camion que
menos kilometros recorridos posee.
2. Informar la cantidad de viajes que se han realizado en camiones con capacidad mayor a 30,5
toneladas y que posean una antiguedad mayor a 5 anios al momento de realizar el viaje (anio en
que se realizo el viaje).
3. Informar los codigos de los viajes realizados por choferes cuyo DNI tenga solo digitos impares.
Nota: Los codigos de viaje no se repiten.}

program ejercicio5;
type
  crango = 1..100;
  camion = record
    patente:integer;
    anioFabricacion:integer;
    capacidad:real;
  end;
  tablaCamiones = array [crango] of camion;

  viaje = record
    codigoDeViaje:integer;
    codigoDelCamion:crango;
    kilometros:real;
    destino:string;
    anioDelViaje:integer;
    DniDelChofer:integer;
  end;
  lista = ^nodo;
  nodo = record
    dato:viaje;
    sig:lista;
  end;

  tablaKilometraje = array [crango] of real;

  procedure cargarTabla(var TC: tablaCamiones);
  var
    i: integer;
  begin
  // Cargar datos de los 100 camiones, ejemplificando con valores aleatorios
    for i := 1 to 100 do begin
      TC[i].patente := i; // Ejemplo: Asignacion de valores de patente
      TC[i].anioFabricacion := Random(20) + 2000; // Ejemplo: Anio de fabricacion aleatorio entre 2000 y 2020
      TC[i].capacidad := Random(50) + 20; // Ejemplo: Capacidad aleatoria entre 20 y 70 toneladas
    end;
  end;

  procedure leerViaje(var v:viaje);
  begin
    writeln('Ingrese el codigo de viaje');
    readln(v.codigoDeViaje);
    if (v.codigoDeViaje <> -1) then begin
      writeln('Ingrese el codigo del camion');
      readln(v.codigoDelCamion);
      writeln('Ingrese la cantidad de kilometros recorridos ');
      readln(v.kilometros);
      writeln('Ingrese el destino');
      readln(v.destino);
      writeln('Ingrese el anio del viaje ');
      readln(v.anioDelViaje);
      writeln('Ingrese el dni del chofer');
      readln(v.DniDelChofer);
    end;
  end;
  procedure agregarAdelante(var L:lista; v:viaje);
  var
    nue:lista;
  begin
    new(nue);
    nue^.dato:= v;
    nue^.sig:= L;
    L:= nue;
  end;

  procedure cargarLista(var L:lista);
  var
    v:viaje;
  begin
    L:= nil;
    leerViaje(v);
    while (v.codigoDeViaje <> -1) do begin
      agregarAdelante(L,v);
      leerViaje(v);
    end;
  end;

  procedure inicializarTablaKilometraje(var TK:tablaKilometraje);
  var
    i:integer;
  begin
    for i:= 1 to 100 do
      TK[i]:= 0;
  end;

  function cumpleInciso2(capacidad:real; anioFabricacion,anioDelViaje:integer):boolean;
  begin
    cumpleInciso2:= (capacidad > 30.5) and ((anioDelViaje - anioFabricacion) > 5);
  end;

  function DNIimpar(dni:integer):boolean;
  var
    ok:boolean;
  begin
    ok:= true;
    while (dni <> 0) and (ok = true) do begin
      if ((dni mod 10) mod 2 = 0) then
        ok:= false;
      dni:= dni div 10;
    end;
    DNIimpar:= ok;
  end;

  procedure recorrerLista(L:lista; TC:tablaCamiones; var TK:tablaKilometraje);
  var
    cant:integer;
  begin
    cant:= 0;
    while (L <> nil) do begin
      TK[L^.dato.codigoDelCamion]:= TK[L^.dato.codigoDelCamion] + L^.dato.kilometros; {inciso 1}

      if (cumpleInciso2 (TC[L^.dato.codigoDelCamion].capacidad, TC[L^.dato.codigoDelCamion].anioFabricacion, L^.dato.anioDelViaje)) then { inciso 2}
        cant:= cant + 1;
      
      if (DNIimpar(L^.dato.DniDelChofer)) then  {inciso 3}
        writeln('codigo de viaje realizado por chofer cuyo DNI tiene solo digitos impares ' , L^.dato.codigoDeViaje);
      
      L:= L^.sig;
    end;
    writeln('la cant de viajes que cumplen con el inciso 2 es: ' , cant);
  end;

  procedure informarPatentes(TC:tablaCamiones; TK:tablaKilometraje);
  var
    i,maxCamion,minCamion:integer;
    max,min:real;
  begin
    max:= -1;
    min:= 9999;
    for i:= 1 to 100 do begin
      if (TK[i] > max) then begin
        max:= TK[i];
        maxCamion:= i;
      end;
      if (TK[i] < min) then begin
        min:= TK[i];
        minCamion:= i;
      end;
    end;
    writeln('La patente del camion con mas kilometros recorridos es: ', TC[maxCamion].patente);
    writeln('La patente del camion con menos kilometros recorridos es: ', TC[minCamion].patente);
end;

  var
    TK:tablaKilometraje;
    TC:tablaCamiones;
    L:lista;
  begin
    cargarTabla(TC); {se dispone}

    cargarLista(L); {carga una lista con viajes hasta que se lea el codigo de viaje -1}

    inicializarTablaKilometraje(TK); { inicializa en 0 todas las posiciones del vector}

    recorrerLista(L,TC,TK); { incisos 1, 2 y 3 }

    informarPatentes(TC,TK); { recorre el vector, calcula el max y el min en kilometrajes e informa sus respectivas patentes }
  end.
