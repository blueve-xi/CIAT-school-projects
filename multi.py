import threading

# ------------------------------------------------------------------
# Custom thread class
# ------------------------------------------------------------------
class MyThread(threading.Thread):
    def __init__(self, name):
        # Initialise the parent Thread class
        super().__init__()          # <-- preferred over threading.Thread.__init__(self)
        self.name = name

    def run(self):
        """This method is executed in the new thread."""
        for i in range(1, 6):
            print(f"{self.name}: Count {i}")

# ------------------------------------------------------------------
# Create and launch two threads
# ------------------------------------------------------------------
thread1 = MyThread("Thread 1")
thread2 = MyThread("Thread 2")

thread1.start()
thread2.start()

# ------------------------------------------------------------------
# Wait for both threads to finish
# ------------------------------------------------------------------
thread1.join()
thread2.join()

# ------------------------------------------------------------------
# Main thread continues here
# ------------------------------------------------------------------
print("Program finished.")
