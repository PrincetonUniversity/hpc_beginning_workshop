from multiprocessing import Process, Value, Array, Lock

def increment(shared_int, shared_arr, lock):
    with lock:
        shared_int.value += 1
        for i in range(len(shared_arr)):
            shared_arr[i] += 1

if __name__ == "__main__":
    lock = Lock()
    x = Value('i', 0)
    arr = Array('i', range(5))
    procs = [Process(target=increment, args=(x, arr, lock)) for _ in range(4)]
    for p in procs: p.start()
    for p in procs: p.join()
    print(x.value, list(arr))