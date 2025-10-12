from multiprocessing import Process, Value, Array

def increment(shared_int, shared_arr):
    shared_int.value += 1
    for i in range(len(shared_arr)):
        shared_arr[i] += 1

if __name__ == "__main__":
    x = Value('i', 0)
    arr = Array('i', range(5))
    procs = [Process(target=increment, args=(x, arr)) for _ in range(4)]
    for p in procs: p.start()
    for p in procs: p.join()
    print(x.value, list(arr))
