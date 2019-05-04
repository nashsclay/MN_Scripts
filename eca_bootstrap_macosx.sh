clear

echo "This script was forked from CryptoNeverSleeps"
echo

cd /usr/local/bin/
echo "Script may appear frozen for a few seconds. This is normal."
curl -k -O -L https://github.com/Electra-project/Electra-Bootstrap/releases/download/v1.0/ElectraBootstrap.zip
sudo mkdir fix_electra_bootstrap
sudo unzip -o ElectraBootstrap.zip -d fix_electra_bootstrap
cd fix_electra_bootstrap
sudo rm -R "$HOME/Library/Application\ Support/Electra/blocks"
sudo rm -R "$HOME/Library/Application\ Support/Electra/chainstate"
sudo rm -R "$HOME/Library/Application\ Support/Electra/database"
sudo rm -R "$HOME/Library/Application\ Support/Electra/blocks"
sudo rm -R "$HOME/Library/Application\ Support/Electra/sporks"
sudo rm -R "$HOME/Library/Application\ Support/Electra/zerocoin"
sudo rm "~/Library/Application\ Support/Electra/budget.dat" "~/Library/Application\ Support/Electra/db.log" "~/Library/Application\ Support/Electra/debug.log" "~/Library/Application\ Support/Electra/fee_estimates.dat" "~/Library/Application\ Support/Electra/mncache.dat" "~/Library/Application\ Support/Electra/mnpayments.dat" "~/Library/Application\ Support/Electra/peers.dat" "~/Library/Application\ Support/Electra/.lock"
sudo mv chainstate blocks sporks zerocoin peers.dat "~/Library/Application\ Support/Electra"
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
