import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import java.io.File;

public class Main {
    private static String resolveDriverPath() {
        boolean isWin = System.getProperty("os.name").toLowerCase().contains("win");
        String binName = isWin ? "chromedriver.exe" : "chromedriver";
        File[] candidates = new File[] {
            new File("../tools/bin/" + binName),
            new File("tools/bin/" + binName),
            new File("../tools/bin/chromedriver"),
            new File("tools/bin/chromedriver")
        };
        for (File f : candidates) {
            if (f.exists()) {
                return f.getAbsolutePath();
            }
        }
        return null;
    }

    public static void main(String[] args) {
        String driverPath = resolveDriverPath();
        if (driverPath != null) {
            System.setProperty("webdriver.chrome.driver", driverPath);
        }
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless=new", "--no-sandbox", "--disable-dev-shm-usage");
        WebDriver driver = new ChromeDriver(options);
        driver.get("https://www.google.com");
        System.out.println(driver.getTitle());
        driver.quit();
    }
}
