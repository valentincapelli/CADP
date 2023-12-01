{6. El Observatorio Astronomico de La Plata ha realizado un relevamiento sobre los distintos objetos
astronomicos observados durante el anio 2015. Los objetos se clasifican en 7 categorias: 1: estrellas,
2: planetas, 3: satelites, 4: galaxias, 5: asteroides, 6: cometas y 7: nebulosas.
Al observar un objeto, se registran los siguientes datos: codigo del objeto, categoria del objeto (1..7),
nombre del objeto, distancia a la Tierra (medida en anios luz), nombre del descubridor y anio de su
descubrimiento.
A. Desarrolle un programa que lea y almacene la informacion de los objetos que han sido
observados. Dicha informacion se lee hasta encontrar un objeto con codigo -1 (el cual no debe
procesarse). La estructura generada debe mantener el orden en que fueron leidos los datos.
B. Una vez leidos y almacenados todos los datos, se pide realizar un reporte con la siguiente
informacion:
1. Los codigos de los dos objetos mas lejanos de la tierra que se hayan observado.
2. La cantidad de planetas descubiertos por "Galileo Galilei" antes del anio 1600.
3. La cantidad de objetos observados por cada categoria.
4. Los nombres de las estrellas cuyos codigos de objeto poseen mas digitos pares que
impares.}

program ejercicio6;
type
  crango = 1..7;
  objeto = record
    codigo:integer;
    categoria: crango;
    nombre:string;
    distancia:integer;
    descubridor:string;
    anioDeDescubrimiento:integer;
  end;

  vector = array [crango] of integer;
  
  lista = ^nodo;
  nodo = record
    dato:objeto;
    sig:lista;
  end;

  procedure leerObjeto(var o:objeto);
  begin
    writeln('Ingrese el codigo');
    readln(o.codigo);
    if (o.codigo <> -1) then begin
      writeln('Ingrese la categoria');
      readln(o.categoria);
      writeln('Ingrese el nombre');
      readln(o.nombre);
      writeln('Ingrese la distancia ');
      readln(o.distancia);
      writeln('Ingrese el descubridor');
      readln(o.descubridor);
      writeln('Ingrese el anio de descubrimiento');
      readln(o.anioDeDescubrimiento);
    end;
  end;

  procedure agregarAtras(var L,ult:lista; o:objeto);
  var
    nue:lista;
  begin
    new(nue);
    nue^.dato:= o;
    nue^.sig:= nil;
    if (L <> nil) then
      ult^.sig:= nue
    else
      L:= nue;
    ult := nue;
  end;

  procedure cargarLista(var L:lista);
  var
    o:objeto;
    ult:lista;
  begin
    leerObjeto(o);
    while (o.codigo <> -1) do begin
      agregarAtras(L,ult, o);
      leerObjeto(o);
    end;
  end;

  procedure inicializarVector(var V:vector);
  var
    i:integer;
  begin
    for i:= 1 to 7 do
      V[i]:= 0;
  end;

  procedure calcularMaximos(codigo,distancia:integer; var max1,max2,codigoLejano1,codigoLejano2:integer);
  begin
    if (distancia > max1) then begin
      max2:= max1;
      codigoLejano2:= codigoLejano1;
      max1:= distancia;
      codigoLejano1:= codigo;
    end
    else
    if (distancia > max2) then begin
      max2:= distancia;
      codigoLejano2:= codigo;
    end;
  end;

  function cumpleCantGalileo(categoria:crango; descubridor:string; anioDeDescubrimiento:integer):boolean;
  begin
    cumpleCantGalileo:= (categoria = 2) and (descubridor = 'Galileo Galilei') and (anioDeDescubrimiento < 1600);
  end;

  function cumplePares(num:integer):boolean;
  var
    pares,impares:integer;
  begin
    pares:= 0;
    impares:= 0;
    while (num <> 0) do begin
      if (num mod 10) mod 2 = 0 then
        pares:= pares + 1
      else
        impares:= impares + 1;
      num:= num  div 10;
    end;
    cumplePares:= pares > impares;
  end;

  procedure recorrerLista(L:lista; var V:vector);
  var
    max1,max2,codigoLejano1,codigoLejano2,cantGalileo:integer;
  begin
    max1:= -1;
    max2:= -1;
    cantGalileo:= 0;
    while (L <> nil) do begin
      calcularMaximos(L^.dato.codigo, L^.dato.distancia, max1, max2, codigoLejano1, codigoLejano2); {inciso 1}

      if (cumpleCantGalileo(L^.dato.categoria, L^.dato.descubridor, L^.dato.anioDeDescubrimiento)) then {inciso 2}
        cantGalileo:= cantGalileo + 1;

      V[L^.dato.categoria]:= V[L^.dato.categoria] + 1; {inciso 3}

      if (L^.dato.categoria = 1) and (cumplePares(L^.dato.codigo)) then      {inciso 4}
        writeln('El nombre de la estrella cuyo codigo de objeto posee mas digitos pares que impares ', L^.dato.nombre);

      L:= L^.sig;
    end;
    writeln('Los codigos de los dos objetos mas lejanos de la tierra que se hayan observado son ', codigoLejano1 ,' y el segundo ', codigoLejano2 );
    writeln('La cantidad de planetas descubiertos por "Galileo Galilei" antes del anio 1600 ' , cantGalileo);
  end;
  procedure recorrerVector(V:vector);
  var
    i:integer;
  begin
    begin
      for i:= 1 to 7 do
        writeln('La cantidad de objetos observados por la categoria ', i ,' es ' , v[i]);
    end;
  end;

var
  L:lista;
  V:vector;
begin
  cargarLista(L); {cargar lista de objetos usando agregarAtras}
  
  inicializarVector(V);

  recorrerLista(L,V); {recorre la lista, calcula 2 mas lejanos, carga vector contador, cant descubierta por galileo e informa las estrellas con mas pares }

  recorrerVector(V); {recorre el vector e informa la cantidad de objetos observados por cada categoria}
end.
