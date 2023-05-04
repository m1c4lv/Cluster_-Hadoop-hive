FROM hadoop-hive

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV CONDA_URL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

RUN mkdir -p /opt/notebooks
VOLUME /opt/notebooks

# Instala linux Development tools
RUN apt-get update && apt-get install build-essential -y

# Instala miniconda y otros paquetes
RUN set -x \
    && curl -fSL "$CONDA_URL" -o /tmp/conda.sh \
    && /bin/bash /tmp/conda.sh -b -p /opt/anaconda \
    && rm /tmp/conda.sh*
ENV PATH $PATH:/opt/anaconda/bin

RUN ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/anaconda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

# Actualiza conda e intala paquetes
RUN conda update conda && \
    conda install cython ipython ipython_genutils qtconsole libpng notebook numpy pandas scipy bokeh nltk pip scikit-learn scikit-image setuptools sympy wheel unicodecsv ujson zlib jupyter && \
    conda update --all && \
    conda clean -t && \
    conda clean -p
# Variables de entorno para ipython con PySpark
ENV PYSPARK_PYTHON /opt/anaconda/bin/python
ENV IPYTHON 1
ENV IPYTHON_OPTS "notebook --port 8889 --notebook-dir='/media/notebooks' --ip='*' --no-browser"

RUN pip install mrjob

EXPOSE 8888
