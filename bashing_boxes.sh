#!/bin/bash
clear
Objects=("Staircase" "Sail Boat" "Microscope"  "Marshmallows" "Lemonade" "Cauliflower" "Honey" "Walkman" "Milkshake" "Orange tree")

datafolder="/home/bignasx/Bashing_Boxes/data" 
array_storage="/home/bignasx/Bashing_Boxes/data/array_storage" 
maxnum="30"




# prints the menu
print_menu()
{
	echo "
	Welcome User 
	
	Choose an Index from 1-6	
	==========================
 ||     1) Print List
 ||	 2) Print Object at Index 
 ||	 3) Add item
 ||	 4) Remove last item	
 ||	 5) Remove item at Index
 ||	 6) Save Current Array
 ||	 7) Load an array
 ||	 8) List saved arrays
 ||	 9) Delete an array
 ||	10) Quit
	"
}

# Gets user input and stores it in user_input
get_user_input(){
	read -p "Enter menu selection: " user_input
}

# Prints a specific index from the current array
print_an_index_in_ccurrent_array()
{
	echo " What index do you want to print"
	get_user_input
	
	if [[ $user_input =~ [0-9]+$  && $user_input -ge 0 && $user_input -le ${#Objects[@]}-1 ]]; then	
		echo ${Objects[$user_input]}
		
	else {
			echo Input a Valid Input
			print_an_index_in_ccurrent_array
		}
	fi
	menu_selection

}

# Removes an item from the array at a specific index
remove_item_at_x_index()
{
	echo what Item do you want to remove
	get_user_input
	if [[ $user_input =~ [0-9]+$ && $user_input -le ${#Objects[@]} && $user_input -ge 0 ]]; then
		echo  "${Objects[$user]} deleted"
		unset 'Objects[$user_input]'
		Objects=("${Objects[@]}")
		echo "Showing List
		=====================
		"
		echo "${Objects[@]}"
    else
	{
		echo Input Valid index
		remove_item_at_x_index
	}
	fi
	menu_selection
}

# Prints all items in the array
print_list()
{
	for item in "${!Objects[@]}";  do
 		echo "$item) ${Objects[$item]}"
	done
	menu_selection
}

# Removes the last item in the array
remove_last_index()
{
	echo ${Objects[-1]} deleted
	unset 'Objects[-1]'
	Objects=("${Objects[@]}")
	menu_selection
}

# Adds a new item to the array
add_an_item_to_array()
{
	echo What item would you want to add
	get_user_input
	Objects+=("$itemAdded")
	echo New Item Added
	menu_selection
}

# Displays the main menu and handles user choices
menu_selection(){
   print_menu
	
	get_user_input
	
	case $user_input in 
 1) 
 	print_list 
 	;;
 2) 
	print_an_index_in_ccurrent_array
 	;;
 3) add_an_item_to_array
 	;;
 4) remove_last_index
 	;;
 5) remove_item_at_x_index
 	;;
 6) save_current_array
    ;;
 7) load_a_saved_array
    ;;
 8) list_saved_arrays
 	;;
 9) delete_a_saved_array
    ;;
 10)generate_random_box
    ;;
    
 11) quit
    break
 	;;
    *) echo "Please Enter a Valid Number"
	menu_selection
	;;
	
 esac
}

# Saves the current array to a text file
save_current_array()
{
	echo What is the name of the file you want to save
	get_user_input
    file="$array_storage/$user_input.txt"
    printf "%s\n" "${Objects[@]}" > "$file"
	echo $user_input created
	ls "$array_storage" 
	menu_selection
}

# Saves the array and exits the program
save_and_leave()
{
	echo What is the name of the file you want to save
	get_user_input
    file="$array_storage/$user_input.txt"
    printf "%s\n" "${Objects[@]}" > "$file"
	echo $user_input created
	ls "$array_storage" 
}

# Lists all saved arrays in the data folder
list_saved_arrays()
{
	ls "$array_storage"
	menu_selection
}

# Asks user to save before quitting
quit()
{
	echo Do you want to save before you quit
	get_user_input
	case $user_input in
	  y) 
	   save_and_leave
	  ;;
	  yes) save_and_leave
	  ;;
	  no) clear
	   exit 0
	  ;;
	  n) clear
	   exit 0
	  ;;
	  *) echo Input Only accepts y/n/yes/no
	  quit
	esac
}

# Deletes a saved array from the data folder
delete_a_saved_array()
{
	echo Type name of file you want to delete, type exit to leave
	get_user_input
	if [[ $user_input == "exit" ]]; then
		menu_selection
	fi
	
	if [ -f "$array_storage/$user_input.txt" ]; then
		rm -r $array_storage/"$user_input".txt
		echo $user_input.txt deleted
	else
		echo "file doesnt exist(type exit to leave)"
	fi
	menu_selection
}

# Loads a saved array from file
load_a_saved_array()
{ 
	echo " Input  name of text , type exit to leave"
	get_user_input

	if [[ $user_input == "exit" ]]; then
		menu_selection
	fi

	if [ -f "$array_storage/$user_input.txt" ]; then
		mapfile -t loaded_array < "$array_storage/$user_input.txt"
		Objects=("${loaded_array[@]}")

		for item in "${!Objects[@]}";  do
			echo "$item) ${Objects[$item]}"
		done
		menu_selection
	else
		echo That file $user_input doesnt exist
		load_a_saved_array
	fi
}
get_prompt_size()
{ 
	read -p "Enter a Number between 1-30 for the array: " box_size
	if [[ $box_size -ge 0 &&  $box_size -le $maxnum && $box_size =~ [0-9]+$ ]]; then
		return 0
		
	else
	 echo Invalid Input
	 generate_random_box
	fi

}
load_object_pool()
{
	shuf -n $box_size "$datafolder/warehouse_of_objects.txt" > "$datafolder/random_file.txt"
}


generate_random_box()
{

 get_prompt_size
 load_object_pool

	
 mapfile -t loaded_array < "$datafolder/random_file.txt"
 Objects=("${loaded_array[@]}")
 for item in "${!Objects[@]}";  do
 		echo "$item) ${Objects[$item]}"
 done
 menu_selection
}

# Starts the program by showing the menu
menu_selection
