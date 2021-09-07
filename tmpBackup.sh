#!/bin/bash
# File or directory backup script, that takes the file/dir and copies it to /tmp
# Created by c0y0te on 9/3/21

# Defining backup function, copies file to /tmp/ with timestamp in name.
function backup() {
   if [ -f $1 ] # Checking to see if regular file and exists
   then
      local BACK="/tmp/$(basename ${1}).$(date +%F).XXXX" # Naming syntax for mktemp
      local TMP_FILE=$(mktemp "$BACK") # Storing resulting name of new temp file
      echo "[+] Backing up $1 to ${TMP_FILE}..." # Prints name of new temp file
      cp $1 $TMP_FILE # Copies the old file to the new temp file
   elif [ -d $1 ] # Checking to see if directory
   then
      local BACK="/tmp/$(basename ${1}).$(date +%F).XXXX"
      local TMP_DIR=$(mktemp -d "$BACK") # Uses -d option for mktemp to make directory
      echo "[*] Backing up $1 to ${TMP_DIR}..."
      cp -r ./${1}/* $TMP_DIR # Copies the content of the directory into the new temp dir
   else
      echo "[!] The file or directory, ${1}, does not exist."
      return 1 # Setting return code for error to 1
   fi
}


# Promting user for file name input.
read -p "[*] Please enter the file/directory you wish to have backed up: " FILE_NAME


# Backing up file.
backup $FILE_NAME


# Checking to see if successful.
if [ $? -eq 0 ]
then
   echo "[+] Backup succeeded!"
else
   echo "[-] Backup failed!"
   exit 1 # Set error exit code to 1
fi
