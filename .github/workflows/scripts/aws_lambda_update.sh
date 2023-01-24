#! bash/bin

# 古いバージョンのをaws lambdaを消去
for lambda_version in $(aws lambda list-versions-by-function \
            --function-name $FUNCTION \
            --query 'Versions[*].Version' \
            --output text)
    do
    OLD_VERSION=$(echo $lambda_version)
    # $LATESTは削除しない
    if test $OLD_VERSION = "\$LATEST"; then
        :
    # publishされているversionは削除
    else
        echo delete aws lambda version $OLD_VERSION
        aws lambda delete-function \
        --function-name $FUNCTION \
        --qualifier $OLD_VERSION
    fi
    done

# 最新版のaws lambdaを作成
aws lambda update-function-code --function-name $FUNCTION \
        --image-uri $ECR_REGISTRY/$REPOSITORY:$IMAGE_TAG \
        --publish