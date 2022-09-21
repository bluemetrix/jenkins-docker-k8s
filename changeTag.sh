#!/bin/bash
sed "s/tagVersion/$1/g"  pod.yml > node-app-pod.yml
