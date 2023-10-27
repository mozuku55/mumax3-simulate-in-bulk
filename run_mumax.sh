#!/bin/bash

INPUT_DIR="/mumax_input"
OUTPUT_DIR="/mumax_output"

# 入力ディレクトリ内のすべての .mx3 ファイルを処理
while true; do
    for sim_dir in $INPUT_DIR/*; do
        if [ -d "$sim_dir" ]; then
            for mxfile in "$sim_dir"/*.mx3; do
                #file名と同盟のdirを取得
                file_base=$(basename -- "$mxfile" .mx3)
                dir_name="$sim_dir/$file_base.out"
                if [ -d "$dir_name" ]; then
                    #.outディレクトリがある場合には計算済とみなしてSkipする
                    echo "Skipping $mxfile because a directory with the same name exists."
                else
                    echo "start simulation $mxfile" 
                    mumax3 "$mxfile"
                    mumax3-convert -png "$sim_dir"/*.ovf
                fi
            done
            mv "$sim_dir" "$OUTPUT_DIR/"
        fi
    done
    if [ -z "$(find "$INPUT_DIR" -mindepth 1 -maxdepth 1 -type d)" ]; then
        break
    fi
done
