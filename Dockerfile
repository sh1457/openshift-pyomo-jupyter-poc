FROM python:3-7-buster-slim as base

FROM base as builder
RUN mkdir /install
WORKDIR /install
COPY requirements.txt /install/requirements.txt
RUN pip install --install-option="--prefix=/install" -r /requirements.txt
RUN apt update && apt install -yq --no-install-recommends \
	glpk \
	fonts-liberation \
	fonts-firacode \

FROM base
COPY --from=builder /install /usr/local
COPY src /app
WORKDIR /app
EXPOSE 8888
CMD ["jupyter", "notebook", "--no-browser", "--ip=0.0.0.0"]
