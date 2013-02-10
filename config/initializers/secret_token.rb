# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
raise "Please set environment variable PETITIONS_SECRET_TOKEN to a string that is a random string of longer than 30 characters" unless ENV["PETITIONS_SECRET_TOKEN"]
Petitions::Application.config.secret_token = ENV["PETITIONS_SECRET_TOKEN"]
