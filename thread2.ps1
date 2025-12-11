import threading
import time
import random

# Shared data
my_array = [1, 2, 3, 4, 5]

# Create a lock to prevent race conditions when multiple threads access/modify my_array
lock = threading.Lock()

def add_ten():
    """Thread function: Adds 10 to each element in my_array"""
    global my_array
    print(f"[{threading.current_thread().name}] Starting add_ten()")
    
    with lock:  # Acquire lock to ensure thread-safe modification
        for i in range(len(my_array)):
            my_array[i] += 10
        print(f"[{threading.current_thread().name}] Finished adding 10 → {my_array}")

def subtract_five():
    """Thread function: Subtracts 5 from each element in my_array"""
    global my_array
    print(f"[{threading.current_thread().name}] Starting subtract_five()")
    
    with lock:  # Critical section - only one thread can modify the array at a time
        for i in range(len(my_array)):
            my_array[i] -= 5
        print(f"[{threading.current_thread().name}] Finished subtracting 5 → {my_array}")

def print_array():
    """Thread function: Safely prints the current state of my_array"""
    global my_array
    print(f"[{threading.current_thread().name}] Requesting to print array...")
    
    with lock:  # Even reading should be protected to avoid seeing partially modified data
        print(f"[{threading.current_thread().name}] Current array: {my_array}")

# Main program
if __name__ == "__main__":
    print("Initial array:", my_array)
    print("Starting 5 concurrent threads...\n")

    # Create 5 threads as required:
    thread1 = threading.Thread(target=add_ten, name="AddTen-1")
    thread2 = threading.Thread(target=subtract_five, name="SubFive-1")
    thread3 = threading.Thread(target=print_array, name="Printer")
    thread4 = threading.Thread(target=add_ten, name="AddTen-2")
    thread5 = threading.Thread(target=subtract_five, name="SubFive-2")

    # Start all threads
    thread1.start()
    thread2.start()
    thread3.start()
    thread4.start()
    thread5.start()

    # Wait for all threads to complete
    thread1.join()
    thread2.join()
    thread3.join()
    thread4.join()
    thread5.join()

    print("\nAll threads finished.")
    print("Final array:", my_array)
