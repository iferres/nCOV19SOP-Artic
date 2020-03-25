Bootstrap: docker
From: ubuntu:16.04

%post
	apt update -y
	apt upgrade -y
	apt install -y wget zip git python3-pip
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /opt/miniconda.sh
	bash /opt/miniconda.sh -b -p /opt/miniconda
	export PATH="/opt/miniconda/bin:$PATH"
	cd /opt
	git clone --recursive https://github.com/artic-network/artic-ncov2019.git
	conda env update -n base --file artic-ncov2019/environment.yml
	apt clean -y
	apt autoremove -y
	conda clean --all --yes

%environment
	export PATH="/opt/miniconda/bin:$PATH"
