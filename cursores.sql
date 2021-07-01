go
use example_one
go
-- Vistas
/*EJERCICIO 1. Crear una vista que liste DIFERENTES de PROVEEDOR */
create view ViewOne
as
	select	p.nit		as	NIT,
			p.nombre	as  NOMBRE,
			p.direciion as DIRECION
	from PROVEEDOR p
go
select * from ViewOne
go
/*EJERCICIO 2. Crear una vista que MUESTRE LOS NOMBRES INVERTIDOS*/
go
create view ViewTwo
as
	select reverse(c.nombre) as NombreInvertido
	from CLIENTES c
go
select * from ViewTwo
go
/*EJERCICIO 3. Crear una vista muestre las direciones de los clinetes que tengan al menosun caracter 'al'*/
go
create view Viewthree
as
	select DIRECION = direciion from CLIENTES
	where direciion like '%al%'
go
select * from Viewthree
go
-- Procedimientos Almacenados
go
/*EJERCICIO 1. Crear un Procedimientos Almacenados  que liste las 'tablet' */
create procedure proc_proveedor
as
	select * from dbo.PROVEEDOR
	where nombre = 'phone'
	return
go
exec proc_proveedor;
go
/* EJERCICIO 2 Procedimientos Almacenados usando TABLA TEMPORAL o VIRTUAL*/
go
create proc proc_tabla_tempo
as
	create table #TablaVirtual (Tablas_Tarea_N varchar(50) not null)
	insert into #TablaVirtual values	('clientes'),
										('proveedores'),
										('fecha de nacimiento'),
										('telefono')
	select TABLAS = Tablas_Tarea_N from #TablaVirtual
return
go
exec proc_tabla_tempo
go


/*Ejercicio 3. mostral las lista de precion reduciendo 10% de su valor actual-*/
go
create proc proc_rebajas
as
	
	select codigo,nombre,
					precio AS NORMAL,
					(precio/100)*10 AS DECUENTO ,
					(precio/100)*90 AS TOTAL_PAGAR 
		from PRODUCTOS
return
go
exec proc_rebajas
go
-- Cursores
/*ejercicio #1. uno mostral lista de de clientes*/
go
declare cursor_example_one cursor
	for select dni, nombre, apellido, direciion  from dbo.CLIENTES
		open cursor_example_one
		declare @cod varchar(50), @nombre varchar(50), @apellido varchar(50), @direciion varchar(50)
		fetch next from cursor_example_one into @cod, @nombre, @apellido, @direciion
		--Recupera una fila específica de un cursor de servidor de Transact-SQL.
		while @@fetch_status = 0
		--devuelve el estado de la última instrucción 
		--FETCH del cursor emitida contra cualquier cursor abierto actualmente por la conexión.
			begin
				print 'Codigo   : '	+ @cod
				print 'Nombre   : '	+ @nombre
				print 'Apellido : ' + @apellido
				print 'direcion : '	+ @direciion
				fetch next from cursor_example_one into @cod, @nombre, @apellido, @direciion 
				--Recupera una fila específica de un cursor de servidor de Transact-SQL.
			end
			-- BEGIN y END son palabras clave del lenguaje de control de flujo.
	close cursor_example_one
	--no se permite en cursores que solo están declarados o que ya están cerrados.
deallocate cursor_example_one 
--Quita una referencia a un cursor
go
/*Ejercicio 2. mostral un producto reduciendo 10% de su valor actual con cursoles en cursoles*/
go
declare cursor_example_two cursor
	for select	codigo, 
				nombre, 
				precio AS NORMAL,
				(precio/100)*10 AS DECUENTO ,
				(precio/100)*90 AS TOTAL_PAGAR 
		from dbo.PRODUCTOS 
		where nombre = 'Surface Pro3';

		open cursor_example_two
		declare @cod varchar(50),@nombre varchar(50),@precio_normal varchar(50),@total_descuento varchar(50),@precio_total varchar(50)
		fetch next from cursor_example_two into @cod, @nombre, @precio_normal, @total_descuento,@precio_total
		while @@fetch_status = 0
			begin
				print 'Codigo   : '	+ @cod
				print 'Nombre   : '	+ @nombre
				print 'Precio   : ' + @precio_normal
				print 'Descuento: '	+ @total_descuento
				print 'Total    : '	+ @precio_total
				fetch next from cursor_example_two into @cod, @nombre, @precio_normal,@total_descuento,@precio_total 
			end
	close cursor_example_two
deallocate cursor_example_two 
go

/*Ejercicio 3. hallar el precio mas bajo y el mas caro de productos*/
go
declare cursor_example_three cursor
	for select max(precio) AS Mayor ,min(precio) AS Menor 
		from PRODUCTOS;
		open cursor_example_three
		declare @Mayor varchar(50) ,@Menor varchar(50)
		fetch next from cursor_example_three into  @Mayor, @Menor
		while @@fetch_status = 0
			begin
				print 'Precio mas Caro   : ' + @Mayor
				print 'Precio mas bajo   : ' + @Menor
				fetch next from cursor_example_three into  @Mayor, @Menor
			end
	close cursor_example_three
deallocate cursor_example_three 
go

