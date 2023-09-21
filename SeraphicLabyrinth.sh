#!/bin/bash

# SeraphicLabyrinth - Text-Based Labyrinth Game

# Define the labyrinth map
# You can customize the map according to your game's requirements
map=(
    "S X X X X X X X X X"
    "X X X X X X X X X X"
    "X X X X X X X X X X"
    "X X X X X X X X X X"
    "X X X X X X X X X X"
    "X X X X X X X X X X"
    "X X X X X X X X X X"
    "X X X X X X X X X X"
    "X X X X X X X X X X"
    "X X X X X X X X X E"
)

# Initialize the player's position
player_row=0
player_col=0

# Find the start ('S') and exit ('E') positions
for ((i = 0; i < ${#map[@]}; i++)); do
    row="${map[i]}"
    if [[ $row == *"S"* ]]; then
        player_row=$i
        player_col=$(expr index "$row" "S")-1
    fi
done

# Game loop
while true; do
    # Clear the screen
    clear

    # Display the labyrinth
    for ((i = 0; i < ${#map[@]}; i++)); do
        row="${map[i]}"
        for ((j = 0; j < ${#row}; j++)); do
            cell="${row:j:1}"
            if [ $i -eq $player_row ] && [ $j -eq $player_col ]; then
                echo -n "P "
            else
                echo -n "$cell "
            fi
        done
        echo
    done

    # Check if the player has reached the exit ('E')
    if [ "${map[$player_row]:$player_col:1}" == "E" ]; then
        echo "Congratulations! You've reached the exit."
        break
    fi

    # Read player input
    read -n 1 -s direction
    case $direction in
        "w") # Move up
            new_row=$((player_row - 1))
            if [ "${map[$new_row]:$player_col:1}" != "X" ]; then
                player_row=$new_row
            fi
            ;;
        "s") # Move down
            new_row=$((player_row + 1))
            if [ "${map[$new_row]:$player_col:1}" != "X" ]; then
                player_row=$new_row
            fi
            ;;
        "a") # Move left
            new_col=$((player_col - 2))
            if [ "${map[$player_row]:$new_col:1}" != "X" ]; then
                player_col=$new_col
            fi
            ;;
        "d") # Move right
            new_col=$((player_col + 2))
            if [ "${map[$player_row]:$new_col:1}" != "X" ]; then
                player_col=$new_col
            fi
            ;;
        "q") # Quit the game
            echo "Quitting the game."
            exit 0
            ;;
    esac
done

exit 0
