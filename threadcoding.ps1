import threading
import time

# Shared array of integers
my_array = [1, 2, 3, 4, 5]

# Create a Lock object to protect access to the shared array
array_lock = threading.Lock()

def add_ten():
    """Adds 10 to each element of the array."""
    with array_lock:  # Acquire the lock before modifying the array
        for i in range(len(my_array)):
            my_array[i] += 10
        print(f"{threading.current_thread().name}: Added 10 to array. New state: {my_array}")
    # Lock is automatically released when exiting the 'with' block

def subtract_five():
    """Subtracts 5 from each element of the array."""
    with array_lock:  # Acquire the lock before modifying the array
        for i in range(len(my_array)):
            my_array[i] -= 5
        print(f"{threading.current_thread().name}: Subtracted 5 from array. New state: {my_array}")
    # Lock is automatically released when exiting the 'with' block

def print_array():
    """Prints the current state of the array."""
    with array_lock:  # Acquire the lock before accessing the array for printing
        print(f"{threading.current_thread().name}: Current array: {my_array}")
    # Lock is automatically released when exiting the 'with' block

# Create five threads
thread1 = threading.Thread(target=add_ten, name="AddTenThread-1")
thread2 = threading.Thread(target=subtract_five, name="SubtractFiveThread-1")
thread3 = threading.Thread(target=print_array, name="PrintArrayThread-1")
thread4 = threading.Thread(target=add_ten, name="AddTenThread-2")
thread5 = threading.Thread(target=subtract_five, name="SubtractFiveThread-2")

# Start the threads
thread1.start()
thread2.start()
thread3.start()
thread4.start()
thread5.start()

# Wait for all threads to complete their execution
thread1.join()
thread2.join()
thread3.join()
thread4.join()
thread5.join()

print("All threads have finished execution.")
print("Final array state:", my_array)
