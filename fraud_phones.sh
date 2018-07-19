#!/bin/bash

for file in /home/chichivica/Data/Datasets/Phones/test/fraud_phones/*;
do 
#    echo $file
    b_file=$(basename $file)
    path=${file/$b_file/}
    echo $b_file
    echo $path
    avi_file=${file/.mp4/.avi}

    mkdir $path/output || true

    ./darknet detector demo cfg/phones.data cfg/yolov3-phones.cfg backup/yolov3-phones_240000.weights $file -thresh 0.5 -prefix ${file/.mp4/.avi}
    ffmpeg -i $avi_file $path/output/$b_file
    
    txt_file=$path/output/$b_file.txt;

    mv $avi_file.txt $txt_file;
    rm $avi_file

    python3 python/convert_for_markup_tool.py $txt_file

done
