FROM ubuntu:trusty

# Configure environment
ENV FSLDIR=/usr/share/fsl/5.0
ENV FSLOUTPUTTYPE=NIFTI_GZ
ENV FSLMULTIFILEQUIT=TRUE
ENV POSSUMDIR=/usr/share/fsl/5.0
ENV LD_LIBRARY_PATH=/usr/lib/fsl/5.0
ENV FSLTCLSH=/usr/bin/tclsh
ENV FSLWISH=/usr/bin/wish

ENV AFNI_PATH /opt/afni/
ENV FSL_PATH $FSLDIR/bin/
ENV MCR_PATH /opt/mcr/v80/
ENV PATH $AFNI_PATH:$FSL_PATH:$MCR_PATH:$PATH

ENV PATH /opt/afni:$PATH
ENV DYLD_FALLBACK_LIBRARY_PATH /opt/afni

COPY tmp/cpac_install.sh /tmp/cpac_install.sh
RUN /tmp/cpac_install.sh -s
RUN /tmp/cpac_install.sh -p 
RUN /tmp/cpac_install.sh -n fsl
# disabling cpac afni install below to try other ways
#RUN /tmp/cpac_install.sh -n afni


#
RUN apt-get install -y python


# Install the MCR dependencies and some things we'll need and download the MCR
# from Mathworks - silently install it
RUN apt-get -qq update && apt-get -qq install -y unzip xorg wget curl && \
    mkdir /opt/mcr && \
    mkdir /mcr-install && \
    cd /mcr-install && \
    wget -nv http://www.mathworks.com/supportfiles/MCR_Runtime/R2012b/MCR_R2012b_glnxa64_installer.zip && \
    unzip MCR_R2012b_glnxa64_installer.zip && \
    ./install -destinationFolder /opt/mcr -agreeToLicense yes -mode silent && \
    cd / && \
    rm -rf /mcr-install

# bids validator in js
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
RUN sudo apt-get -y install nodejs 
RUN npm install -g bids-validator

# AFNI: from bids templates
RUN sudo apt-get update && \
    sudo apt-get install -y curl && \
    curl -sSL http://neuro.debian.net/lists/trusty.us-tn.full >> /etc/apt/sources.list.d/neurodebian.sources.list && \
    apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 0xA5D32F012649A5A9 && \
    sudo apt-get update && \
    sudo apt-get remove -y curl && \
    sudo apt-get clean && sudo apt-get update && sudo apt-get upgrade && \
    apt-get install -y afni && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# setting them later so docker image doesnt get rebuilt from scratch
ENV AFNI_PATH /usr/lib/afni/bin
ENV FSL_PATH $FSLDIR/bin/
ENV PATH $AFNI_PATH:$FSL_PATH:$MCR_PATH:$PATH

ENV DYLD_FALLBACK_LIBRARY_PATH $AFNI_PATH

RUN mkdir -p /code
RUN mkdir /oppni
RUN mkdir /projects
RUN mkdir /scratch
RUN mkdir /local-scratch

COPY run_oppni.sh /oppni/
COPY oppni /oppni/
COPY oppni.py /oppni/
ENV OPPNI /oppni
ENV PATH $OPPNI:$PATH

ENTRYPOINT ["python", "/oppni/oppni.py"]

