
# Table of Contents

1.  [Hadock](#org8e7d722)
    1.  [Getting started](#orgc6b400c)
    2.  [New improvements](#org297ecf6)
        1.  [Jar files mounted as volume](#org867d819)
        2.  [Remote debugging enabled](#orge695184)
        3.  [Optional ResourceManager High Availability](#orgc57bc88)
        4.  [Extended cluster with additional nodes](#orgef39964)


<a id="org8e7d722"></a>

# Hadock

Hadock is a fork of [GitHub - big-data-europe/docker-hadoop: Apache Hadoop docker image](https://github.com/big-data-europe/docker-hadoop), enhanced for self development. For basic usage, please refer to [README.md at big-data-europe/docker-hadoop](https://github.com/big-data-europe/docker-hadoop/blob/master/README.md).


<a id="orgc6b400c"></a>

## Getting started

1.  Copy/hard link a hadoop distribution inside **base** directory as **hadoop.tar.gz**. The content of the directory should look like:
    
    > .rw-r&#x2013;r&#x2013; root root   963 B  Wed Oct 21 17:23:22 2020  Dockerfile   
    > .rw-r&#x2013;r&#x2013; root root   5.1 KB Wed Oct 21 18:25:18 2020  entrypoint.sh
    > .rw-r&#x2013;r&#x2013; root root 434.4 MB Tue Jul 14 08:59:46 2020  hadoop.tar.gz
2.  Build the docker images.
    
        make
3.  Expose the directory of the hadoop jar files on the local machine.
    
        export HADOOP_LOCAL_JAR=
4.  Start the containers via docker-compose
    
        docker-compose up


<a id="org297ecf6"></a>

## New improvements


<a id="org867d819"></a>

### Jar files mounted as volume

This feature allows significantly faster development cycle. Simply compile hadoop on your local machine and restart the cluster to have your changes be reflected in Hadock.
The **HADOOP\_LOCAL\_JAR** is generally the **$HADOOP\_HOME/hadoop-dist/target/hadoop-$VERSION/share**.


<a id="orge695184"></a>

### Remote debugging enabled

The remote debugging is enabled by setting **$HADOOP\_OPTS**:

    export HADOOP_OPTS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=9999

Each role has its own debugging port, which is exposed by Docker as the following by default:

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-right" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Container</th>
<th scope="col" class="org-right">Port</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">resourcemanager</td>
<td class="org-right">9999</td>
</tr>


<tr>
<td class="org-left">nodemanager</td>
<td class="org-right">9998</td>
</tr>


<tr>
<td class="org-left">nodemanager2</td>
<td class="org-right">9997</td>
</tr>


<tr>
<td class="org-left">nodemanager3</td>
<td class="org-right">9996</td>
</tr>


<tr>
<td class="org-left">apphistoryserver</td>
<td class="org-right">9995</td>
</tr>


<tr>
<td class="org-left">jobhistoryserver</td>
<td class="org-right">9994</td>
</tr>
</tbody>
</table>

In order to change the debug port of a component, overwrite env variable:

    export RESOURCEMANAGER_DEBUG=9001

> The remote debugging could be disabled by deleting the appropriate DEBUG fields in **hadoop.env.**


<a id="orgc57bc88"></a>

### Optional ResourceManager High Availability

In order to enable RMHA, run Hadock with:

    docker-compose -f docker-compose-rmha.yml up

> 
> 
> WARNING: RMHA requires additional resources (as a zookeeper instance and a second ResourceManager instance is added)


<a id="orgef39964"></a>

### Extended cluster with additional nodes

The cluster consists of two additional nodes, which makes it a 3-node cluster. Feel free to adjust it by deleting/copying the NodeManagers appropriately in **docker-compose.yml**.

