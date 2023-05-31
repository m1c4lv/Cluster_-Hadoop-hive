FROM hadoop-hive

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN mkdir -p /opt/notebooks
VOLUME /opt/notebooks

# Activa el kernel base en conda
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

RUN mkdir -p /root/.jupyter
ADD jupyter_server_config.py  /root/.jupyter/jupyter_server_config.py

EXPOSE 8888
