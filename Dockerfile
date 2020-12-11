FROM thyrlian/android-sdk

# Install utils
RUN apt update && apt install --no-install-recommends -y xz-utils curl

# Install NDK
RUN sdkmanager "platform-tools" "platforms;android-29"

# Install Golang
ARG GO_VERSION=1.15.6
RUN wget -O "/tmp/go${GO_VERSION}.linux-amd64.tar.gz" "https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz" \
    && tar -C /usr/local -zxf "/tmp/go${GO_VERSION}.linux-amd64.tar.gz" \
    && rm -rf "/tmp/go${GO_VERSION}.linux-amd64.tar.gz" \
    && mkdir -p /go/bin

ENV PATH $PATH:/usr/local/go/bin:/go/bin
ENV GOPATH /go
RUN go version

# Install Go mobile
RUN go get golang.org/x/mobile/cmd/gomobile
RUN gomobile version

# Install Flutter
ARG FLUTTER_VERSION=1.22.5
RUN wget -O "/tmp/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" "https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" \
    && tar -C /opt -xf "/tmp/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" \
    && rm -rf "/tmp/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"

ENV PATH $PATH:/opt/flutter/bin

RUN flutter precache
RUN flutter doctor
