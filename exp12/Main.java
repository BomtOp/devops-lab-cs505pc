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
    private String baseUrl = System.getProperty("app.url", "http://localhost:8080");

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
    public void testHomePageLoads() {
        driver.get(baseUrl);
        String title = driver.getTitle();
        assert title.equals("My Containerized Application") : "Unexpected title: " + title;
    }

    @Test
    public void testSubmitForm() {
        driver.get(baseUrl);
        driver.findElement(By.name("name")).sendKeys("John Doe");
        driver.findElement(By.name("email")).sendKeys("john.doe@example.com");
        driver.findElement(By.name("submit")).click();
        String result = driver.findElement(By.id("result")).getText();
        assert result.equals("Form submitted successfully!") : "Unexpected result: " + result;
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
        System.out.println("..");
        System.out.printf("Time: %.3f%n%n", elapsed);
        if (result.wasSuccessful()) {
            System.out.println("OK (" + result.getRunCount() + " tests)");
        } else {
            for (Failure failure : result.getFailures()) {
                System.out.println(failure.toString());
            }
            System.exit(1);
        }
    }
}
