def isPrime():
    number = int(input("Digite um número: "))
    isPrime = False
    for x in range(number-1, 1, -1):
        if number%x == 0:
            isPrime = True
    
    if isPrime ==  True:
        print("É primo!")
    else:
        print("Não é primo")
while True:
    isPrime()