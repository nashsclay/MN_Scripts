clear

echo "This script was forked from CryptoNeverSleeps"
echo

cd /usr/local/bin/
sudo apt-get install unzip
echo "Script may appear frozen for a few seconds. This is normal."
wget -c https://github.com/Electra-project/Electra-Bootstrap/releases/download/v1.0/ElectraBootstrap.zip
sudo mkdir fix_electra_bootstrap
sudo unzip -o ElectraBootstrap.zip -d fix_electra_bootstrap
cd fix_electra_bootstrap
sudo rm -R ~/.electra/blocks/
sudo rm -R ~/.electra/chainstate/
sudo rm -R ~/.electra/database/
sudo rm -R ~/.electra/blocks/
sudo rm -R ~/.electra/sporks/
sudo rm -R ~/.electra/zerocoin/
sudo rm ~/.electra/budget.dat ~/.electra/db.log ~/.electra/debug.log ~/.electra/fee_estimates.dat ~/.electra/mncache.dat ~/.electra/mnpayments.dat ~/.electra/peers.dat ~/.electra/.lock
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
