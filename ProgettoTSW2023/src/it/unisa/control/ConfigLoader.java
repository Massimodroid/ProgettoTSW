package it.unisa.control;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigLoader {
    private static Properties properties;

    // Carica il file di configurazione una sola volta all'inizializzazione della classe
    static {
        properties = new Properties();
        try (InputStream inputStream = ConfigLoader.class.getResourceAsStream("/config.properties")) {
            properties.load(inputStream);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Metodo per ottenere l'username dal file di configurazione
    public static String getUsername() {
        return properties.getProperty("db.username");
    }

    // Metodo per ottenere la password dal file di configurazione
    public static String getPassword() {
        return properties.getProperty("db.password");
    }
}