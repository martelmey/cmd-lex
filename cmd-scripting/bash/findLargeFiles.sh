#!/bin/bash

function sunos {
	du -hsx /* | sort -r | head -10
	printf "Use:\ndu -shx /<dirname>/* | sort -rn | head -20\n"
}

function linux {
	du -shx --exclude=/{proc,sys,dev,run,tmp,srv,sbin,mnt,export,boot,media,lib64,lib,config,bin} /* | sort -r
	printf "Use:\ndu -shx /<dirname>/* | sort -rn | head -20\n"
}

uname -a | grep -q Linux
if [ $? -eq 0 ]; then
	linux
else
	sunos
fi