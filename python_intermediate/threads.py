import concurrent.futures
import threading
import logging
import time
import concurrent


def thread_function(name):
    logging.info("Thread %s:starting ", name)
    # these would basically sleep the program for 2 seconds
    time.sleep(2)
    logging.info("Thread %s fineshing", name)


if __name__ == "__main__":
    format = "%(asctime)s : %(message)s"
    logging.basicConfig(format=format, level=logging.INFO, datefmt="%H:%M:%S")
    logging.info("Main : before creating thread")
    x = threading.Thread(target=thread_function, args={1, })
    logging.info("Main : threat executing")
    x.start()
    # y = threading.Thread(target=thread_function, args={2, })
    logging.info("Main : wait untill the thread to finsh")
    x.join()
    logging.info("Main : all done")


# managing multiple threads


def thread_function(name):
    logging.info("Thread %s:starting ", name)
    # these would basically sleep the program for 2 seconds
    time.sleep(20)
    logging.info("Thread %s fineshing", name)


if __name__ == "__main__":
    format = "%(asctime)s : %(message)s"
    logging.basicConfig(format=format, level=logging.INFO, datefmt="%H:%M:%S")
    thread = list()
    for index in range(3):
        logging.info("Main : create and start thread %d ", index)
        x = threading.Thread(target=thread_function, args=(index,))
        thread.append(x)
        x.start()

    for index, thread in enumerate(thread):
        logging.info("Main before joining %d ", index)

        thread.join()
        logging.info("Main thread % d done ", index)

################
# A more optimized wayy


def thread_function(name):
    logging.info("Thread %s:starting ", name)
    # these would basically sleep the program for 2 seconds
    time.sleep(20)
    logging.info("Thread %s fineshing", name)


if __name__ == "__main__":
    format = "%(asctime)s : %(message)s"
    logging.basicConfig(format=format, level=logging.INFO, datefmt="%H:%M:%S")
    with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
        executor.map(thread_function, range(5))
    logging.info("Main thread end")
