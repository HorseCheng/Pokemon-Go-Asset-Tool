import os
import glob
import difflib
import re
import win32clipboard
from datetime import datetime

now = datetime.now().strftime("%Y%m%d")

list_of_files = glob.glob('game-master-files/*')
latest_master = re.search("[0-9A-Z]*_GAME_MASTER", max(list_of_files, key=os.path.getctime)).group()

list_of_files = glob.glob('../../Data Parser Python/Game_Master/*')
latest_txt = re.search("[0-9]*.txt", max(list_of_files, key=os.path.getctime)).group()

print("\nAutomation Start!\n==========================")
print("Latest Game Master:", latest_master, "\nLatest decoded file:", latest_txt, "\nToday:", now)

#os.system("gamemaster-decompile.bat " + latest_master)
from subprocess import DEVNULL, STDOUT, check_call
check_call(['gamemaster-decompile.bat', latest_master], stdout=DEVNULL, stderr=STDOUT)

win32clipboard.OpenClipboard()
data = win32clipboard.GetClipboardData().replace("\x00","").splitlines()
win32clipboard.CloseClipboard()

with open('../../Data Parser Python/Game_Master/'+latest_txt, 'r') as f:
    f=f.read().splitlines()
    
print("\nDiff file processing...")
diff=""
for i in difflib.unified_diff(f,data):
    diff+=i+'\n'
if(diff==""): print("There is nothing changed!")
else:
    print(diff)

x = input("\nSave the file? (y/n): ")
if(x=='y' or x=="Y"):
    with open('../../Data Parser Python/Game_Master/'+now+'.txt','w') as t:
        str1 = ''.join(str(e+'\n') for e in data)
        t.write(str1)
        print('"'+now+'.txt" is saved successfully!')

print("\nAutomation Exit!\n==========================")
