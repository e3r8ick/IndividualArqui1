import random

##Determining the greatest common divisor

def gcd(a, b):
    while b != 0:
        a, b = b, a % b
    return a

##Finding the multiplicative inverse of two numbers

def multiplicative_inverse(e, L):
    d = 0
    x1 = 0
    x2 = 1
    y1 = 1
    temp_L = L
    
    while e > 0:
        temp1 = temp_L/e
        temp2 = temp_L - temp1 * e
        temp_L = e
        e = temp2
        
        x = x2- temp1* x1
        y = d - temp1 * y1
        
        x2 = x1
        x1 = x
        d = y1
        y1 = y
    
    if temp_L == 1:
        return d + L


##Tests to see if a number is prime.

def is_prime(num):
    if num == 2:
        return True
    if num < 2 or num % 2 == 0:
        return False
    for n in xrange(3, int(num**0.5)+2, 2):
        if num % n == 0:
            return False
    return True

def generate_keypair(p, q):
    if not (is_prime(p) and is_prime(q)):
        print "Both numbers must be prime"
    elif p == q:
        print "p and q cannot be equal"
    else:
        #n = pq
        n = p * q

        #Length
        L = (p-1) * (q-1)

        #Choose the value that e and L(n) are coprime
        array_between = range(1, L)

        #Verify that e and L(n) are coprime
        i = 0
        e = array_between[i]
        g = gcd(e, L)
        while g != 1:
            i += 1
            g = gcd(e, L)

        #Generate the private key
        d = multiplicative_inverse(e, L)
        
        #Return public and private keypair
        #Public key is (e, n) and private key is (d, n)
        return ((e, n), (d, n))

def encrypt(public_k, plaintext):
    #Unpack the key 
    key, n = public_k
    #Convert each letter in the plaintext to numbers based on the character
    #using a^b mod n
    cipher = [(ord(char) ** key) % n for char in plaintext]
    print cipher
    #Return the array of bytes
    return cipher

def decrypt(private_k, ciphertext):
    #Unpack the key into its components
    key, n = private_k
    #Generate the plaintext based on the ciphertext and key using a^b mod m
    plain = [chr((char ** key) % n) for char in ciphertext]
    plain = [chr((char ** key) % n) for char in ciphertext]
    print plain
    #Return the array of bytes as a string
    return ''.join(plain)
    

def rsa(p,q, message):
    public, private = generate_keypair(p, q)
    print "Your public key is ", public ," and your private key is ", private
    encrypted_msg = encrypt(public, message)
    print "Your encrypted message is: "
    print ''.join(map(lambda x: str(x), encrypted_msg))
    print "Decrypting message with public key ", public ," . . ."
    print "Your message is:"
    print decrypt(private, encrypted_msg)

rsa(11,17,"e")