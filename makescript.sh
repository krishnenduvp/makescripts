function printline() {
cat >> $name.sh << EOF
#Just to print lines
function printline() {
echo -e "\n----------------------------------------\n"
}
EOF
}
function Help() {
cat >> $name.sh << EOF
#User guidance for executing the script
function help() {
echo -e "****************************************"
echo "Usage of $name.sh is: "
echo "For example: "
echo -e "****************************************"
}
EOF
}

function ArgumentCheck(){
cat >> $name.sh << EOF
#Checking Null Inputs
function argumentcheck() {
if [ -z "\$1" ]; then ac="invalid"
else
ac="valid"
fi
}
EOF
}

function filecheck(){
cat >> $name.sh << EOF
#This will check whether the first argument passed is a file or directory
function filecheck() {
PASSED=\$1

if [ -d "\${PASSED}" ] ; then
    echo "\$PASSED is a directory";
else
    if [ -f "\${PASSED}" ]; then
        echo "\${PASSED} is a file";
    else
        echo "\${PASSED} is not valid";
        exit 1
    fi
fi
}
EOF
}

function pingcheck(){
cat >> $name.sh << EOF
#This will check the whether the provided host is online or not
function pingcheck() {
ping -c 1 \$host &> /dev/null
if [ \$? -eq 0 ]; then
pc="online"
else
pc="offline"
fi
}

EOF
}


name=$(whiptail --inputbox "Enter the script name" 8 78  3>&1 1>&2 2>&3)
today=$(date +%d-%m-%Y)
touch $name.sh
chmod a+x $name.sh

cat /root/krish/format.txt | sed "s/date/${today}/g" >> $name.sh
abstract=$(whiptail --title "Formating Script" --inputbox "Enter your abstract of script" 10 60  3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
   sed -i "s/abstractofscript/${abstract}/g" $name.sh
fi

syntaxofscript=$(whiptail --title "Formating Script" --inputbox "Usage of script" 10 60  3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
   sed -i "s/syntaxofscript/${syntaxofscript}/g" $name.sh
fi

discriptionofscript=$(whiptail --title "Formating Script" --inputbox "Enter the discrition of your script" 10 60  3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
   sed -i "s/discriptionofscript/${discriptionofscript}/g" $name.sh
fi



#cat /root/krish/format.txt | sed "s/date/${today}/g" >> $name.sh
whiptail --title "Would you like to add some functions to your script" --checklist --separate-output "Choose:" 10 80 5 \
"Printline" "Add a printline function" on \
"Help" "User guidance for executing the script" off \
"FileCheck" "Check whether the input is file or directory" off \
"PingCheck" "Check host is online or not" off \
"ArgumentCheck" "Checks whether user has enterned any input argument" off 2>results
while read choice
do
        case $choice in
                Printline) printline
                ;;
                Help) Help
                ;;
                FileCheck) filecheck
                ;;
                PingCheck) pingcheck
                ;;
                ArgumentCheck) ArgumentCheck
                ;;
                *)
                ;;
        esac
done < results

whiptail --title "Script" --msgbox "Script $name.sh ready !!" 8 78
