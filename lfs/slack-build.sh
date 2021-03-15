#!/bin/bash

fdisk /dev/sda \
	n \
	p \
	1 \
	+64M \
	n \
	p \
	2 \
	t \
	1 \
	82 \
	w
mkswap /dev/sda1
sync
swapon /dev/sda1
setup