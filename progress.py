# Origin: https://qiita.com/kuroitu/items/f18acf87269f4267e8c1
import sys

class Progress:
  total: int
  current: int
  flag: bool = False

def initiate(total: int) -> Progress:
  epochs = 30
  print("\n\n\n", file=sys.stderr)
  print("　"*(epochs-10) + "彡ﾉﾉﾊミ ⌒ミ", file=sys.stderr)
  print("　"*(epochs-11) + " (´・ω・｀)ω･｀)　今だ！オラごと撃て！", file=sys.stderr)
  print("　"*(epochs-11) + "⊂∩　　　　∩つ  ）", file=sys.stderr)
  print("　"*(epochs-11) + " /　　　〈　 〈", file=sys.stderr)
  print("　"*(epochs-11) + " (／⌒｀ Ｊ⌒し'", file=sys.stderr)
  print("\033[5A", end="", file=sys.stderr)
  progress =  Progress()
  progress.total = total
  progress.current = 0
  progress.flag = False
  return progress

def update(progress: Progress):
  total = progress.total
  current = progress.current
  flag = progress.flag
  epochs = 30
  i = round(epochs / total * current)
  bar = "\033[33m弌"*i + "⊃\033[37m"
  print("\r\033[32mにｱ" + bar, end="", file=sys.stderr)
  if i == int(epochs*0.25):
    print("\033[E", end="", file=sys.stderr)
    print("　"*(epochs-11) + " (´・ω・｀)ω･｀)　離せっ！！オ…オレが悪かった！！", end="", file=sys.stderr)
    print("\033[A", end="", file=sys.stderr)
  elif i == int(epochs*0.5):
    flag = True
    print("\033[E", end="", file=sys.stderr)
    print("　"*(epochs-11) + " (´；ω；｀)ω^｀)　ぐ…！！ち…ちくしょおおお！！！", end="", file=sys.stderr)
    print("\033[A", end="", file=sys.stderr)
  if flag:
    if i == int(epochs*0.5)+1:
      print("\033[F", end="", file=sys.stderr)
      print("　"*(epochs-9)  + "ﾉ", file=sys.stderr)
    elif i == int(epochs*0.5)+3:
      print("\033[2F", end="", file=sys.stderr)
      print("　"*(epochs-8)  + "ﾉ", file=sys.stderr)
      print("　"*(epochs-9)  + "彡　ノ", file=sys.stderr)
    elif i == int(epochs*0.5)+5:
      print("\033[3F", end="", file=sys.stderr)
      print("　"*(epochs-5)  + "ﾉ", file=sys.stderr)
      print("　"*(epochs-8)  + "彡　ノ", file=sys.stderr)
      print("　"*(epochs-9)  + "ノ", file=sys.stderr)
    elif i == int(epochs*0.5)+7:
      print("\033[4F", end="", file=sys.stderr)
      print("　"*(epochs-3)  + "ﾉ", file=sys.stderr)
      print("　"*(epochs-6)  + "彡　ノ", file=sys.stderr)
      print("　"*(epochs-8)  + "ノ", file=sys.stderr)
      print("　"*(epochs-9)  + "ﾉノ　　　ミ　ﾉノ", file=sys.stderr)
  progress = Progress()
  progress.total = total
  progress.current = current + 1
  progress.flag = flag
  return progress

def cleanup():
  print(file=sys.stderr)
  print("\033[5B", end="", file=sys.stderr)
