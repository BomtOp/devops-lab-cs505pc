# DevOps Lab (CS505PC) — All 12 Experiments (Windows Ready)

This repository contains all 12 experiments from the **St. Martin's Engineering College — DevOps Lab Manual (CS505PC)**, configured to run natively on **Windows** (Command Prompt / PowerShell) as well as Linux/macOS.

---

## Quick Start on Windows

1. **Clone the repository:**
   ```cmd
   git clone https://github.com/BomtOp/devops-lab-cs505pc.git
   cd devops-lab-cs505pc
   ```

2. **Download all required tools & dependencies automatically (OpenJDK 21, Flask, Selenium, JUnit 4, ChromeDriver, Jenkins LTS, kubectl):**
   ```cmd
   tools\download_tools.bat
   ```

3. **Run all 12 experiments and verify ideal outputs:**
   ```cmd
   run_all_experiments.bat
   ```

---

## Running Individual Experiments on Windows

| Experiment | Directory | Windows Command | Key Files |
| :--- | :--- | :--- | :--- |
| **Exp 1** | `exp1\` | `exp1\run_exp1.bat` | `Dockerfile`, `requirements.txt`, `app.py`, `templates\register.html`, `templates\success.html`, `templates\index.html` |
| **Exp 2** | `exp2\` | `exp2\run_exp2.bat` | `run_exp2.bat` (executes `git init`, `status`, `add`, `commit`, `log`, `checkout`, `branch`, `merge`, `push`, `clone`) |
| **Exp 3** | `exp3\` | `exp3\run_exp3.bat` | `run_exp3.bat` (clones repo, adds Exercise 1 code, commits & pushes to `origin master`) |
| **Exp 4** | `exp4\` | `exp4\run_exp4.bat` | `run_exp4.bat` (starts Jenkins on port `8090` and verifies login page) |
| **Exp 5** | `exp5\` | `exp5\run_exp5.bat` | `HelloWorld.java`, `run_exp5.bat`, `prod_deploy\HelloWorld.jar` |
| **Exp 6** | `exp6\` | `exp6\run_exp6.bat` | `run_exp6.bat` (`docker pull`, `images`, `run`, `ps`, `stop`, `start`, `push`, `rm`) |
| **Exp 7** | `exp7\` | `exp7\run_exp7.bat` | `hello.py`, `Dockerfile`, `run_exp7.bat` |
| **Exp 8** | `exp8\` | `exp8\run_exp8.bat` | `deployment.yaml`, `service.yaml`, `run_exp8.bat` |
| **Exp 9** | `exp9\` | `exp9\run_exp9.bat` | `deployment.yaml`, `service.yaml`, `run_exp9.bat` |
| **Exp 10** | `exp10\` | `exp10\run_exp10.bat` | `Main.java`, `run_exp10.bat` (opens `https://www.google.com` via ChromeDriver and prints `Google`) |
| **Exp 11** | `exp11\` | `exp11\run_exp11.bat` | `program.html`, `Main.java`, `run_exp11.bat` (JUnit + Selenium test for JavaScript counter) |
| **Exp 12** | `exp12\` | `exp12\run_exp12.bat` | `Main.java`, `run_exp12.bat` (JUnit + Selenium test suite for containerized Flask app) |

### Manual Java Compilation & Execution on Windows (Experiments 10, 11, 12)
Remember that Windows uses `;` as the classpath separator:
```cmd
javac -cp ".;..\tools\selenium\selenium-server.jar;..\tools\selenium\junit-4.13.2.jar;..\tools\selenium\hamcrest-core-1.3.jar" Main.java
java -ea -cp ".;..\tools\selenium\selenium-server.jar;..\tools\selenium\junit-4.13.2.jar;..\tools\selenium\hamcrest-core-1.3.jar" Main
```
