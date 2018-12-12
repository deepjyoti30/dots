#!/usr/bin/sh

# Define a path to store the image
path_to_img="/home/deepjyoti30/.i3/screen.png" # Add path of the wall that you want to make lockscreen

path_user_img="/home/deepjyoti30/.i3/dev_pic_small.jpg" # Add the users image to be put over the lockscreen wallpaper

final_img="/home/deepjyoti30/.i3/lockscreen.png"

# Function to crop the pic to a circle
# Definition of the function is found on stacoverflow 
# on this link: https://stackoverflow.com/questions/47112067/how-do-i-circle-select-and-crop-with-fu-script
crop_pic(){
    # Get x,y coordinates of centre
    img_path=$1
    # Convert the image to a square of 150 side
    convert -quality 100 -resize 150x150 $img_path $img_path

    cx=$(convert $img_path -format "%[fx:int(w/2)]" info:)
    cy=$(convert $img_path -format "%[fx:int(h/2)]" info:)
    # Find point on circle circumeference
    pt="0,$cy"
    [ $cx -gt $cy ] && pt="$cx,0"

    # Now create a black and white circle of the right size as transparency
    convert $img_path                                                                               \
        \( +clone -fill black -colorize 100% -fill white -draw "circle $cx,$cy $pt" -alpha off \) \
        -compose copyopacity -composite                                                           \
        -trim +repage ~/.i3/lock_icon.png
}

# Function to get start position of the text
grab_text_start(){
    pointsize=$1
    pointsize=$((pointsize/2))
    # Get the username
    uname=$(whoami)
    # Get the center of the image
    cx=$(convert $path_to_img -format "%[fx:int(w/2)]" info:)

    # Calculate length of the username
    # Divide it by 2 and multiply it by half of the pointsize
    len=${#uname}
    len=$((len/2))
    len=$((len*pointsize))

    # Finally subtract the len from the center position to get the
    # start position
    cx=$((cx-len))
}


create_lockscreen(){
    # Check if passed images are presnt
    if [ ! -f "$path_to_img" ]
    then
        echo "$path_to_img doesn't exist. Qutting!"
        exit
    fi

    if [ ! -f "$path_user_img" ]
    then
        echo "$path_user_img doesn't exist. Quitting!"
        exit
    fi

    # Resize the wall to the screen size
    res=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')
    echo "Resolution is $res"

    echo "Cropping image to fit resolution.."
    convert $path_to_img -resize "$res""^" -gravity center -extent "$res" $path_to_img

    echo "Adding blur.."
    convert $path_to_img -blur 0x10 $path_to_img

    echo "Cropping the user image to a circle.."
    # Crop the users image to a circle
    crop_pic $path_user_img

    echo "Adding the cropped user image to the image.."
    composite -gravity Center ~/.i3/lock_icon.png $path_to_img $path_to_img

    grab_text_start 34

    echo "Adding username to the image"
    convert -pointsize 34 -fill white -draw "text $cx,500 '$uname'" $path_to_img $path_to_img

    # Finally copy the img to final_img
    cp "$path_to_img" "$final_img"
}

# Check if the lockscreen is present
if [ -f "$final_img" ]
then
    echo "Lockscreen found."
else
    create_lockscreen
fi


# Pause just befor locking.
mpc pause

i3lock -i $final_img --radius 75 --ringvercolor=00000000 --ringcolor=00000000 --keyhlcolor=FFFFFFCC --insidecolor=00000000 --linecolor=00000000
#-n; mpc play
#&& python $HOME/.i3/dis_autolock.py
