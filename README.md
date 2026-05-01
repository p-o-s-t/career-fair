# Career Fair Interactive Scenarios 
## Purpose
Interactive exhibits to use at a career fair to demonstrate some of the various actions that security professionals can be expected to perform. Meant to be a supplement to any organizational recruiting efforts at conferences, training events, academic events, etc. Not meant to be deep, just a dip into the waters

## Requirements
The following utilities will be needed for the scenarios:
- Nmap
- Docker
- Git

## Setup
1. Clone and move into this repo on the device(s) you plan to use for your career fair.

```bash
git clone https://github.com/p-o-s-t/career-fair
cd career_fair
```

2. Download and extract the Boss of the SOC version 3 dataset.

```bash
wget https://botsdataset.s3.amazonaws.com/botsv3/botsv3_data_set.tgz
tar -xzf botsv3_data_set.tgz -C ./host_dfir/host_scenario_2/
rm botsv3_data_set.tgz
```

3. Download and extract CyberChef to host_dfir_1 directory.

```bash
wget https://gchq.github.io/CyberChef/CyberChef_v11.0.0.zip
mkdir host_dfir_1/CyberChef
unzip CyberChef_v11.0.0.zip -d host_dfir_1/cyberchef
rm CyberChef_v11.0.0.zip
```

4. Download the PCAP for net_dfir_1.

```bash
wget https://malware-traffic-analysis.net/2026/03/12/2026-03-12-SmartApeSG-ClickFix-activity-for-Remcos-RAT.pcap.zip -O mta.zip
unzip -Pinfected_20260312 mta.zip -d net_dfir_1/
mv net_dfir_1/2026-03-12-SmartApeSG-ClickFix-activity-for-Remcos-RAT.pcap net_dfir_1/scenario_1.pcap 
rm mta.zip
```

## Running Scenarios 
1. Open a terminal, such as GNOME Terminal, and arrange it so it takes up half of the screen.

2. In the other half of the screen, use your preferred web browser to open `./index.html`. This local web page with links to all of the walkthroughs. Gives the participants the 'Choose Your Own Adventure' opportunity.

3. Participants can select which scenario they want to try out by changing into that directory. There are 2 scenarios for each category: Attacker, Host DFIR, and Network DFIR.  Each scenario has a hyperlink to a walkthrough rewritten in HTML.

4. Once in the scenario directory, the participants can start the scenario script with `./scenario.sh start`, which is highlighted in the walkthroughs.

5. Guide the participant(s) as necessary, but everything they need is in the walkthrough for each scenario.

6. When the participant(s) are done, they can reset the scenario easily with `./<scenario_directory>/scenario.sh reset` to let the next person try out the scenario without giving away the answers.

## Acknowledgements
These scenarios would not have been possible without the files provided by
- malware-traffic-analysis.net
- Splunk
- Unit42
