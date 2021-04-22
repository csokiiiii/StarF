
public class ScheduledLoadMain {

    public static void main(String[] args) throws InterruptedException {

        while (true) {
            System.out.println("Execution in Main Thread...." );
            Connection app = new Connection();
            app.connect();
            System.out.println("Sorok szama: " + app.getGameCount());
            app.insertGames(app.csvFilePath);
            app.getGames();
            Thread.sleep(20000);
        }
    }
}
