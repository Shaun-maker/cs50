from cs50 import get_string

def main():

    s = get_string("Text: ")
    count_letters(s)

def count_letters(sentences):
    count_letters = 0
    for i in range(len(sentences)):
        c = sentences[i]
        if(c.isalpha()):
            count_letters += 1
        print(count_letters)

if __name__ == "__main__":
    main()
