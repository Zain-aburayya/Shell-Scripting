#!/bin/bash


# Methods for all option's and there proccess
analytics(){
	read -p "Enter your regex : " regex
	find $dir -type f -exec grep -o $regex {} + | uniq -c | awk '{ print "Occurance -> " $1 "\t\tpath -> " $2 }'
	echo -e "\e[1;32mAnalytics file\'s is done...\e[0m"
}

delete(){
	read -p "Enter the size(bytes) : " size
	find $dir -type f -size +$size"c" -delete
	echo -e "\e[1;32mDeleting file\'s is done...\e[0m"
}

arrange(){
	read -p "Enter file type : " type
	mkdir -p $dir/all_${type}_files
	find $dir -type f -name "*.$type" -exec mv -t $dir/all_${type}_files {} +
	echo -e "\e[1;32mArranged file\'s is done...\e[0m"
}



# Method to check if the directory is valid
isValidDirectory(){
	while true
	    do
		read -p "Enter file directory : " dir
		if [ -d $dir ]
			then
			break
		else
			echo -e "\e[1;31mInvalid directory , try again..\e[0m"
		fi
	    done
}


Date=`date +%D`;
echo -e "\n=================================\nWelcome back $LOGNAME.   $Date\n================================="

# what should he know 
echo -e "\nYou have three options to choose from in bash: \"ana\", \"del\", and \"arr\", each with its own unique set of commands for working with the files you have.\n"

echo -e "\"--> ana\" : is a shortcut command for counting the occurrences of a specific regex in all file\'s.\n"

echo -e "\n--> \"del\" : is a shortcut command for deleting files larger than a specific file size.\n"

echo -e "\n--> \"arr\" : is a shortcut command for arranging files of a specific type into a new directory.\n"


# take the option type from the user
read -p "Enter your option \"ana\" , \"del\" or \"arr\" : " option



# to choose one of the options "ana" , "del" , "arr"
if [[ $option =~ ^[aA][nN][Aa]$ ]] 
	then
	isValidDirectory
	analytics

elif [[ $option =~ ^[dD][eE][lL]$ ]] 
	then
	isValidDirectory
	delete

elif [[ $option =~ ^[aA][rR][rR]$ ]] 
	then
	isValidDirectory
	arrange

else
	echo -e "\e[1;31mYou enter an invalid option...\e[0m"
	exit 1
fi

