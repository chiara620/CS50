from cs50 import get_int


def main():
    height = get_height()
    for i in range(height):
        for j in range(height):
            if i + j >= height - 1:
                print("#", end="")
            else:
                print(" ", end="")
        print()


def get_height():
    while True:
        try:
            height = get_int("Height: ")
            if 0 < height <= 8:
                return height
        except ValueError:
            print("Not an integer")


main()