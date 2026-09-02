#! /bin/sh

#
# Transparent Bedrock
#
# A Minecraft resource pack that gives Bedrock blocks a more transparent appearance.
# https://github.com/cvsync/TransparentBedrock
#

VER_MAJOR=1
VER_MINOR=0
VER_REV=0

MAX_PACK_FORMAT=97
MAX_PACK_FORMAT_MINOR=1

MIN_PACK_FORMAT=69
MIN_PACK_FORMAT_MINOR=0

UUID1=fd72bd82-c3eb-4146-be39-e852a8b20fa4
UUID2=19f09f9d-a1dd-46a7-94c9-8e5bf805b5a3

RESOURCE_PACK_NAME=TransparentBedrock

RESOURCE_PACK_FILE_JAVA=${RESOURCE_PACK_NAME}_v${VER_MAJOR}.${VER_MINOR}.${VER_REV}.zip
RESOURCE_PACK_FILE_BEDROCK=${RESOURCE_PACK_NAME}_v${VER_MAJOR}.${VER_MINOR}.${VER_REV}.mcpack

TMPDIR=./tmp

rm -f -r ${VER_MAJOR}.${VER_MINOR}.${VER_REV}
mkdir -p ${VER_MAJOR}.${VER_MINOR}.${VER_REV}

#
# for Java Edition (1.13 or above)
#
TEXTURES_SRCDIR=${RESOURCE_PACK_NAME}/assets/minecraft/textures/blocks
TEXTURES_DSTDIR=${TMPDIR}/assets/minecraft/textures/block
rm -f ${RESOURCE_PACK_FILE_JAVA}
rm -f -r ${TMPDIR}
mkdir -p ${TMPDIR} ${TMPDIR}/assets
mkdir -p ${TMPDIR}/assets/minecraft ${TMPDIR}/assets/minecraft/textures ${TMPDIR}/assets/minecraft/textures/block
cp ${TEXTURES_SRCDIR}/bedrock.png ${TEXTURES_DSTDIR}/bedrock.png
cp -R ${RESOURCE_PACK_NAME}/pack.png ${TMPDIR}/
_destfile=pack.mcmeta
cat ${RESOURCE_PACK_NAME}/${_destfile} | \
sed "s/XXXMAXPACKFORMATXXX/${MAX_PACK_FORMAT}/g" | \
sed "s/XXXMAXPACKFORMATMINORXXX/${MAX_PACK_FORMAT_MINOR}/g" | \
sed "s/XXXMINPACKFORMATXXX/${MIN_PACK_FORMAT}/g" | \
sed "s/XXXMINPACKFORMATMINORXXX/${MIN_PACK_FORMAT_MINOR}/g" | \
sed "s/XXXMAJORXXX/${VER_MAJOR}/g" | \
sed "s/XXXMINORXXX/${VER_MINOR}/g" | \
sed "s/XXXREVXXX/${VER_REV}/g" | \
sed "s/XXXUUID1XXX/${UUID1}/g" | \
sed "s/XXXUUID2XXX/${UUID2}/g" | \
sed "s///g" > ${TMPDIR}/${_destfile}
(cd ${TMPDIR}/ && sudo chown -R 0:0 .)
(cd ${TMPDIR}/ && zip -r ../${VER_MAJOR}.${VER_MINOR}.${VER_REV}/${RESOURCE_PACK_FILE_JAVA} . -i "*")
sudo rm -f -r ${TMPDIR}

#
# for Bedrock Edition
#
rm -f ${RESOURCE_PACK_FILE_BEDROCK}
rm -f -r ${TMPDIR}
mkdir -p ${TMPDIR}
cp -R ${RESOURCE_PACK_NAME}/assets/minecraft/textures ${TMPDIR}/
cp -R ${RESOURCE_PACK_NAME}/manifest.json             ${TMPDIR}/
cp -R ${RESOURCE_PACK_NAME}/pack.png                  ${TMPDIR}/pack_icon.png
_destfile=manifest.json
cat ${RESOURCE_PACK_NAME}/${_destfile} | \
sed "s/XXXMAJORXXX/${VER_MAJOR}/g" | \
sed "s/XXXMINORXXX/${VER_MINOR}/g" | \
sed "s/XXXREVXXX/${VER_REV}/g" | \
sed "s/XXXUUID1XXX/${UUID1}/g" | \
sed "s/XXXUUID2XXX/${UUID2}/g" | \
sed "s///g" > ${TMPDIR}/${_destfile}
(cd ${TMPDIR}/ && sudo chown -R 0:0 .)
(cd ${TMPDIR}/ && zip -r ../${VER_MAJOR}.${VER_MINOR}.${VER_REV}/${RESOURCE_PACK_FILE_BEDROCK} . -i "*")
sudo rm -f -r ${TMPDIR}

ls -l ${VER_MAJOR}.${VER_MINOR}.${VER_REV}/
