#!/bin/bash
echo "**************************************************"
echo " Setting up TDD/BDD Final Project Environment"
echo "**************************************************"

echo "*** Installing Python 3.9 and Virtual Environment"
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y python3.9 python3.9-venv

echo "*** Making Python 3.9 the default..."
sudo update-alternatives --remove-all python3
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1

echo "*** Checking the Python version..."
python3 --version

echo "*** Creating a Python virtual environment"
python3 -m venv ~/venv

echo "*** Configuring the developer environment..."
echo "# TDD/BDD Final Project additions" >> ~/.bashrc
echo "export GITHUB_ACCOUNT=$GITHUB_ACCOUNT" >> ~/.bashrc
echo 'export PS1="\[\e]0;\u:\W\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ "' >> ~/.bashrc
echo "source ~/venv/bin/activate" >> ~/.bashrc

echo "*** Installing Selenium and Chrome for BDD"
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y sqlite3 ca-certificates chromium-driver python3-selenium

echo "*** Installing Python depenencies..."
source ~/venv/bin/activate && python3 -m pip install --upgrade pip wheel
source ~/venv/bin/activate && pip install -r requirements.txt

echo "*** Establishing .env file"
cp dot-env-example .env

echo "*** Starting the Postgres Docker container..."
make db

echo "*** Checking the Postgres Docker container..."
docker ps

echo "**************************************************"
echo " TDD/BDD Final Project Environment Setup Complete"
echo "**************************************************"
echo ""
echo "Use 'exit' to close this terminal and open a new one to initialize the environment"
echo ""
