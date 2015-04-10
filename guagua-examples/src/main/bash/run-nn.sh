#!/bin/bash
#
# Copyright [2013-2014] eBay Software Foundation
#  
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#  
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# please follow ../README.md to run this demo shell.

OLD_HADOOP_CLASSPATH="$HADOOP_CLASSPATH"

# set new HADOOP_CLASSPATH to run guagua
export HADOOP_CLASSPATH="../lib/guagua-mapreduce-examples-0.8.0-SNAPSHOT.jar:../lib/guava-14.0.1.jar:../lib/encog-core-3.0.0.jar:../lib/guagua-mapreduce-0.8.0-SNAPSHOT.jar:../lib/guagua-core-0.8.0-SNAPSHOT.jar:../lib/zookeeper-3.4.5.jar"

hadoop jar ../lib/guagua-mapreduce-0.8.0-SNAPSHOT.jar \
    ml.shifu.guagua.mapreduce.GuaguaMapReduceClient   \
    -libjars ../lib/guagua-mapreduce-examples-0.8.0-SNAPSHOT.jar,../lib/guava-14.0.1.jar,../lib/encog-core-3.0.0.jar,../lib/guagua-mapreduce-0.8.0-SNAPSHOT.jar,../lib/guagua-core-0.8.0-SNAPSHOT.jar,../lib/zookeeper-3.4.5.jar \
    -i nn  \
    -inputformat ml.shifu.guagua.mapreduce.example.nn.NNInputFormat \
    -w ml.shifu.guagua.example.nn.NNWorker  \
    -m ml.shifu.guagua.example.nn.NNMaster  \
    -c 100 \
    -n "Guagua NN Master-Workers Job" \
    -mr ml.shifu.guagua.mapreduce.example.nn.meta.NNParams \
    -wr ml.shifu.guagua.mapreduce.example.nn.meta.NNParams \
    -Dguagua.nn.output=NN.model -Dnn.test.scale=1 -Dnn.record.scale=1 \
    -Dguagua.master.intercepters=ml.shifu.guagua.mapreduce.example.nn.NNOutput  \
    -Dmapred.job.queue.name=default
    
## restore HADOOP_CLASSPATH 
export HADOOP_CLASSPATH="$OLD_HADOOP_CLASSPATH"
