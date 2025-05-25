 #! usr/bin/bash
   
#first we'll have to specify the folder in which we will store our screenshots
#you may change this to whatever folder you want
output_dir="$HOME/Pictures/screenshots"
mkdir -p "$output_dir"

# this allows the user to select a window and fetches its id
# take note that PID will work badly in this case so using window id is the best shot
echo "Click on a window to select it..."
win_id=$(xwininfo | grep 'Window id:' | awk '{print $4}')
echo "Selected window ID: $win_id"

interval=$1 #the dalay btw each screenshot(user input)

#let's initialize the tmp file where we will store the number of screenshots
count_file="/tmp/screenshot_count"

#this is to clear it if it was used before
: > "$count_file"

#we opted for a functions because it's easier to manage(start, loop, kill) 
take_screenshots() {
   #bash is limited when it comes fo variable scope, what goes inside a function stays inside
   #even if we were to define it globally it would not save its incrementation
   #therefore we write it out to a file and read the output later
    local counter=0
    while true; do
        ((counter++))
        timestamp=$(date +"%Y-%m-%d_%H-%M-%S") #to differentiate screenshots
        filename="$output_dir/screenshot_$timestamp.png"
        import -window "$win_id" "$filename"   #call to imagemagick   
        echo "$counter" > "$count_file"  #saving the number of screenshots to the tmp file
        sleep "$interval"
    done
}


#this part is very important as it runs the take_screenshots fct in the background 
#and stores its PID(very useful later) using the $! command(it stores the last ran process's PID')
take_screenshots   &
screenshot_pid=$!

while true; do
    read -p "Do you want to stop? (yes/no): " answer #prompt the user and read his response
    if [[ "$answer" == "yes" ]]; then
        echo "Stopping screenshots..."
        kill "$screenshot_pid" #it's easy to kill process knowing it's PID'
        wait "$screenshot_pid" 2>/dev/null
           # Read final count from temp file
        if [[ -f "$count_file" ]]; then
            final_count=$(cat "$count_file")
            echo "Total screenshots taken: $final_count"
        else
            echo "No screenshots taken."
        fi


        break
    fi
done
