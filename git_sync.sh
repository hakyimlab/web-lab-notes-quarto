#!/bin/bash

# Get current date and time
current_date=$(date +"%Y-%m-%d %H:%M:%S")

# Add all changes to the staging area
git add .

# Commit the changes with a timestamped message
git commit -m "Synced semi-automatically on $current_date"

# Pull the latest changes from the remote repository
git pull

# Push the changes to the remote repository
git push
