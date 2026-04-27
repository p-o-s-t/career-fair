# Attacker Scenario 2: Answers

## Challenge Questions

**1. What is the main difference between a "Bind Shell" and a "Reverse Shell"?**
- **Bind Shell:** The target machine opens a communication port and waits for the attacker to connect to it. (e.g., Target listens on 4444, Attacker connects).
- **Reverse Shell:** The attacker opens a communication port (a listener) and the target machine initiates a connection back to the attacker's machine.

**2. Why might a Bind Shell fail if there is a firewall on the target machine?**
Most firewalls are configured with strict "Ingress" (incoming) rules. If a firewall is present, it will likely block any attempt to connect to a new, unauthorized port (like 4444) on the target machine, even if the service is running.

**3. Which type of shell is generally harder for a network administrator to detect?**
A **Reverse Shell** is generally harder to detect. Many organizations focus heavily on blocking incoming traffic but have much more permissive rules for outgoing traffic (Egress). A reverse shell "blends in" with normal outgoing traffic (like a web browser or a software update) making it less suspicious than an unexpected incoming connection to a high-numbered port.
