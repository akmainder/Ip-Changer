#!/data/data/com.termux/files/usr/bin/bash

# Colors for output
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

# GitHub repository URL
GITHUB_REPO="https://raw.githubusercontent.com/Anon4You/Ip-Changer/main/ip-changer.sh"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install dependencies
install_dependencies() {
    echo -e "${YELLOW}[*] Updating packages...${RESET}"
    apt update -y

    echo -e "${YELLOW}[*] Installing dependencies...${RESET}"
    apt install -y tor privoxy curl ncurses-utils netcat-openbsd

    if ! command_exists tor || ! command_exists privoxy || ! command_exists curl || ! command_exists nc; then
        echo -e "${RED}[!] Failed to install dependencies. Please check your internet connection.${RESET}"
        exit 1
    fi

    echo -e "${GREEN}[+] Dependencies installed successfully.${RESET}"
}

# Function to download and install ip-changer
install_ip_changer() {
    echo -e "${YELLOW}[*] Downloading ip-changer script...${RESET}"
    if curl -s -o ip-changer.sh "$GITHUB_REPO"; then
        echo -e "${GREEN}[+] Script downloaded successfully.${RESET}"
    else
        echo -e "${RED}[!] Failed to download the script. Please check the URL or your internet connection.${RESET}"
        exit 1
    fi

    echo -e "${YELLOW}[*] Moving script to $PREFIX/bin...${RESET}"
    mv ip-changer.sh "$PREFIX/bin/ip-changer"
    chmod +x "$PREFIX/bin/ip-changer"

    if command_exists ip-changer; then
        echo -e "${GREEN}[+] ip-changer installed successfully.${RESET}"
        echo -e "${BLUE}[*] You can now run 'ip-changer' from anywhere.${RESET}"
    else
        echo -e "${RED}[!] Installation failed. Please check permissions.${RESET}"
        exit 1
    fi
}

# Main function
main() {
    echo -e "${BLUE}[*] Starting ip-changer installation...${RESET}"
    install_dependencies
    install_ip_changer
    echo -e "${GREEN}[+] Installation complete!${RESET}"
}

# Run the script
main
