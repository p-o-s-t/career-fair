#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}==================================================${NC}"
echo -e "${BLUE}        Career Fair Scenario Setup Script         ${NC}"
echo -e "${BLUE}==================================================${NC}"

check_command() {
  if ! command -v "$1" &>/dev/null; then
    echo -e "${RED}[ERROR] Required tool '$1' is not installed.${NC}"
    return 1
  fi
  return 0
}

# Check prereqs
echo -e "\n${YELLOW}[*] Checking prerequisites...${NC}"
MISSING_PREREQS=0

check_command "wget" || MISSING_PREREQS=1
check_command "unzip" || MISSING_PREREQS=1
check_command "tar" || MISSING_PREREQS=1
check_command "yara" || MISSING_PREREQS=1
check_command "nmap" || MISSING_PREREQS=1

# Check docker
if ! command -v docker &>/dev/null; then
  echo -e "${RED}[ERROR] Docker is not installed.${NC}"
  MISSING_PREREQS=1
else
  # Check if docker compose subcommand works
  if ! docker compose version &>/dev/null; then
    echo -e "${RED}[ERROR] 'docker compose' subcommand is not available.${NC}"
    MISSING_PREREQS=1
  fi
fi

if [ $MISSING_PREREQS -eq 1 ]; then
  echo -e "\n${RED}[ERROR] Please install the missing prerequisites before running setup.${NC}"
  echo -e "On Ubuntu/Debian, you can install them using:"
  echo -e "  sudo apt-get update"
  echo -e "  sudo apt-get install -y wget unzip tar yara nmap docker.io docker-compose-plugin"
  exit 1
fi

echo -e "${GREEN}[+] All prerequisites are met!${NC}"

# Get the script directory to ensure absolute path references
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
cd "$SCRIPT_DIR"

# Step 1: Boss of the SOC (BOTSv3) Dataset
echo -e "\n${YELLOW}[*] Step 1: Setting up Boss of the SOC version 3 dataset...${NC}"
BOTS_DIR="./host_dfir_2/botsv3_data_set"
if [ -d "$BOTS_DIR" ]; then
  echo -e "${GREEN}[+] $BOTS_DIR already exists. Skipping download.${NC}"
else
  echo -e "Downloading BOTSv3 dataset (this may take a few minutes)..."
  if wget -O botsv3_data_set.tgz https://botsdataset.s3.amazonaws.com/botsv3/botsv3_data_set.tgz; then
    echo -e "Extracting BOTSv3 dataset to ./host_dfir_2/..."
    mkdir -p ./host_dfir_2
    tar -xzf botsv3_data_set.tgz -C ./host_dfir_2/
    rm botsv3_data_set.tgz
    echo -e "${GREEN}[+] BOTSv3 dataset setup successfully.${NC}"
  else
    echo -e "${RED}[ERROR] Failed to download BOTSv3 dataset.${NC}"
    rm -f botsv3_data_set.tgz
    exit 1
  fi
fi

# Step 2: CyberChef setup
echo -e "\n${YELLOW}[*] Step 2: Setting up CyberChef...${NC}"
CYBERCHEF_DIR="./host_dfir_1/cyberchef"
if [ -d "$CYBERCHEF_DIR" ]; then
  echo -e "${GREEN}[+] $CYBERCHEF_DIR already exists. Skipping download.${NC}"
else
  echo -e "Downloading CyberChef v11.0.0..."
  if wget -O CyberChef_v11.0.0.zip https://github.com/gchq/CyberChef/releases/download/v11.0.0/CyberChef_v11.0.0.zip; then
    echo -e "Extracting CyberChef to $CYBERCHEF_DIR..."
    mkdir -p "$CYBERCHEF_DIR"
    unzip -q CyberChef_v11.0.0.zip -d "$CYBERCHEF_DIR"
    rm CyberChef_v11.0.0.zip
    echo -e "${GREEN}[+] CyberChef setup successfully.${NC}"
  else
    echo -e "${RED}[ERROR] Failed to download CyberChef.${NC}"
    rm -f CyberChef_v11.0.0.zip
    exit 1
  fi
fi

# Step 3: PCAP for net_dfir_1
echo -e "\n${YELLOW}[*] Step 3: Setting up PCAP for Network Scenario 1...${NC}"
PCAP_FILE="./net_dfir_1/scenario_1.pcap"
if [ -f "$PCAP_FILE" ]; then
  echo -e "${GREEN}[+] $PCAP_FILE already exists. Skipping download.${NC}"
else
  echo -e "Downloading PCAP file..."
  if wget -O mta.zip https://malware-traffic-analysis.net/2026/03/12/2026-03-12-SmartApeSG-ClickFix-activity-for-Remcos-RAT.pcap.zip; then
    echo -e "Extracting and renaming PCAP..."
    mkdir -p ./net_dfir_1
    unzip -q -Pinfected_20260312 mta.zip -d ./net_dfir_1/
    mv ./net_dfir_1/2026-03-12-SmartApeSG-ClickFix-activity-for-Remcos-RAT.pcap "$PCAP_FILE"
    rm mta.zip
    echo -e "${GREEN}[+] Network Scenario 1 PCAP setup successfully.${NC}"
  else
    echo -e "${RED}[ERROR] Failed to download or decrypt PCAP.${NC}"
    rm -f mta.zip
    exit 1
  fi
fi

echo -e "\n${BLUE}==================================================${NC}"
echo -e "${GREEN}             Setup Completed Successfully!        ${NC}"
echo -e "${BLUE}==================================================${NC}"
echo -e "You can now run the interactive scenarios."
echo -e "1. Open your web browser and load the local ${YELLOW}index.html${NC} file."
echo -e "2. Navigate to the scenario directories (e.g., cd attacker_scenario_1) and run ${YELLOW}./scenario.sh start${NC}."
echo -e "=================================================="
