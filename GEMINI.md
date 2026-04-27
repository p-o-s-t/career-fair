## Purpose - Career Fair Planning and Set Up
This project is to help with putting together an playground environment on 3 separate Ubuntu laptops, along with guided walkthroughs, on how to perform tasks such as enumeration and exploitation against a intentionally vulnerable device, how to perform host-based digital forensic/incident response (DFIR), and how to perform network-based DFIR. The overall goal is to provide prospective candidates with an idea of what cybersecurity specialists do on a day to day basis without overwhelming them with highly technical concepts. This is a recruiting event to entice possible recruits to apply to join our company.

## Design
- **Environment:** 3 separate laptops running Ubuntu 24.04 LTS.
- **Architecture:** Container-centric (Docker or Podman). All scenario environments run as ephemeral containers.
- **Connectivity:** No internet access during the event. All container images must be pre-loaded and available locally.
- **Roles:**
  - **Attacker/Red Team:** Ephemeral containers hosting vulnerable services or attacker tools.
  - **Host DFIR:** Containers simulating a compromised host with pre-baked artifacts.
  - **Network DFIR:** Traffic analysis environments (PCAPs mapped to analysis containers).
- **Persistence:** By default, containers are non-persistent. A "Reset" simply restarts the container from its base image.

## Project Structure
```text
/
├── setup/              # Global configuration and orchestration scripts
├── network_dfir/       # Laptop 3 Scenarios
│   ├── network_scenario_1/
│   │   ├── docker-compose.yml
│   │   ├── scenario_1.pcap
│   │   └── walkthrough.md
│   └── network_scenario_2/
├── attacker/           # Laptop 1 Scenarios
│   ├── attacker_scenario_1/
│   └── attacker_scenario_2/
├── host_dfir/           # Laptop 2 Scenarios
│   ├── host_scenario_1/
│   └── host_scenario_2/
├── images/             # Tarballs of pre-built images for offline import
└── exercise_files/     # Source artifacts (zips, etc.)
```

## Objectives
1. **Container Development:** Create Dockerfiles and Compose configurations within each scenario directory.
2. **Offline Image Management:** Build and export all images to `images/` as `.tar` files.
3. **Orchestration:** Develop a central management script (e.g., `setup/manage_scenarios.sh`) that navigates to the specific scenario directory to launch/reset environments.
4. **Validation:** Ensure all container interactions (ports, volumes, tools) work flawlessly in an air-gapped state.

## Technical Requirements
- **Tools (Host):** Docker/Podman, Docker Compose.
- **Tools (Container):** `nmap`, `metasploit-framework`, `wireshark`, `sleuthkit`, etc.
- **Reset Strategy:** `docker compose down -v && docker compose up -d` executed within the scenario directory.



