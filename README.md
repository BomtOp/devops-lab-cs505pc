# DevOps Lab (CS505PC) — All 12 Experiments

This workspace contains all 12 experiments from the **St. Martin's Engineering College — DevOps Lab Manual (CS505PC)**, along with all required tools and dependencies downloaded locally into `tools/`.

## Downloaded Tools & Dependencies (`tools/`)
- **OpenJDK 21 LTS (Temurin)**: `tools/jdk/jdk-21/Contents/Home/bin/java` & `javac`
- **Python 3 Virtual Environment**: `tools/venv/` (with `Flask`, `selenium`, `webdriver-manager`)
- **Jenkins LTS (`jenkins.war`)**: `tools/jenkins/jenkins.war`
- **Selenium Server 4.25.0 & JUnit 4.13.2**: `tools/selenium/selenium-server.jar`, `tools/selenium/junit-4.13.2.jar`, `tools/selenium/hamcrest-core-1.3.jar`
- **ChromeDriver 156 (macOS ARM64)**: `tools/bin/chromedriver`
- **Kubernetes CLI (`kubectl`) & Local Cluster/Docker Wrappers**: `tools/bin/kubectl-bin`, `tools/bin/kubectl`, `tools/bin/docker`

---

## Directory Structure & Experiments

| Experiment | Directory | Aim | Key Files |
| :--- | :--- | :--- | :--- |
| **Exp 1** | `exp1/` | Simple user registration form for an event using Flask & Docker | `Dockerfile`, `requirements.txt`, `app.py`, `templates/register.html`, `templates/success.html`, `templates/index.html` |
| **Exp 2** | `exp2/` | Explore Git and GitHub commands | `run_exp2.sh`, `repo_demo/`, `remote_origin.git/`, `cloned_repo/` |
| **Exp 3** | `exp3/` | Practice Source Code Management on GitHub with Exercise 1 code | `run_exp3.sh`, `exp1_scm_repo/`, `github_remote.git/` |
| **Exp 4** | `exp4/` | Jenkins installation and setup, explore the environment | `run_exp4.sh`, `jenkins_home/`, `jenkins.log` |
| **Exp 5** | `exp5/` | Demonstrate continuous integration and development (CI/CD) using Jenkins | `HelloWorld.java`, `run_exp5.sh`, `git_repo/`, `build/`, `prod_deploy/HelloWorld.jar` |
| **Exp 6** | `exp6/` | Explore Docker commands for content management | `run_exp6.sh` (`pull`, `images`, `run`, `ps`, `stop`, `start`, `push`, `rm`) |
| **Exp 7** | `exp7/` | Develop a simple containerized application using Docker | `hello.py`, `Dockerfile`, `run_exp7.sh` |
| **Exp 8** | `exp8/` | Integrate Kubernetes and Docker | `deployment.yaml`, `service.yaml`, `run_exp8.sh` |
| **Exp 9** | `exp9/` | Automate running containerized application from Exercise 7 using Kubernetes | `deployment.yaml`, `service.yaml`, `run_exp9.sh` |
| **Exp 10** | `exp10/` | Install and explore Selenium for automated testing | `Main.java` |
| **Exp 11** | `exp11/` | Write a simple program in JavaScript and perform testing using Selenium | `program.html`, `Main.java` |
| **Exp 12** | `exp12/` | Develop test cases for the containerized application using Selenium | `Main.java` |
