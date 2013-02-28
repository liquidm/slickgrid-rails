#!/bin/bash

SLICKDIR=${1:-../SlickGrid}

# copy JS files
for i in $(find $SLICKDIR -name '*.js'); do
	dst=${i#${SLICKDIR}}
	cp "${i}" vendor/assets/javascripts/slick/"${dst/slick.}"
done

# copy slickgrid-plugins files
for i in $(find $SLICKDIR -name '*.js'); do
	dst=${i#${SLICKDIR}}
	cp "${i}" vendor/assets/javascripts/slick/plugins/"${dst/slick.}"
done
for i in $(find $SLICKDIR -name '*.css'); do
	dst=${i#${SLICKDIR}}
	cp "${i}" vendor/assets/stylesheets/slick/plugins/"${dst/slick.}"
done

# copy slickgrid-controls files
for i in $(find $SLICKDIR -name '*.js'); do
	dst=${i#${SLICKDIR}}
	cp "${i}" vendor/assets/javascripts/slick/controls/"${dst/slick.}"
done
for i in $(find $SLICKDIR -name '*.css'); do
	dst=${i#${SLICKDIR}}
	cp "${i}" vendor/assets/stylesheets/slick/controls/"${dst/slick.}"
done

# copy CSS files
for i in $(find $SLICKDIR -name '*.css'); do
	dst=${i#${SLICKDIR}}
	cp "${i}" vendor/assets/stylesheets/slick/"${dst/slick.}"
done

