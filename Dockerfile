FROM python:3.7-buster
COPY requirements.txt .
RUN python -m pip install --upgrade pip && pip install --no-deps --no-cache-dir -r requirements.txt
RUN apt update && apt install -yq --no-install-recommends glpk-utils libglpk-dev
COPY src /app
WORKDIR /app
EXPOSE 8888
# CMD ["/bin/bash"]
CMD ["jupyter", "notebook", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
