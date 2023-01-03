#Template incluses ubuntu, node, bids-validator, afni
FROM bids/base_afni

# Configure environment
ENV FSLDIR=/usr/share/fsl/5.0
ENV FSLOUTPUTTYPE=NIFTI_GZ
ENV FSLMULTIFILEQUIT=TRUE
ENV POSSUMDIR=/usr/share/fsl/5.0
ENV LD_LIBRARY_PATH=/usr/lib/fsl/5.0
ENV FSLTCLSH=/usr/bin/tclsh
ENV FSLWISH=/usr/bin/wish

ENV AFNI_PATH /usr/lib/afni/bin
ENV FSL_PATH $FSLDIR/bin/
ENV MCR_PATH /opt/mcr/v80/
ENV PATH $AFNI_PATH:$FSL_PATH:$MCR_PATH:$PATH


ENV DYLD_FALLBACK_LIBRARY_PATH $AFNI_PATH

COPY cpac_install.sh /tmp/cpac_install.sh
RUN /tmp/cpac_install.sh -s && \
    /tmp/cpac_install.sh -n fsl && \
    apt-get -qq update && \
    apt-get -q install -y --no-install-recommends python

# Install the MCR dependencies and some things we'll need and download the MCR
# from Mathworks - silently install it
RUN apt-get -qq update && \
    apt-get install -q --no-install-recommends -y unzip xorg wget curl && \
    mkdir /opt/mcr && \
    mkdir /mcr-install && \
    cd /mcr-install && \
    wget -nv http://www.mathworks.com/supportfiles/MCR_Runtime/R2012b/MCR_R2012b_glnxa64_installer.zip && \
    unzip MCR_R2012b_glnxa64_installer.zip && \
    ./install -destinationFolder /opt/mcr -agreeToLicense yes -mode silent && \
    cd / && \
    rm -rf /mcr-install

ENV MCR_CACHE_ROOT=/tmp

# bids validator in js
RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
RUN apt-get -y -Q --no-install-recommends install nodejs
RUN npm install -g bids-validator

#LMP - seems bids-validator requires yargs
#RUN npm init
RUN npm i yargs --save

RUN mkdir -p /code && \
    mkdir /oppni && \
    mkdir /projects && \
    mkdir /scratch && \
    mkdir /local-scratch

COPY run_oppni.sh /oppni/
COPY oppni /oppni/
COPY oppni.py /oppni/
ENV OPPNI /oppni
ENV PATH $OPPNI:$PATH

ENTRYPOINT ["python", "/oppni/oppni.py"]
