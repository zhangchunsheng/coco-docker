#!/bin/bash

# 请注意
# 本脚本的作用是把本项目编译的结果保存到deploy文件夹中
# 1. 把项目数据库文件拷贝到deploy/db
# 2. 编译coco-admin
# 3. 编译coco-all模块，然后拷贝到deploy/coco

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $DIR/../..
COCO_HOME=$PWD
echo "COCO_HOME $COCO_HOME"

# 复制数据库
cat $COCO_HOME/coco-db/sql/coco_schema.sql > $COCO_HOME/deploy/db/coco.sql
cat $COCO_HOME/coco-db/sql/coco_table.sql >> $COCO_HOME/deploy/db/coco.sql
cat $COCO_HOME/coco-db/sql/coco_data.sql >> $COCO_HOME/deploy/db/coco.sql

cd $COCO_HOME/coco-admin
# 安装阿里node镜像工具
npm install -g cnpm --registry=https://registry.npm.taobao.org
# 安装node项目依赖环境
cnpm install
cnpm run build:dep

cd $COCO_HOME
mvn clean package
cp -f $COCO_HOME/coco-all/target/coco-all-*-exec.jar $COCO_HOME/deploy/coco/coco.jar