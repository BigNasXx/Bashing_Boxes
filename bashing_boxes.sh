Objects=("PopCorn" "Apple" )

printList()
{
	for item in "${!Objects[@]}";  do
 		echo "$item) ${Objects[$item]}"
	done
}
addItem()
{
	read -p "Name of Item You want to add: " itemAdded
	Objects+=($itemAdded)
	echo New Item Added
}
printIndex()
{
	
	read -p "What Index Do you want to Print read: " index
	while (( $index > ${#Objects[@]} || $index < ${#Objects[@]})); do
	
		if (($index>${#Objects[@]} || $index<${#Objects[@]})); then
			
			 echo Please Enter a Valid Index Number

			else
				echo ${Objects[$index]}
			fi
  	done
}


printMenu(){
	echo "
	Welcome User 
	
	Choose an Index from 1-6	
	==========================
	1) Print List
	2) Print Object at Index 
	3) Add item
	4) Remove last item	
	5) Remove item at Index
	"
	read -p "Choice:" option
	
}

while true; do
	printMenu
	 case $option in 
	 	1) 
	 		printList 
	 	;;
	 2) printIndex
	 	;;
	 3) addItem

	 	;;
	    *) echo "Please Enter a Valid Number";;
	 esac
done
