import bcrypt

def encryptPassword(password: str):
    password = password.encode("utf-8")     # convert to bytes
    salt = bcrypt.gensalt()                 # generate a random salt
    cipher = bcrypt.hashpw(password, salt)  # hash password with salt (in bytes)

    return cipher.decode("utf-8")           # decode the bytes back into str