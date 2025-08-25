# EQUIPO-2
Jose Condor 
Anghelo Goicochea

Crear un contenedor SQL Server y conectarse a él usando Docker Compose
1. Crear el archivo docker-compose.yml para SQL Server
Primero, crea un archivo llamado docker-compose.yml en el directorio de tu proyecto.
El archivo docker-compose.yml tendrá la configuración necesaria para levantar el contenedor de SQL Server.
Contenido del archivo docker-compose.yml:

<img width="753" height="492" alt="image" src="https://github.com/user-attachments/assets/ee18cbdb-0061-4390-ba9a-90dd125737c2" />

Explicación de cada parte del archivo:
image: mcr.microsoft.com/mssql/server:2022-latest: Es la imagen oficial de SQL Server para Linux.


ACCEPT_EULA=Y: Aceptamos el acuerdo de licencia de SQL Server.


MSSQL_SA_PASSWORD=YourPassword123: Establece la contraseña para el usuario sa (que es el administrador de SQL Server). Cambia esta contraseña por algo más seguro.


ports: "1433:1433": Mapea el puerto 1433 del contenedor al puerto 1433 de tu máquina local, para que puedas conectarte desde tu máquina local.


volumes: sql-data:/var/opt/mssql: Usamos un volumen persistente para los datos de SQL Server. Esto garantiza que los datos no se pierdan si el contenedor se detiene o se elimina.


networks: db-network: Definimos una red personalizada llamada db-network para que otros contenedores puedan acceder al contenedor de SQL Server si es necesario.



2. Levantar el contenedor usando Docker Compose
Una vez que tengas el archivo docker-compose.yml listo, abre una terminal en el directorio donde se encuentra el archivo.
Para levantar el contenedor, ejecuta el siguiente comando:
docker-compose up -d

-d: Ejecuta los contenedores en segundo plano (detached mode).


Este comando descargará la imagen de SQL Server (si no la tienes) y levantará el contenedor de SQL Server en tu máquina.

3. Verificar que el contenedor está corriendo
Para asegurarte de que el contenedor está en funcionamiento, ejecuta el siguiente comando:
docker ps

Este comando te mostrará los contenedores en ejecución. Deberías ver algo como esto:

<img width="757" height="108" alt="image" src="https://github.com/user-attachments/assets/bce0bec8-7cea-4c7d-9b89-fea1bc90fa36" />

Verifica que el puerto 1433 esté mapeado correctamente.

4. Conectarse a SQL Server usando SQL Server Management Studio (SSMS)
Ahora que el contenedor está corriendo, puedes conectarte a SQL Server de la siguiente manera:
Abre SQL Server Management Studio (SSMS).


Conexión:


Server Name: localhost,1433
 Esto indica que te estás conectando al servidor SQL en tu máquina local en el puerto 1433.


Authentication: SQL Server Authentication.


Login: sa (el nombre de usuario predeterminado).


Password: YourPassword123 (la contraseña que configuraste en el archivo docker-compose.yml).


Haz clic en "Connect" para conectar.
Se vera algo asi:
<img width="385" height="457" alt="image" src="https://github.com/user-attachments/assets/d6b3d1dc-c007-42eb-90b8-857010c579d4" />

5.- Crear un archivo sql para crear la bd ,tablas y relaciones

<img width="753" height="324" alt="image" src="https://github.com/user-attachments/assets/56d02442-debd-4483-ae4f-ae2416264cdc" />
