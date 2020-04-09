Bootstrap: docker
From: ubuntu:16.04

%post
	export DEBIAN_FRONTEND=noninteractive
	apt update -y
	apt upgrade -y
	apt install -y wget zip git python3-pip apt-transport-https

	# Install matplotlib biopython
	pip3 install matplotlib
	pip3 install biopython
	
	#Install guppy
	cd /tmp && \
    	wget -q https://mirror.oxfordnanoportal.com/software/analysis/ont_guppy_cpu_3.2.10-1~xenial_amd64.deb && \
	apt-get install --yes libzmq5 libhdf5-cpp-11 libcurl4-openssl-dev libssl-dev libhdf5-10 libboost-regex1.58.0 libboost-log1.58.0 libboost-atomic1.58.0 libboost-chrono1.58.0 libboost-date-time1.58.0 libboost-filesystem1.58.0 libboost-program-options1.58.0 libboost-iostreams1.58.0 && \
	dpkg -i *.deb && \
	rm *.deb
	cd /opt

	# Install miniconda
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /opt/miniconda.sh
	bash /opt/miniconda.sh -b -p /opt/miniconda
	export PATH="/opt/miniconda/bin:$PATH"
	cd /opt

	#Install ARTIC
	git clone --recursive https://github.com/artic-network/artic-ncov2019.git
	conda env update -n base --file artic-ncov2019/environment.yml
	cd artic-ncov2019/primer_schemes/nCoV-2019/V2
	samtools faidx nCoV-2019.reference.fasta
	cd /opt

	wget https://raw.githubusercontent.com/connor-lab/ncov2019-artic-nf/master/bin/qc.py -O /usr/local/bin/qc.py
	chmod +x /usr/local/bin/qc.py
	
	# Clean
	apt-get remove --purge --yes && \
    	apt-get autoremove --purge --yes && \
    	apt-get clean && \
    	rm -rf /var/lib/apt/lists/*
	conda clean --all --yes

%environment
	export PATH="/opt/miniconda/bin:$PATH"
