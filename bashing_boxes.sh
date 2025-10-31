Objects=("Staircase" "Sail Boat" "Microscope"  "Marshmallows" "Lemonade" "Cauliflower" "Honey" "Walkman" "Milkshake" "Orange tree" )
clear
datafolder="/home/bignasx/Bashing_Boxes/data" 


printIndex()
{
	
	while true; do

	 read -p "What Index Do you want to Print read: " index


	    if [[ $index =~ [0-9]+$ ]]; then
	    		if (($index>=${#Objects[@]} || $index < 0 )); then
	    			
	    			 echo Please Enter a Valid Index Number Within the Array
	    		else
	    		echo ${Objects[$index]}
	    		break
	    	fi
	    else
	    	{
	    		echo Input a Valid Input
	    	}
	    fi
		


	done		
}
removeItem()
{
	while true; do
		read -p "What Item do you want to remove (Type Index):" index

		if [[ $index =~ [0-9]+$ ]]; then
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
			else 
				{
					echo Enter a Valid Index
				}
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
addItem()
{
	read -p "Name of Item You want to add:" itemAdded
	Objects+=("$itemAdded")
	echo New Item Added
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
	6) Save Current Array
	7) Load an array
	8) List saved arrays'
	9) delete an array
	10) quit
	"
	read -p "Choice:" option
	
}


save_array()
{
	
	read -p "Name of File: "  name
    file="$datafolder/$name.txt"
    printf "%s\n" "${Objects[@]}" > "$file"
	echo $name created
	ls "$datafolder" 
}
list_saved_arrays()
{
	ls "$datafolder"
}

quit()
 {
	while true; do
	 read -p "Would you like to save before leaving (y/n)" input
	 if [[ $input == "y" || $input == "yes" ]]; then
	   	save_array
	   	exit 0
	 elif [[ $input == "n" || $input == "no" ]]; then
	
	 	exit 0
	 else
	  echo "Input only accepts yes/no/y/n"
	 fi
	done


   echo Bye
   
 }

delete_array()
{
	while true; do
	  if [[ $input == "exit" ]]; then
	  break
	 fi
		read -p "Which file do you want to delete" $input
		if [ -f "$datafolder/$input.txt" ]; then
			rm -r $datafolder/$input.txt
			echo $input.txt deleted
		else
		 echo "file doesnt exist(type exit to leave)"
		fi
	done


}
load_a_saved_array()
{
  while true; do
   read -p "What is the name of the File
   (type exit  to leave) : " name_of_array

    if [[ $name_of_array == "exit" ]]; then
	 break
	fi

	if [ -f "/home/bignasx/Bashing_Boxes/data/$name_of_array.txt" ]; then
		mapfile -t loaded_array < "/home/bignasx/Bashing_Boxes/data/$name_of_array.txt"
	 Objects=("${loaded_array[@]}")

	 for item in "${!Objects[@]}";  do
 		echo "$item) ${Objects[$item]}"
		
	 
	 done
	 break
	 
	else
	 echo That file $name_of_array doesnt exist
	fi

	
	  
 done
   
	
	
}
while true; do
	printMenu

	if [[ $option =~ [0-9]+$ ]]; then
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
	 6) save_array
	    ;;
	 7) load_a_saved_array
	    ;;
	 8) list_saved_arrays
	 	;;
	 9) delete_array
	    ;;
	    
	 10) quit
	    break
	 	;;

	    *) echo "Please Enter a Valid Number";;
	 esac
	else
		{
			echo Input a Valid Index
		}
	fi	 
done
