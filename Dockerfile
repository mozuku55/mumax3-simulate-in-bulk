FROM nvidia/cuda:12.2.0-runtime-ubuntu22.04
RUN apt-get -qq -y update
RUN apt-get -y upgrade
RUN apt-get install -y curl
RUN mkdir /mumax3
WORKDIR /mumax3
COPY run_mumax.sh /mumax3/
RUN chmod +x /mumax3/run_mumax.sh
RUN curl -OL https://mumax.ugent.be/mumax3-binaries/mumax3.10_linux_cuda11.0.tar.gz
RUN tar xvfz mumax3.10_linux_cuda11.0.tar.gz
RUN ln -s /mumax3/mumax3.10_linux_cuda11.0/mumax3-server /usr/bin/mumax3-server
RUN ln -s /mumax3/mumax3.10_linux_cuda11.0/mumax3 /usr/bin/mumax3
RUN ln -s /mumax3/mumax3.10_linux_cuda11.0/mumax3-convert /usr/bin/mumax3-convert

CMD ["bash"]