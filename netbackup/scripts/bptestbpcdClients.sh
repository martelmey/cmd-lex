#!/bin/bash

declare -a CLIENTS=(
	"test-hial1"
	"test-posia2"
	"test-hial-fam1"
	"test-cmu-fam1"
	"test-idm1"
	"test-cache1"
	"test-lab2"
	"test-hial-ohs1"
	"test-hial-ohs2"
	"test-hial-d2"
	"test-cmu-d1"
	"int2-hial-wls1"
	"int2-hial-wls2"
	"int2-cmu-fam1"
	"int2-posia-ohs1"
	"sand-hial-wls1"
	"sand-posia-ohs1"
	"sand-posia-wls1"
	)

for CLIENT in "${CLIENTS[@]}"
do
	bptestbpcd -client "$CLIENT"
done