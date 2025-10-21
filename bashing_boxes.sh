Objects=("PopCorn" "Apple" "Banana" "Flower" )


addItem()
{
	read -p "Name of Item You want to add: " itemAdded
	Objects+=($itemAdded)
	echo New Item Added
}
printIndex()
{
	
	while true; do

	 read -p "What Index Do you want to Print read: " index


	
		if (($index>=${#Objects[@]} || $index < 0 )); then
			
			 echo Please Enter a Valid Index Number Within the Array
		else
		echo ${Objects[$index]}
		break
	fi


	done		
}
removeItem()
{
	while true; do
		read -p "What Item do you want to remove (Type Index):" index
	if (($index>=${#Objects[@]} || $index < 0 )); then
		
		 echo Please Enter a Valid Index Number Within the Array
	else
	 echo  "${Objects[$index]} deleted"
	  unset 'Objects[$index]'
	  Objects=("${Objects[@]}")
	 
	
	 echo "Showing List
     =====================
	 "
	 echo "${Objects[@]}"
	 break
	fi
done
}
printList()
{
	for item in "${!Objects[@]}";  do
 		echo "$item) ${Objects[$item]}"
	done
}
removeLast()
{
	echo ${Objects[-1]} deleted
	unset 'Objects[-1]'
	Objects=("${Objects[@]}")

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
	6) Quit
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
	 4) removeLast
	 	;;
	 5) removeItem
	 	;;
	 6) break 
	 	;;

	    *) echo "Please Enter a Valid Number";;
	 esac
done
