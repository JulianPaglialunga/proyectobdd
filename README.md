# Ejecución del programa Java – Calzados S.A.

## 1. Requisitos previos

Para ejecutar el programa es necesario contar con:

- Java JDK instalado.
- MySQL Server instalado y funcionando.
- MySQL Connector/J (controlador JDBC).
- La base de datos `calzados_sa` creada y con sus respectivas tablas.

El programa permite agregar, eliminar y listar proveedores almacenados en MySQL.

## 2. Configuración de la base de datos

Antes de ejecutar el programa, es necesario verificar los datos de conexión definidos en el archivo `proyecto.java`.

```java
private static final String URL = "jdbc:mysql://localhost:3306/calzados_sa?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
private static final String USER = "root";
private static final String PASSWORD = "TU_CONTRASEÑA";
```

Estos valores deben adaptarse a la configuración de MySQL de cada computadora.

- **URL:** indica la dirección del servidor y el nombre de la base de datos.
- **localhost:** indica que MySQL se ejecuta en la misma computadora que el programa Java.
- **3306:** es el puerto predeterminado de MySQL.
- **calzados_sa:** es el nombre de la base de datos utilizada por el proyecto.
- **USER:** usuario de MySQL con permisos para consultar, insertar y eliminar proveedores.
- **PASSWORD:** contraseña correspondiente al usuario de MySQL.

Si la base de datos se encuentra en otro servidor o utiliza un puerto diferente, se debe modificar la URL.

Por seguridad, se recomienda no publicar contraseñas reales en repositorios compartidos.

## 3. Verificar MySQL

Para comprobar que el servidor está funcionando, ejecutar:

```bash
sudo systemctl status mysql
```

Si aparece `active (running)`, significa que MySQL está activo.

Para acceder a MySQL desde la terminal:

```bash
mysql -u root -p
```

Ingresar la contraseña correspondiente.

Luego comprobar que la base de datos existe:

```sql
SHOW DATABASES;
USE calzados_sa;
SHOW TABLES;
```

Si la base de datos todavía no fue creada, ejecutar primero el script `calzados_sa.sql` y después el script de carga de datos.

**Importante:** el script de creación contiene instrucciones `DROP TABLE`, que eliminan las tablas y sus datos existentes. No debe ejecutarse nuevamente si se desea conservar la información cargada.

## 4. Instalación del conector JDBC

Para que Java pueda comunicarse con MySQL es necesario tener instalado MySQL Connector/J.

En Ubuntu, si se descargó el paquete `.deb`, puede instalarse desde la carpeta donde se encuentra utilizando:

```bash
sudo apt install ./mysql-connector-j*.deb
```

Para encontrar la ubicación del controlador instalado:

```bash
dpkg -L mysql-connector-j | grep '\.jar$'
```

En la computadora utilizada para desarrollar este proyecto, el controlador se encuentra en:

```text
/usr/share/java/mysql-connector-j-26.10.0.jar
```

La ubicación y versión pueden variar según la instalación.

## 5. Compilación del programa

Abrir una terminal en el directorio donde se encuentra `proyecto.java`.

Ejecutar:

```bash
javac proyecto.java
```

Este comando compila el programa y genera el archivo `proyecto.class`.

## 6. Ejecución del programa

Para ejecutar el programa incluyendo el controlador JDBC:

```bash
java -cp ".:/usr/share/java/mysql-connector-j-26.10.0.jar" proyecto
```

El parámetro `-cp` (*classpath*) indica dónde Java debe buscar las clases y bibliotecas necesarias.

- `.` indica el directorio actual, donde se encuentra `proyecto.class`.
- `/usr/share/java/mysql-connector-j-26.10.0.jar` es la ubicación del controlador JDBC de MySQL.
- `proyecto` es la clase principal que contiene el método `main`.

Si el conector se encuentra en otra ubicación, se deberá reemplazar la ruta por la correspondiente.

## 7. Uso del programa

Una vez ejecutado, aparecerá el siguiente menú:

```text
Que desea realizar:
    1) Agregar un Proveedor (agregar).
    2) Eliminar un Proveedor (eliminar).
    3) Listar Proveedores (listar).
    4) Salir:
```

El usuario puede ingresar el número de la opción o su nombre.

**Opción 1 – Agregar proveedor**

Permite registrar un proveedor solicitando CUIT, teléfono fijo, dirección y razón social. El CUIT debe ser único.

**Opción 2 – Eliminar proveedor**

Solicita el CUIT del proveedor que se desea eliminar. Si existe y la operación está permitida por las restricciones de la base de datos, se elimina el registro.

**Opción 3 – Listar proveedores**

Muestra todos los proveedores registrados, incluyendo CUIT, teléfono fijo, dirección y razón social.

**Opción 4 – Salir**

Finaliza la ejecución del programa.

## 8. Posibles errores

**Error: `No suitable driver found`**

Java no encuentra el controlador JDBC. Se debe verificar que el archivo `.jar` exista y que su ruta esté correctamente indicada mediante `-cp`.

**Error: `Access denied for user`**

Las credenciales de MySQL son incorrectas o el usuario no tiene los permisos necesarios. Revisar `USER`, `PASSWORD` y los permisos del usuario.

**Error: `Unknown database 'calzados_sa'`**

La base de datos no existe en el servidor al que se intenta conectar. Verificar que se haya creado y que su nombre coincida con el indicado en la URL.

**Error: `Communications link failure`**

No se pudo establecer comunicación con MySQL. Verificar que el servidor esté funcionando y que la dirección y el puerto sean correctos.

**Error: `Duplicate entry`**

Se está intentando insertar un proveedor cuyo CUIT ya existe en la tabla.

## 9. Consideraciones finales

- El servidor MySQL debe estar activo durante la ejecución del programa.
- La base de datos debe existir antes de iniciar las operaciones.
- El controlador JDBC debe estar disponible en el classpath de Java.
- Las credenciales deben configurarse según la instalación de cada usuario.
- Las modificaciones realizadas desde el programa se almacenan directamente en la base de datos MySQL.
