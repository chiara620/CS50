from cs50 import get_string


text = get_string("Text: ")

nol = 0
now = 1
nos = 0

for i in range(len(text)):
    if text[i].isalpha():
        nol += 1
    elif text[i].isspace():
        now += 1
    elif text[i] == '.' or text[i] == '!' or text[i] == '?':
        nos += 1

L = 100 * (nol / now)
S = 100 * (nos / now)
index = 0.0588 * L - 0.296 * S - 15.8
index = round(index)

if index < 1:
    print("Before Grade 1")
elif index >= 16:
    print("Grade 16+")
else:
    print(f"Grade {index}")