#!/bin/bash

SLICKDIR=${1:-../SlickGrid}

for i in $(find $SLICKDIR -name '*.js'); do
	dst=${i#${SLICKDIR}}
	cp "${i}" vendor/assets/javascripts/slick/"${dst/slick.}"
done
