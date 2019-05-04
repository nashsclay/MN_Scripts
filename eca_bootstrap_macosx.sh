clear

echo "This script was forked from CryptoNeverSleeps"
echo

cd /usr/local/bin/
echo "Script may appear frozen for a few seconds. This is normal."
curl -k -O -L https://github.com/Electra-project/Electra-Bootstrap/releases/dow$
sudo mkdir fix_electra_bootstrap
sudo unzip -o ElectraBootstrap.zip -d fix_electra_bootstrap
cd fix_electra_bootstrap
sudo rm -R ~/Library/Application Support/.electra/blocks/
sudo rm -R ~/.electra/chainstate/
sudo rm -R ~/.electra/database/
sudo rm -R ~/.electra/blocks/
sudo rm -R ~/.electra/sporks/
sudo rm -R ~/.electra/zerocoin/
sudo rm ~/.electra/budget.dat ~/.electra/db.log ~/.electra/debug.log ~/.electra$
sudo mv chainstate blocks sporks zerocoin peers.dat ~/.electra
cd /usr/local/bin/
sudo rm -R fix_electra_bootstrap
sudo rm ElectraBootstrap.zip
cd ~
echo
echo
echo "Bootstrap applied. Any errors about files not existing is ok."
echo
echo
echo "Please start the wallet to ensure the bootstrap worked."
echo
