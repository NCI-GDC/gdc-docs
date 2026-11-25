# syntax=docker/dockerfile:1
ARG BASE_VERSION=3.2.4
ARG REGISTRY=docker.osdc.io/ncigdc
ARG SERVICE_NAME=gene-expression
ARG PYTHON_VERSION=python3.9

FROM ${REGISTRY}/${PYTHON_VERSION}-builder:${BASE_VERSION} as build
ARG SERVICE_NAME
ARG PIP_INDEX_URL
ENV PIP_INDEX_URL=$PIP_INDEX_URL

WORKDIR /build
# Install dependencies first so Docker can reuse the cached layer as
# long as we don't update any pins.
COPY epel.repo /etc/yum.repos.d/
RUN dnf install -y pandoc --enablerepo=epel && \
    dnf install -y sed texlive texlive-xetex pango-devel

COPY requirements.txt .
RUN pip install -r requirements.txt

#RUN pip install git+https://github.com/jgrassler/mkdocs-pandoc
#COPY pandoc_converter.patch .
#COPY tables.patch .
#RUN patch -u /venv/lib/python3.9/site-packages/mkdocs_pandoc/pandoc_converter.py -i pandoc_converter.patch && \
#    patch -u /venv/lib/python3.9/site-packages/mkdocs_pandoc/filters/tables.py -i tables.patch
COPY . /apps

WORKDIR /apps
RUN rm -rf docs/Data/Release_Notes/*.gz &&  \
    bash build.sh

FROM ${REGISTRY}/nginx:${BASE_VERSION}
ARG NAME
ARG PYTHON_VERSION
ARG SERVICE_NAME
ARG GIT_BRANCH
ARG COMMIT
ARG BUILD_DATE

LABEL org.opencontainers.image.title="${SERVICE_NAME}" \
      org.opencontainers.image.description="${SERVICE_NAME} container image" \
      org.opencontainers.image.source="https://github.com/NCI-GDC/${SERVICE_NAME}" \
      org.opencontainers.image.vendor="NCI GDC" \
      org.opencontainers.image.ref.name="${SERVICE_NAME}:${GIT_BRANCH}" \
      org.opencontainers.image.revision="${COMMIT}" \
      org.opencontainers.image.created="${BUILD_DATE}"

COPY --chown=app:app nginx.conf /etc/nginx/conf.d/default.conf
COPY --chown=app:app --from=build /app /app
EXPOSE 80 443
