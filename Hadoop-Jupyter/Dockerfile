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
RUN conda update conda
RUN conda install cython
RUN conda install ipython
RUN conda install ipython_genutils
RUN conda install qtconsole
RUN conda install libpng
RUN conda install notebook
RUN conda install numpy
RUN conda install pandas
RUN conda install scipy
RUN conda install bokeh
RUN conda install nltk
RUN conda install pip
RUN conda install scikit-learn
RUN conda install scikit-image
RUN conda install setuptools
RUN conda install sympy
RUN conda install wheel
RUN conda install unicodecsv
RUN conda install ujson
RUN conda install zlib
RUN conda install jupyter
RUN conda update --all
RUN conda clean -t
RUN conda clean -p

# Variables de entorno para ipython con PySpark
ENV PYSPARK_PYTHON /opt/anaconda/bin/python
ENV IPYTHON 1
ENV IPYTHON_OPTS "notebook --port 8889 --notebook-dir='/media/notebooks' --ip='*' --no-browser"

RUN pip install mrjob

ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
