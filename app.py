import subprocess
import time
print("Welcome to the Python the Pomodoro Timer!")
time.sleep(1)
print("The pomodoro runs for 25 minutes, followed by a 5-minute break.")
time.sleep(5)
print("Keep the window open and do not close it until the timer is finished.")
time.sleep(5)
print("Starting the Pomodoro timer now...")
time.sleep(5)
subprocess.run(["bash", "pomodoro.sh"])