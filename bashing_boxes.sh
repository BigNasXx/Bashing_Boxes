#!/bin/bash
clear
Objects=("Staircase" "Sail Boat" "Microscope"  "Marshmallows" "Lemonade" "Cauliflower" "Honey" "Walkman" "Milkshake" "Orange tree")

datafolder="/home/bignasx/Bashing_Boxes/data" 
array_storage="/home/bignasx/Bashing_Boxes/data/array_storage" 
maxnum="30"

# ===============================================
# Prints the main menu options for the user
# ===============================================
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
 ||	10) Generate Random Box
 ||	11) Quit
	"
}

# ===============================================
# Prompts user for input and stores it in user_input
# ===============================================
get_user_input(){
	read -p "Enter menu selection: " user_input
}

# ===============================================
# Prints a specific item in the array based on user index
# ===============================================
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

# ===============================================
# Removes an object from the array at a given index
# ===============================================


# ===============================================
# Prints all items currently in the Objects array
# ===============================================
print_list()
{
	for item in "${!Objects[@]}";  do
 		echo "$item) ${Objects[$item]}"
	done
	menu_selection
}

# ===============================================
# Removes the last element in the Objects array
# ===============================================
remove_last_index()
{
	echo ${Objects[-1]} deleted
	unset 'Objects[-1]'
	Objects=("${Objects[@]}")
	menu_selection
}

# ===============================================
# Adds a new item entered by user to the array
# ===============================================
add_an_item_to_array()
{
	echo What item would you want to add
	get_user_input
	Objects+=("$itemAdded")
	echo New Item Added
	menu_selection
}

# ===============================================
# Displays menu and handles the user's choice
# ===============================================
menu_selection(){
   print_menu
	
	get_user_input
	
	case $user_input in 
 1) print_list ;;
 2) print_an_index_in_ccurrent_array ;;
 3) add_an_item_to_array ;;
 4) remove_last_index ;;
 5) remove_item_at_x_index ;;
 6) save_current_array ;;
 7) load_a_saved_array ;;
 8) list_saved_arrays ;;
 9) delete_a_saved_array ;;
 10) generate_random_box ;;
 11) quit;;
    *) echo "Please Enter a Valid Number"
	menu_selection ;;
 esac
}

# ===============================================
# Saves current array to a text file in array_storage
# ===============================================
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

# ===============================================
# Saves array and exits the program
# ===============================================
save_and_leave()
{
	echo What is the name of the file you want to save
	get_user_input
    file="$array_storage/$user_input.txt"
    printf "%s\n" "${Objects[@]}" > "$file"
	echo $user_input created
	ls "$array_storage" 
}

# ===============================================
# Lists all saved array files in array_storage
# ===============================================
list_saved_arrays()
{
	ls "$array_storage"
	menu_selection
}

# ===============================================
# Asks user if they want to save before quitting
# ===============================================
quit()
{
	echo Do you want to save before you quit
	get_user_input
	case $user_input in
	  y) save_and_leave ;;
	  yes) save_and_leave ;;
	  no) clear; exit 0 ;;
	  n) clear; exit 0 ;;
	  *) echo Input Only accepts y/n/yes/no
	  quit ;;
	esac
}

# ===============================================
# Deletes a chosen array file from storage
# ===============================================
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

# ===============================================
# Loads a saved array file into Objects
# ===============================================
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

# ===============================================
# Prompts the user for how many random objects to generate
# ===============================================
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

# ===============================================
# Randomly selects lines from the warehouse file
# ===============================================
load_object_pool()
{
	shuf -n $box_size "$datafolder/warehouse_of_objects.txt" > "$datafolder/random_file.txt"
}

# ===============================================
# Generates a random object box and displays it
# ===============================================
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
remove_item_at_x_index()
{
	echo what Item do you want to remove
	get_user_input
	if [[ $user_input =~ [0-9]+$ && $user_input -le ${#Objects[@]} && $user_input -ge 0 ]]; then
		echo  "${Objects[$user_input]} deleted"
		unset 'Objects[$user_input]'
		Objects=("${Objects[@]}")
		echo "Showing List
		=====================
		"
		for item in "${!Objects[@]}";  do
 		echo "$item) ${Objects[$item]}"
	done
    else
	{
		echo Input Valid index
		remove_item_at_x_index
	}
	fi
	menu_selection
}

# ===============================================
# Entry point: Starts the program by showing the menu
# ===============================================
menu_selection
