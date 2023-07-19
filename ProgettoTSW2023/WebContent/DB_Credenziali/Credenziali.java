import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class Main {
    public static void main(String[] args) {
        // Carica il file config.properties
        Properties properties = new Properties();
        try (InputStream inputStream = Main.class.getResourceAsStream("/config.properties")) {
            properties.load(inputStream);
        } catch (IOException e) {
            e.printStackTrace();
            return;
        }

        // Recupera le informazioni di configurazione
        String username = properties.getProperty("db.username");
        String password = properties.getProperty("db.password");

        // Utilizza le informazioni di configurazione come necessario
        System.out.println("Username: " + username);
        System.out.println("Password: " + password);
    }
}