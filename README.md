# Career Fair Interactive Scenarios 
## Purpose
Interactive exhibits to use at a career fair to demonstrate some of the various actions that security professionals can be expected to perform. Meant to be a supplement to any organizational recruiting efforts at conferences, training events, academic events, etc. Not meant to be deep, just a dip into the waters

## Requirements
The following utilities will be needed for the scenarios:
- Metasploit Framework
- Nmap
- Docker
- Git 

## Setup
1. Clone and move into this repo to the device(s) you plan to use for the career fair

```sh 
git clone https://github.com/p-o-s-t/career-fair
cd career_fair
```

2. Download and extract the Boss of the SOC version 3 dataset.

```sh
wget https://botsdataset.s3.amazonaws.com/botsv3/botsv3_data_set.tgz
tar -xzf botsv3_data_set.tgz -C ./host_dfir/host_scenario_2/
```

## Running Scenarios 
1. Participants can select which scenario they want to try out by changing into that directory. There are 2 scenarios for each category: attacker, host_dfir, and network_dfir.

2. Once in the scenario directory, run the scenario script with `./scenario_*.sh start`.

3. Participants will follow the walkthrough guide in each respective scenario.

4. When the participant(s) are done, they can reset the scenario easily with `./scenario_*.sh reset` to let the next person try out the scenario.

## Acknowledgements
These scenarios would not have been possible without the files provided by
- malware-traffic-analysis.net
- Splunk
- Unit42
