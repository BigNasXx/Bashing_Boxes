#!/bin/bash

# Structure of ANY script (or code)
# 1) Declaritive statment: declare interupter (in the case bash) is needed.
# 2) Import statments: Import or call any other librarys/files/functions from other sources
# 3) Variable declartions: decare all variables needed for code and even if they are empty. 
# 4) Define all functions: make all functions and define them as needed.
# 5) Main Logic: this is where we start calling our functions.

user_input=""

get_user_input(){
	read -p "Enter menu selection: " user_input
}

display_main_menu(){
	echo -e "
	1) option one
	2) option two
	A) option A 
	B) Option B
	"
	get_user_input
}