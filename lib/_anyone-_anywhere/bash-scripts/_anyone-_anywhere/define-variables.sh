#!/bin/bash

envIsWSL=0
envIsLinux=0
envIsCygwin=0
envIsGitBash=0

copywritingLanguage="zh_CN" # "zh_CN" or "en_US"

sshFolder=~/.ssh # DO NOT QUOTE THIS VALUE!
sshBackupFolder="$sshFolder/backup" # 对于Windows用户，其为“c:\Users\你的用户名\.ssh\backup”