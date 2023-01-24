# AWS_LAMBDA_RUNTIME_API環境変数の有無によってエミュレーターを使って起動するのかを切り替えている

# localの場合（エミュレータを使用）
if [ -z "${AWS_LAMBDA_RUNTIME_API}" ]; then
    echo "START AWS LAMBDA INTERFACE EMULATOR"
    exec aws-lambda-rie python -m awslambdaric $1
# AWS Lambda上の場合
else
    echo "START AWS LAMBDA FUNCTION"
    exec python -m awslambdaric $1
fi
