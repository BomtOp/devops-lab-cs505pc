import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.Result;
import org.junit.runner.notification.Failure;
import java.io.File;

public class Main {
    private WebDriver driver;

    @Before
    public void setUp() {
        String driverPath = new File("../tools/bin/chromedriver").exists()
            ? new File("../tools/bin/chromedriver").getAbsolutePath()
            : new File("tools/bin/chromedriver").getAbsolutePath();
        System.setProperty("webdriver.chrome.driver", driverPath);
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless=new", "--no-sandbox", "--disable-dev-shm-usage");
        driver = new ChromeDriver(options);
    }

    @Test
    public void testIncrementButton() throws Exception {
        File htmlFile = new File("program.html").exists()
            ? new File("program.html")
            : new File("exp11/program.html");
        String htmlContent = java.nio.file.Files.readString(htmlFile.toPath());
        String dataUrl = "data:text/html;charset=utf-8," + java.net.URLEncoder.encode(htmlContent, "UTF-8").replace("+", "%20");
        driver.get(dataUrl);
        driver.findElement(By.id("increment-button")).click();
        String result = driver.findElement(By.id("output")).getText();
        assert result.equals("1") : "Expected '1' but got '" + result + "'";
    }

    @After
    public void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }

    public static void main(String[] args) {
        long start = System.currentTimeMillis();
        Result result = JUnitCore.runClasses(Main.class);
        double elapsed = (System.currentTimeMillis() - start) / 1000.0;
        System.out.println(".");
        System.out.printf("Time: %.3f%n", elapsed);
        if (result.wasSuccessful()) {
            System.out.println("OK (" + result.getRunCount() + " test)");
        } else {
            for (Failure failure : result.getFailures()) {
                System.out.println(failure.toString());
            }
            System.exit(1);
        }
    }
}
