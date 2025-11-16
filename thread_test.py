import threading

def print_nums():
    for i in range(10):
        print(f'Number: {i}')

print_nums()

def print_chars():
    for i in range(97, 107):
        print(f'Character: {chr(i)}')


thread1 = threading.Thread(target=print_nums)
thread2 = threading.Thread(target=print_chars)

thread1.start()
thread2.start()

thread1.join()
thread2.join()

print("End of program")