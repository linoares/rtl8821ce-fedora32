#!/bin/bash
# 
# Install Driver Network controller: Realtek Semiconductor Co., Ltd. RTL8821CE 802.11ac PCIe Wireless Network Adapter
# based on original project https://github.com/tomaspinho/rtl8821ce.git

if [[ $EUID -ne 0 ]]; then
  echo -e "\e[1;35m You must run this with superuser priviliges.  Try \"sudo ./dkms-install.sh\" \e[0m" 2>&1
  exit 1
else
  echo "About to run dkms install steps..."
fi


echo -e "\n\e[1;31m Check Driver \e[0m"
lspci|grep -i RTL8821CE > /dev/null
if [ $? -ne 0 ]; then
 echo -e "\e[1;32m PCIe Wireless Network Adapter is NOT Realtek Semiconductor \e[0m \e[1;31mRTL8821CE \e[0m"
 echo -e "\e[1;32m this project is not util for you \e[0m"
 echo -e "\n\n\e[1;32m END \e[0m\n"
 exit 
else
 echo -e "\e[1;32m PCIe Wireless Network Adapter found is Realtek Semiconductor \e[0m \e[1;31mRTL8821CE \e[0m"
fi

echo -e "\n\e[1;31m Check Operating System \e[0m"
hostnamectl|grep "Fedora 30\|Fedora 31\|Fedora 32" > /dev/null 
if [ $? -ne 0 ]; then
 OSCHCK=$(hostnamectl |grep -i "Operating System:")
 echo -e "\n\e[1;32m $OSCHCK \e[0m" 
 echo -e "\e[1;31m Operating System Not Apply \n Please Check the project \e https://github.com/tomaspinho/rtl8821ce.git \e[0m"
 echo -e "\n\n\e[1;32m END \e[0m\n"
 exit
else
 echo -e "\e[1;31m Operating System Apply \e[0m"
 PWD0=$(pwd)
 echo -e "\e[1;32m Update \e[0m"
 sudo dnf update -y
 echo -e "\n\n\e[1;31m Install prereqs \e[0m"
 sudo dnf install -y dkms make kernel-devel 
 cd rtl8821ce
 echo -e "\n\n\e[1;31m Install driver rtl8821ce\e[0m"
 sudo ./dkms-install.sh
 cd $PWD0
fi

echo -e "\n\n\e[1;32m END \e[0m\n"
