public class HelloWorld {
    public static int add(int a, int b) {
        return a + b;
    }

    public static void main(String[] args) {
        System.out.println("Hello World from Experiment 5 CI/CD Java Application!");
        int sum = add(15, 25);
        System.out.println("Calculation check: 15 + 25 = " + sum);
        if (sum != 40) {
            throw new RuntimeException("Test failed: expected 40 but got " + sum);
        }
        System.out.println("All unit tests passed successfully!");
    }
}
