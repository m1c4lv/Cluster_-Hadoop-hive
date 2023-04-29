FROM hadoop-hive

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV CONDA_URL https://repo.anaconda.com/miniconda/Miniconda3-4.2.12-Linux-x86_64.sh

# Instala linux Development tools
RUN apt-get update && apt-get install build-essential -y

# Instala miniconda y otros paquetes
RUN set -x \
    && curl -fSL "$CONDA_URL" -o /tmp/conda.sh \
    && /bin/bash /tmp/conda.sh -b -p /opt/anaconda \
    && rm /tmp/conda.sh*
ENV PATH $PATH:/opt/anaconda/bin

RUN ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

# Desactiva el token de Jupyter Notebook
RUN mkdir -p /root/.jupyter
RUN touch /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.password = ''" >> /root/.jupyter/jupyter_notebook_config.py

# Actualiza conda e intala paquetes
RUN conda update conda
RUN conda install cython
RUN conda install ipython
RUN conda install ipython_genutils
RUN conda install -c free ipython-notebook
RUN conda install -c free ipython-qtconsole
RUN conda install libpng
RUN conda install notebook
RUN conda install numpy
RUN conda install pandas
RUN conda install scipy
RUN conda install jupyter
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
RUN conda update --all
RUN conda clean -t
RUN conda clean -p

# Variables de entorno para ipython con PySpark
ENV PYSPARK_PYTHON /opt/anaconda/bin/python
ENV IPYTHON 1
ENV IPYTHON_OPTS "notebook --port 8889 --notebook-dir='/media/notebooks' --ip='*' --no-browser"

RUN pip install mrjob

CMD ["jupyter", "notebook", "--port=8889", "--notebook-dir='/media/notebooks'", "--no-browser", "--ip='*'", "&"]

EXPOSE 8889
