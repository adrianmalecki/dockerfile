FROM almalinux:9.3

# Instalujemy zależności systemowe
RUN dnf install -y python3 python3-pip && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    dnf clean all

# Instalujemy Jupyter Notebook
RUN pip install --no-cache-dir jupyter

# Tworzymy katalog roboczy
WORKDIR /workspace

# Eksponujemy port dla Jupyter Notebook
EXPOSE 8888

# Uruchamiamy Jupyter Notebook po starcie kontenera
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
