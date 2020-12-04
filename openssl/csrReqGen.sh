#!/bin/bash

FQDNS=(
    cmu-fam.sand.hial.healthbc.org
    cmu-idm.sand.hial.healthbc.org
    fha-posia.sand.hial.healthbc.org
    hial-fam.sand.hial.healthbc.org
    iha-posia.sand.hial.healthbc.org
    jee-hial.sand.hial.healthbc.org
    nha-posia.sand.hial.healthbc.org
    osb-posia.sand.hial.healthbc.org
    phsa-posia.sand.hial.healthbc.org
    psm.sand.hial.healthbc.org
    vch-posia.sand.hial.healthbc.org
    viha-posia.sand.hial.healthbc.org
    admin.int1.hial.healthbc.org
    cmu-fam.int1.hial.healthbc.org
    cmu-idm.int1.hial.healthbc.org
    fha-posia.int1.hial.healthbc.org
    hial-fam.int1.hial.healthbc.org
    igf.int1.hial.healthbc.org
    iha-posia.int1.hial.healthbc.org
    jee-hial.int1.hial.healthbc.org
    nha-posia.int1.hial.healthbc.org
    ohs.int1.hial.healthbc.org
    osb-posia.int1.hial.healthbc.org
    phsa-posia.int1.hial.healthbc.org
    psm.int1.hial.healthbc.org
    vch-posia.int1.hial.healthbc.org
    viha-posia.int1.hial.healthbc.org
    admin.test.hial.healthbc.org
    cmu-fam.test.hial.healthbc.org
    cmu-idm.test.hial.healthbc.org
    fha-posia.test.hial.healthbc.org
    hial-fam.test.hial.healthbc.org
    igf.test.hial.healthbc.org
    iha-posia.test.hial.healthbc.org
    jee-hial.test.hial.healthbc.org
    nha-posia.test.hial.healthbc.org
    ohs.test.hial.healthbc.org
    osb-posia.test.hial.healthbc.org
    phsa-posia.test.hial.healthbc.org
    psm.test.hial.healthbc.org
    vch-posia.test.hial.healthbc.org
    viha-posia.test.hial.healthbc.org
    admin.brt.hial.healthbc.org
    cmu-fam.brt.hial.healthbc.org
    cmu-idm.brt.hial.healthbc.org
    fha-posia.brt.hial.healthbc.org
    hial-fam.brt.hial.healthbc.org
    igf.brt.hial.healthbc.org
    iha-posia.brt.hial.healthbc.org
    jee-hial.brt.hial.healthbc.org
    nha-posia.brt.hial.healthbc.org
    ohs.brt.hial.healthbc.org
    osb-posia.brt.hial.healthbc.org
    phsa-posia.brt.hial.healthbc.org
    psm.brt.hial.healthbc.org
    vch-posia.brt.hial.healthbc.org
    viha-posia.brt.hial.healthbc.org
    admin.brd.hial.healthbc.org
    cmu-fam.brd.hial.healthbc.org
    cmu-idm.brd.hial.healthbc.org
    fha-posia.brd.hial.healthbc.org
    hial-fam.brd.hial.healthbc.org
    igf.brd.hial.healthbc.org
    iha-posia.brd.hial.healthbc.org
    jee-hial.brd.hial.healthbc.org
    nha-posia.brd.hial.healthbc.org
    ohs.brd.hial.healthbc.org
    osb-posia.brd.hial.healthbc.org
    phsa-posia.brd.hial.healthbc.org
    psm.brd.hial.healthbc.org
    vch-posia.brd.hial.healthbc.org
    viha-posia.brd.hial.healthbc.org
    admin.dev.hial.healthbc.org
    cmu-fam.dev.hial.healthbc.org
    cmu-idm.dev.hial.healthbc.org
    fha-posia.dev.hial.healthbc.org
    hial-fam.dev.hial.healthbc.org
    igf.dev.hial.healthbc.org
    iha-posia.dev.hial.healthbc.org
    jee-hial.dev.hial.healthbc.org
    nha-posia.dev.hial.healthbc.org
    ohs.dev.hial.healthbc.org
    osb-posia.dev.hial.healthbc.org
    phsa-posia.dev.hial.healthbc.org
    psm.dev.hial.healthbc.org
    vch-posia.dev.hial.healthbc.org
    viha-posia.dev.hial.healthbc.org
)

for FQDN in ${FQDNS[@]}
do
    echo "--> $FQDN"
    perl -pi -e "s|^DNS.1.*|DNS.1 = $FQDN|" openssl.cnf
    openssl req \
    -newkey rsa:2048 \
    -keyout "$FQDN".key \
    -out "$FQDN".csr \
    -days 730 \
    -subj "/emailAddress=hialplis.apps@cgi.com/CN=${FQDN}/OU=Information Security/O=PHSA/L=Vancouver/ST=British Columbia/C=CA" \
    -config openssl.cnf \
    -extensions v3_req \
    -passout pass:"6;ZQRVb%*4"
done