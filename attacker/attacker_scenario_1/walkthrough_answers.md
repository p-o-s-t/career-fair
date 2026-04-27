# Attacker Scenario 1: Answers

## Challenge Questions

**1. Why does Metasploitable show so many open ports compared to a modern, hardened server?**
Metasploitable is intentionally designed to be "vulnerable by default." It has many legacy services enabled (like Telnet, FTP, RSH, and outdated versions of Apache/MySQL) to provide security students with multiple vectors for practice. A modern server follows the "Principle of Least Privilege" and "Attack Surface Reduction," typically only exposing the absolute minimum number of services required for its function.

**2. What was the exact command being executed on the server when you entered `127.0.0.1; ls /`?**
The command executed was `ping -c 4 127.0.0.1; ls /`. The `;` acts as a command separator in Unix-like shells, allowing multiple commands to run sequentially.

**3. Why did the semicolon allow you to execute a second command?**
In Bash and other shells, the semicolon (`;`) is a control operator that separates commands. The shell executes the first command, waits for it to finish, and then executes the second command. In this case, the `ping` command ran first, followed by the `ls /` command.

**4. How could the developer have prevented this vulnerability?**
- **Input Validation:** Use a regular expression to ensure the input is a valid IP address and contains no special characters like `;`, `&`, `|`, etc.
- **Avoid Shell Execution:** Instead of `shell_exec`, use built-in language functions or libraries that don't involve a shell (e.g., a PHP socket-based ping library).
- **Escaping:** Use functions like `escapeshellarg()` in PHP to sanitize the input before passing it to a shell command.
- **Principle of Least Privilege:** Run the web server and the application as a non-privileged user to limit the impact of a successful exploit.
