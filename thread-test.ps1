import threading
import time

# Shared array of integers
my_array = [1, 2, 3, 4, 5]

# A lock to protect the shared array from race conditions
array_lock = threading.Lock()


def add_ten():
    # Acquire the lock before accessing the shared resource
    with array_lock:
        for i in range(len(my_array)):
            my_array[i] += 10
        # The lock is automatically released when exiting the 'with' block
        print(f"{threading.current_thread().name} finished adding 10.")


def subtract_five():
    # Acquire the lock before accessing the shared resource
    with array_lock:
        for i in range(len(my_array)):
            my_array[i] -= 5
        # The lock is automatically released when exiting the 'with' block
        print(f"{threading.current_thread().name} finished subtracting 5.")


def print_array():
    # Acquire the lock before accessing the shared resource
    with array_lock:
        print("Current array:", my_array)
        # The lock is automatically released when exiting the 'with' block
    # Add a small sleep to help demonstrate concurrency with other prints, if desired
    time.sleep(0.1)


# Create five threads as requested
thread1 = threading.Thread(target=add_ten, name="Thread-Add1")
thread2 = threading.Thread(target=subtract_five, name="Thread-Sub1")
thread3 = threading.Thread(target=print_array, name="Thread-Print")
thread4 = threading.Thread(target=add_ten, name="Thread-Add2")
thread5 = threading.Thread(target=subtract_five, name="Thread-Sub2")

# Start all threads
thread1.start()
thread2.start()
thread3.start()
thread4.start()
thread5.start()

# Wait for all threads to complete their execution before the main program finishes
thread1.join()
thread2.join()
thread3.join()
thread4.join()
thread5.join()

# Print the final state of the array after all modifications are complete
print("All threads finished.")
print_array()
