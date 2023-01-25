FROM python:3.9-buster

ENV CMAKE_ARGS="-DONNX_USE_PROTOBUF_SHARED_LIBS=ON"

WORKDIR /workdir

# localで実行するために、runtime interface emulatorのインストール
ADD https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie /usr/bin/aws-lambda-rie
RUN chmod 755 /usr/bin/aws-lambda-rie

COPY requirements.txt /requirements.txt
RUN pip install -U pip && \
    pip install --no-cache-dir -r /requirements.txt

COPY entry.sh /entry.sh
RUN chmod 755 /entry.sh

ENTRYPOINT [ "/bin/bash", "/entry.sh" ]
CMD [ "app.lambda_handler" ]
