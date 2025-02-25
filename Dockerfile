# Pobieramy AlmaLinux 9.3
FROM almalinux:9.3

# Instalujemy niezbędne zależności
RUN dnf install -y gcc openssl-devel bzip2-devel libffi-devel zlib-devel make

# Pobieramy i instalujemy Pythona w /opt/python3
RUN cd /opt && \
    curl -O https://www.python.org/ftp/python/3.9.10/Python-3.9.10.tgz && \
    tar xzf Python-3.9.10.tgz --no-same-owner && \
    cd Python-3.9.10 && \
    ./configure --prefix=/opt/python3 && \
    make && \
    make install && \
    rm -rf /opt/Python-3.9.10

# Tworzymy dowiązania symboliczne i dodajemy /opt/python3/bin do PATH
RUN rm -f /usr/bin/python3 && \
    ln -s /opt/python3/bin/python3 /usr/bin/python3 && \
    ln -s /opt/python3/bin/pip3 /usr/bin/pip3 && \
    echo "export PATH=/opt/python3/bin:$PATH" >> /etc/profile

# Instalujemy Jupyter Notebook
RUN pip3 install --no-cache-dir jupyter

# Tworzymy katalog roboczy
WORKDIR /workspace

# Eksponujemy port dla Jupyter Notebook
EXPOSE 8888

# Uruchamiamy Jupyter Notebook po starcie kontenera
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
