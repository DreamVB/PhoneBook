#!/bin/bash
# File : phonebook.sh
# By   : Ben a.k.a DreamVB
# Date : 22/06/2020
# Info : A simple example of a basic phone book.

#Path to the phone book database
db="phone.db"

#If no argument is not passed to the script display the help menu
if [ -z $1 ]; then
	#Clear screen
	clear
	#Display help menu
	echo "+-------------------------------+"
	echo "|      Phone Book Commands      |"
	echo "+-------------------------------+"
	echo "| -a to add a new phone record  |"
	echo "| -c to clear all records       |"
	echo "| -d to delete a phone record   |"
	echo "| -f to find a phone records    |"
	echo "| -v to view all phone records  |"
	echo "+-------------------------------+"
fi

# if this allows the user to add a new record
if [[ $1 == *"-a"* ]]; then
	clear
	echo -n "Enter Name: "
	#Read name
	read name
	echo -n "Enter Phone Number: "
	#Read phone number
	read phone
	#Write the $name and $phone to the database
	echo $name $phone >> $db
	echo "Address Added."
fi

# This allows the user to view all phone records in the database and display each record with a number.
if [[ $1 == *"-v"* ]]; then
	clear
	#Show each line in the database starting with a line number.
	nl --number-separator=":    " $db | less
fi

#This allows the user to find a phone record.
if [[ $1 == *"-f"* ]]; then
	clear
	echo -n "Enter a name or phone number: "
	read f
	#Find the string in the database and display the found records with the strings found.
	grep -i $f $db
fi

#This allows the user to delete a phone record.
if [[ $1 == *"-d"* ]]; then
	clear
    echo -n "Enter a record number to delete: "
    read n
	#Move database to a temp file
    mv $db temp.txt
	clear
	#This line delete the line from the database file and writes the results back to the database file.
	#It will also display remaining records that were not deleted.
    nl --number-separator=":" temp.txt | grep -v $n: | awk -F: '{print $2}' |  tee $db
fi
#This allows the user to clear all the records in the database.
if [[ $1 == *"-c"* ]]; then
	echo "Add phone records have been deleted."
	#Make empty file.
	echo > $db
fi
