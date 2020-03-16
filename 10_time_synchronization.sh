#!/bin/bash

case "$2" in
    up)
        chronyc online
        ;;
    down)
        chronyc offline
        ;;
esac
