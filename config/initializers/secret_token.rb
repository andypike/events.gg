# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Events::Application.config.secret_key_base = 'bca2b3bb3273bdb42c93d0f278b9b4627d24518619ce22b3342c412fe9254d7a90093d8e110d1577cac539c92d7c7830a99405fccb645ea693a07375fef8e761'
