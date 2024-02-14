import os
import sys
from moviepy.editor import VideoFileClip
import numpy as np

import progress

usage = '''Usage:
python keyframes.py $VIDEO_PATH >$SAVE_PATH 3>$KEYFRAMES_FORMAT_SAVE_PATH
'''
difference = lambda frame1, frame2: round(np.sum(np.abs(frame1.astype(np.float32) - frame2.astype(np.float32))))
threshold = 327150000

if len(sys.argv) != 2:
  print(usage, file=sys.stderr)
  exit(1)
video_path = sys.argv[1]

try: extra_output = os.fdopen(3, 'w')
except: extra_output = open(os.devnull, 'w')
print('# keyframe format v1', file=extra_output)
print('fps 0', file=extra_output)

clip = VideoFileClip(video_path)
total = round(clip.duration * clip.fps)
prog = progress.initiate(total)
last_frame = None
last_timestamp = None
frame_count = 0
for timestamp, frame in clip.iter_frames(with_times=True):
  if last_frame is not None:
    if difference(frame, last_frame) >= threshold:
      print(round((timestamp + last_timestamp) / 2 * 1000), flush=True)
      print(frame_count, file=extra_output, flush=True)
  last_frame = frame
  last_timestamp = timestamp
  prog = progress.update(prog)
  frame_count += 1
progress.cleanup()
