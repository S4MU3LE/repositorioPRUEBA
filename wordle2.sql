



create table usuarios (

nombreUsuario nvarchar (100) primary key,
acertado int,
)
create table palabras (

ID int primary key,
Palabra nvarchar (5) not null,
)

--no seguro todavia
bulk insert palabras from 'C:\Archivos de programa\docker\Docker\SQLServer\backup\listawordleESP.txt'
with (FIRSTROW = 1, ROWTERMINATOR = '\n')


create table intentos (

ID int primary key,
IDPalabra int not null,
numIntento int not null,
nombreUsuario nvarchar (100),CONSTRAINT fkus foreign key (nombreUsuario) references usuarios(nombreUsuario),
CONSTRAINT fk1 foreign key (IDPalabra) references palabras (ID)
)


go
create or alter function Resolver (@nombre as nvarchar(100), @palabra as nvarchar(5))
returns varchar(5)
as
begin
declare @resultado as nvarchar(5)
declare @palabradeldia as nvarchar(5)
declare @contador as int
declare @contador2 as int
declare @letraPalabradeldia as nvarchar(1)
declare @letraAcomparar as nvarchar(1)set @contador = 1
set @contador2 = 1
set @palabradeldia = (Select ID from palabras --where ID = falta condicion)while @contador < 5
begin
set @letraAcomparar = Substring(@palabra,@contador,1) while @contador2 < 5
begin
set @letraPalabradeldia = Substring(@palabradeldia,@contador2,1)
if @letraAcomparar = @letraPalabradeldia and @contador = @contador2
set @resultado = @resultado + 'Correcto' if @letraAcomparar = @letraPalabradeldia and @contador <> @contador2
set @resultado = @resultado + 'posicion Incorrecta' else
set @resultado = @resultado + 'X' set @contador2 = @contador2 + 1
end set @contador = @contador + 1
end
return @resultado
end


