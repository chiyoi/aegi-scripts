import os
import sys
from moviepy.editor import VideoFileClip
import numpy as np

import progress

usage = '''Usage:
python kf_to_time.py $VIDEO_PATH $KF_PATH >$SAVE_PATH
'''

if len(sys.argv) != 3:
  print(usage, file=sys.stderr)
  exit(1)
video_path = sys.argv[1]
kf_path = sys.argv[2]

clip = VideoFileClip(video_path)
total = round(clip.duration * clip.fps)

with open(kf_path, 'r') as kf_file:
  kf_list = [int(line.strip()) for line in kf_file.readlines()[2:]]

prog = progress.initiate(total)
last_timestamp = None
frame_count = 0
for timestamp, frame in clip.iter_frames(with_times=True):
  if frame_count != 0 and frame_count in kf_list:
    print(round((timestamp + last_timestamp) / 2 * 1000), flush=True)
  last_timestamp = timestamp
  prog = progress.update(prog)
  frame_count += 1
progress.cleanup()
