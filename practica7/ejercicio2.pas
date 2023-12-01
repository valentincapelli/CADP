{2. Implementar un programa que lea y almacene información de clientes de una empresa aseguradora
automotriz. De cada cliente se lee: código de cliente, DNI, apellido, nombre, código de póliza contratada
(1..6) y monto básico que abona mensualmente. La lectura finaliza cuando llega el cliente con código
1122, el cual debe procesarse.
La empresa dispone de una tabla donde guarda un valor que representa un monto adicional que el
cliente debe abonar en la liquidación mensual de su seguro, de acuerdo al código de póliza que tiene
contratada.
Una vez finalizada la lectura de todos los clientes, se pide:
a. Informar para cada cliente DNI, apellido, nombre y el monto completo que paga mensualmente
por su seguro automotriz (monto básico + monto adicional).
b. Informar apellido y nombre de aquellos clientes cuyo DNI contiene al menos dos dígitos 9.
c. Realizar un módulo que reciba un código de cliente, lo busque (seguro existe) y lo elimine de la
estructura.}

program ejercicio2practica7;
type
  prango = 1..6;
  cliente = record
    codigo:integer;
    dni:integer;
    apellido:string;
    nombre:string;
    poliza: prango;
    monto:real;
  end;
  
var
  code:integer;
begin
  cargarLista(L); {carga la lista hasta que se lea el codigo 1122}
  
  recorrerLista(L,); {recorrer lista informar datos personales y monto total, y ademas informar ape y nom cuyo
  dni contiene al menos dos digitos 9}
  
  writeln('ingrese un codigo de cliente que desee eliminar');
  readln(code);
  eliminar(code); { busca el codigo pasado por parametro y me informa que lo elimino}
end.