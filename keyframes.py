import sys
from moviepy.editor import VideoFileClip
import numpy as np

import progress

usage = '''Usage:
python keyframes.py <video_path> > <save_path>
'''
difference = lambda frame1, frame2: round(np.sum(np.abs(frame1.astype(np.float32) - frame2.astype(np.float32))))
threshold = 329844830

if len(sys.argv) != 2:
  print(usage, file=sys.stderr)
  exit(1)
video_path = sys.argv[1]

clip = VideoFileClip(video_path)
total = round(clip.duration * clip.fps)
prog = progress.initiate(total)
last_frame = None
last_timestamp = None
for timestamp, frame in clip.iter_frames(with_times=True):
  if last_frame is not None:
    if difference(frame, last_frame) >= threshold:
      print(round((timestamp + last_timestamp) / 2 * 1000), flush=True)
  last_frame = frame
  last_timestamp = timestamp
  prog = progress.update(prog)
progress.cleanup()
