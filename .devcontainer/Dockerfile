FROM golang:bookworm

ARG UID
ARG GID
ARG UNAME
ARG MARIADBVER

# Create docker user
RUN groupadd -g ${GID} ${UNAME} \
    && useradd -m -u ${UID} -g ${UNAME} ${UNAME}

# Install dependencies
RUN apt -y update \
    && apt -y upgrade \
    && apt -y --no-install-recommends install \
    wget curl git ca-certificates build-essential liblzo2-dev

# Pull MariaDB connector cus bookworm is apparently too old already
RUN wget https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
RUN chmod +x mariadb_repo_setup
RUN ./mariadb_repo_setup \ --mariadb-server-version="mariadb-${MARIADBVER}"
RUN apt install -y libmariadb3 libmariadb-dev

# Install requirements
COPY src/go.mod .
COPY src/go.sum .
RUN go mod download

# Cleanup
RUN apt -y clean \
    && apt -y autoremove \
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/*

# Change ownership to container created user
RUN chown -R ${UNAME} . \
    && chgrp -R ${UNAME} .

# Switch to user
USER ${UNAME}
RUN echo "export PATH=/home/${UNAME}/.local/bin:${PATH}" >> ~/.bashrc

# Start shell
ENTRYPOINT [ "/bin/bash" ]