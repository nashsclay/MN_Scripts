# Legion Coin
This Legion Coin Masternode (MN) script will automatically install almost all of the MN for you. You just need to have your masternode genkey ready. This code comes from Zoldurs many many forks for MN scripts, visit his page here. https://github.com/zoldur<br /><br />
Please note to run this script you MUST:
1) Be root - better to login as root then use the sudo command
2) Ubuntu 16.04 - I only tested this on that version but I'm sure others may work.
3) A VPS server - You can use my referal link here --> https://www.vultr.com/?ref=7415368
4) Digital Ocean is another provider you can use instead of Vultr. There are many more but these are very common to use. You can use any size due to the swap file that will be created if your server is below 2GB of memory.
5) Optional - There may be other types of servers you can use but not listed here.
legion_mn_setup_1.0.0_swap.sh<br />

Do note that this script does enable the MN to restart if it is somehow closed. It will only make it difficult to remove the MN if you decide to sell your MN. Best way is to delete all the MN files and to restart the MN. (for more information, please vist the coin's discord)

# To Install the Masternode
Please copy and paste the following commands into you connection with your server. Most common would be to use Putty.

wget https://raw.githubusercontent.com/nashsclay/MN_Scripts/master/legion_mn_setup_1.0.0_no_swap_nocomment.sh<br />
wget https://raw.githubusercontent.com/nashsclay/MN_Scripts/master/legion_mn_setup_1.0.0_no_swap.sh<br />
chmod +x legion_mn_setup_1.0.0_no_swap.sh<br />
./legion_mn_setup_1.0.0_no_swap.sh<br />

list commands here<br />
