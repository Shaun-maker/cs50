from cs50 import get_float

change = -1
coins = 0
while(change < 0):
    change = get_float("Change owed: ")

if(change >= 0.25):
    n = change / 0.25
    round(n)
    for i in range(n):
        coins+= 1
        change -= 0.25

print(coins)