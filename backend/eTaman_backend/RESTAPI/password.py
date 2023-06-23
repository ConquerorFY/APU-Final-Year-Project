import bcrypt
import jwt
import datetime

secretKey = "12345678@##$%NANSNC"
expirationMinutes = 60

# Encrypt password
def encryptPassword(password: str):
    password = password.encode("utf-8")     # convert to bytes
    salt = bcrypt.gensalt()                 # generate a random salt
    cipher = bcrypt.hashpw(password, salt)  # hash password with salt (in bytes)
    return cipher.decode("utf-8")           # decode the bytes back into str

# Decrypt password
def decryptPassword(password: str, cipher: str):
    password = password.encode("utf-8")
    cipher = cipher.encode("utf-8")
    return bcrypt.checkpw(password, cipher)

# Generate JWT token
def generateJWTToken(payload):
    # Set the token expiration time
    expiration = datetime.datetime.utcnow() + datetime.timedelta(minutes=expirationMinutes)
    # Convert the expiration time to a serializable format
    expiration = expiration.isoformat()
    # Create the token with the payload and expiration time
    token = jwt.encode({'expiry': expiration, **payload}, secretKey, algorithm='HS256')
    # Return the token (a string)
    return token

# Decode JWT token
def decodeJWTToken(token):
    try:
        # Decode the token using the secret key
        decodedToken = jwt.decode(token, secretKey, algorithms=['HS256'])
        return decodedToken
    except jwt.ExpiredSignatureError:
        # Token has expired
        print("Token has expired.")
        return False
    except jwt.InvalidTokenError:
        # Invalid token
        print("Invalid token.")
        return False
