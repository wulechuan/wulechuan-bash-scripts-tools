#!/bin/bash

thisDockerIPSuffix=$(hostname -I | cut -d' ' -f2 | cut -d'.' -f4)
dummyGitUserName="gituser@"