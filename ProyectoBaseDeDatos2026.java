import java.io.*;
import java.sql.*;
import java.util.Scanner;

public class proyecto {
    // conección a una base de datos
    private static final String driver = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/Proyecto base de datos 2026?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "ricardo@";

    public static Connection connect() {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Conexión establecida.");
        } catch (SQLException e) {
            System.err.println("Error al conectar: " + e.getMessage());
        }
        return connection;
    }

    public static int Agregar(Scanner sc) {
        // leo lo que ingresa la persona con el scanner
        System.out.print("Ingrese los datos del proveedor,\nPrimero su nro de CUIT: ");
        System.out.print("CUIT: ");
        String CUIT = sc.nextLine();
        System.out.print("Telefono Fijo: ");
        String TEL_FIJO = sc.nextLine();
        System.out.print("Direccion: ");
        String DIRECCION = sc.nextLine();
        System.out.print("Razon Social: ");
        String RAZON_SOCIAL = sc.nextLine();
        // intento de inserción
        try {
            Connection conn = connect();
            PreparedStatement ps = conn.prepareStatement("INSERT INTO proveedor (CUIT,TEL_FIJO,DIRECCION,RAZON_SOCIAL) VALUES (?,?,?,?)");
            ps.setString(1, CUIT);
            ps.setString(2, TEL_FIJO);
            ps.setString(3, DIRECCION);
            ps.setString(4, RAZON_SOCIAL);
            ps.executeUpdate();
            conn.close();
        } catch (SQLException e) {
            System.out.println("ERROR al ingresar: " + e.getMessage());
        }
        return 0;
    }

    public static int Eliminar(Scanner sc) {
        // leo lo que ingresa la persona con el scanner
        System.out.print("Ingrese el numero,\n de CUIT a eliminar: ");
        System.out.print("nro: ");
        String CUIT = sc.nextLine();
        sc.nextLine();
        // intento de eliminacion
        try {
            Connection conn = connect();
            PreparedStatement ps = conn.prepareStatement("DELETE FROM proveedor WHERE CUIT = ?");
            ps.setString(1, CUIT);
            ps.executeUpdate();
            conn.close();
        } catch (SQLException e) {
            System.out.println("ERROR al ingresar: " + e.getMessage());
        }
        return 0;
    }

    public static int Listar(Scanner sc) {
        // leo lo que ingresa la persona con el scanner
        System.out.print("Listado de Proveedores: \n");
        try {
            Connection conn = connect();
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT CUIT, TEL_FIJO, DIRECCION, RAZON_SOCIAL FROM proveedor = ?");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                System.out.printf("- CUIT: %d | Teléfono: %d | Dirección: %s | Razón Social: %s%n",
                    rs.getInt("CUIT"),
                    rs.getInt("TEL_FIJO"),
                    rs.getString("DIRECCION"),
                    rs.getString("RAZON_SOCIAL")
                );
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static int verificar(String ing, Scanner sc) {
        ing = ing.toLowerCase();
        if (ing.equals("salir") || ing.equals("exit") || ing.equals("4")) {
            return -1;
        }
        if (ing.equals("agregar") || ing.equals("1")) {
            return Agregar(sc);
        }
        if (ing.equals("eliminar") || ing.equals("2")) {
            return Eliminar(sc);
        }
        if (ing.equals("listar") || ing.equals("3")) {
            return Listar(sc);
        }
        System.out.println("Opcion incorrecta.");
        return 0;
    }

    public static void main(String[] args) {
        int selection = 0;
        Scanner sc = new Scanner(System.in);
        while (selection > -1) {
            System.out.println(
                    "\nQue desea realizar:\n" +
                    "    1) Agregar un Proveedor (agregar).\n" +
                    "    2) Eliminar un Proveedor (eliminar).\n" +
                    "    3) Listar Proveedores (listar).\n" +
                    "    4) Salir:"
            );
            String ingreso = sc.nextLine();
            selection = verificar(ingreso, sc);
        }
        sc.close();
        System.out.println("Programa finalizado.");
    }
}