echo "Note: Don't put backslash at end of the path string argument."
video_path="$1"
out_dir="$2"
moviefile_base=$(basename "$video_path")
moviefile=$(echo "$moviefile_base" | sed -e 's/\.[^.]*$//')
movie_path="${out_dir}/${moviefile}"
mkdir -p $movie_path
out_dfd_file="${movie_path}/${moviefile}.dfd"
echo "Movie File Name: "$moviefile
echo "DFD File is at: "$out_dfd_file
echo "Video-Path: "$video_path
echo "Output Directory: "$out_dir
./ShotDetect "$video_path" "$out_dfd_file"
python mat_index.py --video_fname "$video_path" --base_dir "$out_dir"
python dfd_to_videoevents.py --base_dir "$out_dir" --dfd_path "$out_dfd_file"
python dump_frames_of_shot.py --base_dir "$out_dir" --video_fname "$video_path"
