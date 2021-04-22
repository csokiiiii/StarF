import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.*;

public class Connection {

    private final String url = "jdbc:postgresql://localhost:5432/games";
    private final String user = "StarF";
    private final String password = "StarF";

    String csvFilePath = "jatekToltes.csv";
    int batchSize = 20;


    public java.sql.Connection connect() {
        java.sql.Connection conn = null;
        try {
            conn = DriverManager.getConnection(url, user, password);
            conn.setAutoCommit(false);
            System.out.println("Connected to the PostgreSQL server successfully.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return conn;
    }

    public void getGames() {

        String SQL = "SELECT * FROM videoJatek";
        try (java.sql.Connection conn = this.connect();
             Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(SQL);

            while (rs.next()) {
                System.out.println(
                        rs.getInt("jatekId") +
                                rs.getString("nev") +
                                rs.getString("kategoria") +
                                rs.getString("fejleszto") +
                                rs.getString("kiado")
                );
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public int getGameCount() {
        String SQL = "SELECT count(*) FROM videoJatek";
        int count = 0;

        try (java.sql.Connection conn = connect();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(SQL)) {
            rs.next();
            count = rs.getInt(1);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return count;
    }

    public void insertGames(String csvFilePath) {

        String sql = "INSERT INTO videoJatek (jatekId, nev, kategoria, fejleszto, kiado)" +
                "VALUES (?, ?, ?, ?, ?)";

        try (java.sql.Connection conn = connect();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            BufferedReader lineReader = new BufferedReader(new FileReader(csvFilePath));
            String lineText = null;

            int count = 0;

            while ((lineText = lineReader.readLine()) != null) {
                count++;
                String[] data = lineText.split(";");
                String jatekId = data[0];
                String nev = data[1];
                String kategoria = data[2];
                String fejleszto = data[3];
                String kiado = data[4];

                Integer idInt = Integer.parseInt(jatekId);
                statement.setInt(1, idInt);
                statement.setString(2, nev);
                statement.setString(3, kategoria);
                statement.setString(4, fejleszto);
                statement.setString(5, kiado);

                statement.addBatch();

                if (count % batchSize == 0) {
                    statement.executeBatch();
                    count =0;
                }
            }

            lineReader.close();
            statement.executeBatch();

            conn.commit();

        } catch (FileNotFoundException ex) {
            System.out.println("FileNotFound történt");
            System.out.println(ex.getMessage());
        } catch (SQLException sqlex) {
            System.out.println("SQLEx történt");
            System.out.println(sqlex.getMessage());
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("IOException történt");
        }
    }

}
