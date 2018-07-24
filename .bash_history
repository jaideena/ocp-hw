      type: "Git"
      git:
        uri: "http://gogs-jdeenada-gogs.apps.00d0.example.opentlc.com/CICDLabs/openshift-tasks.git"
    strategy:
      type: "JenkinsPipeline"
      jenkinsPipelineStrategy:
        jenkinsfilePath: Jenkinsfile
kind: List
metadata: []" | oc create -f - -n jdeenada-jenkins
oc set build-secret --source bc/tasks-pipeline gogs-secret -n jdeenada-jenkins
oc secrets new-basicauth gogs-secret --username=jaideena --password=jaideena -n jdeenada-jenkins
oc create secret get
oc get secrets
oc status
oc project jdeenada-jenkins 
oc get pods
oc get secrets
oc delete secrets gogs-secret 
oc create secret gogs-secret --username=jaideena --password=jaideena -n jdeenada-jenkins
oc secrets new-basicauth gogs-secret --username=jaideena --password=jaideena -n jdeenada-jenkins
oc get secrets
oc new-app jenkins-persistent -p ENABLE_OAUTH=false -e JENKINS_PASSWORD=openshiftpipelines -n jdeenada-pipeline-tasks-dev 
oc new-project jdeenada-pipeline-tasks-test --display-name "Tasks testing"
oc project jdeenada-jenkins 
oc policy add-role-to-user edit system:serviceaccount:jdeenada-pipeline-tasks-dev:jenkins -n jdeenada-pipeline-tasks-test 
oc policy add-role-to-user edit system:serviceaccount:jdeenada-pipeline-tasks-dev:jenkins -n jdeenada-pipeline-tasks-prod
oc policy add-role-to-group system:image-puller system:serviceaccounts:jdeenada-pipeline-tasks-prod -n jdeenada-pipeline-tasks-dev
oc policy add-role-to-group system:image-puller system:serviceaccounts:jdeenada-pipeline-tasks-test -n jdeenada-pipeline-tasks-dev
oc new-app http://gogs-jdeenada-gogs.apps.00d0.example.opentlc.com/CICDLabs/openshift-tasks.git -n jdeenada-pipeline-tasks-dev
oc new-app php~https://github.com/StefanoPicozzi/cotd2 -n jdeenada-pipeline-tasks-dev
oc logs -f build/cotd2-1 -n jdeenada-pipeline-tasks-dev
oc logs -f bc/cotd2
oc get pods
oc get pods -n jdeenada-pipeline-tasks-dev
oc logs -f build/cotd2-1 -n jdeenada-pipeline-tasks-dev
oc tag cotd2:latest cotd2:testready -n jdeenada-pipeline-tasks-dev
oc tag cotd2:testready cotd2:prodready -n jdeenada-pipeline-tasks-dev
oc new-app jdeenada-pipeline-tasks-dev/cotd2:testready --name=cotd2 -n jdeenada-pipeline-tasks-test 
oc new-app jdeenada-pipeline-tasks-dev/cotd2:prodready --name=cotd2 -n jdeenada-pipeline-tasks-prod
oc logs -f build/cotd2-1 -n jdeenada-pipeline-tasks-test
oc logs -f build/cotd2-1 -n jdeenada-pipeline-tasks-prod
clear
oc expose service cotd2 -n jdeenada-pipeline-tasks-dev 
oc expose service cotd2 -n jdeenada-pipeline-tasks-test 
oc expose service cotd2 -n jdeenada-pipeline-tasks-prod
oc get dc cotd2 -o yaml -n jdeenada-pipeline-tasks-dev | sed 's/automatic: true/automatic: false/g' | oc replace -f -
oc get dc cotd2 -o yaml -n jdeenada-pipeline-tasks-test | sed 's/automatic: true/automatic: false/g' | oc replace -f -
oc get dc cotd2 -o yaml -n jdeenada-pipeline-tasks-prod | sed 's/automatic: true/automatic: false/g' | oc replace -f -
vim pipeline.yaml
oc create -f pipeline.yaml 
oc get bc
oc get projects
oc get bc -n jdeenada-pipeline-tasks-dev
oc project jdeenada-pipeline-tasks-dev
oc get pods
oc create -f pipeline.yaml 
oc get is
oc get is -n default
docker list images
docker images list
oc import-image docker-registry.default.svc:5000/gogs:latest --from=isolated1.$GUID.internal:5000/wkulhanek/gogs:latest --confirm --insecure=true -n openshift
docker
ssh master1.00d0.internal
oc import-image docker-registry.default.svc:5000/gogs:latest 
oc import-image docker-registry.default.svc:5000/gogs:latest --confirm
oc
oc image list
oc image -h
oc -h
oc image -h
docker
ping yahoo.com
ssh master1.00d0.internal
oc status
oc new-app eap7.0~http://gogs-jdeenada-gogs.apps.00d0.example.opentlc.com/CICDLabs/openshift-tasks.git
oc getpods
oc get pods
oc new-build jenkins~https://github.com/wkulhanek/openshift-tasks.git --name=openshift-tasks
oc logs -f bc/openshift-tasks
oc get is
oc get dc
oc get bc
oc edit bc openshift-tasks 
ssh master1.00d0.interna;
ssh master1.00d0.internal
oc getprojects
oc get projects
oc project jdeenada-nexus
oc get pods
echo "apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nexus-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi" | oc create -f -
oc delete pvc nexus-pvc
echo "apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nexus-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi" | oc create -f -
oc new-app openshift/nexus3:latest
oc rollout pause dc nexus3
oc patch dc nexus3 --patch='{ "spec": { "strategy": { "type": "Recreate" }}}'
oc set resources dc nexus3 --limits=memory=2Gi --requests=memory=1Gi
ssh master1.00d0.internal
oc new-app openshift/nexus3:latest
oc import-image docker.io/sonatype/nexus3:latest
oc import-image docker.io/gogs/gogs:latest
oc import-image docker.io/paintedfox/postgresql:latest
oc image list
oc image
oc get is
oc get is -n openshift
oc new-app openshift/nexus3:latest
ssh master1.00d0.internal
ls
wget http://admin.na.shared.opentlc.com/openshift-tasks-repository.zip
unzip -o openshift-tasks-repository.zip -d $HOME
cd $HOME/repository
cat << EOF > ./nexusimport.sh
while getopts ":r:u:p:" opt; do
  case \$opt in
    r) REPO_URL="\$OPTARG"
    ;;
    u) USERNAME="\$OPTARG"
    ;;
    p) PASSWORD="\$OPTARG"
    ;;
  esac
done

find . -type f \\
 -not -path './mavenimport\.sh*' \\
 -not -path '*/\.*' \\
 -not -path '*/\^archetype\-catalog\.xml*' \\
 -not -path '*/\^maven\-metadata\-local*\.xml' \\
 -not -path '*/\^maven\-metadata\-deployment*\.xml' | \\
 sed "s|^\./||" | \\
 xargs -t -I '{}' curl -s -S -u "\$USERNAME:\$PASSWORD" -X PUT -T {} \${REPO_URL}/{} ;
EOF

chmod +x $HOME/repository/nexusimport.sh
cd $HOME/repository
./nexusimport.sh -u admin -p admin123 -r http://$(oc get route nexus3 --template='{{ .spec.host }}' -n cicd)/repository/offline/
chmod +x $HOME/repository/nexusimport.sh
cd $HOME/repository
ls
oc get route
for image in sonatype/nexus3 wkulhanek/gogs; do   skopeo copy --dest-tls-verify=false docker://docker.io/${image}:latest docker://localhost:5000/${image}:latest; done
# from registry.access.redhat.com
for image in rhel7/etcd rhscl/postgresql-96-rhel7 jboss-eap-7/eap70-openshift; do   skopeo copy --dest-tls-verify=false docker://registry.access.redhat.com/$image:latest docker://localhost:5000/${image}:latest; done
RHT_TAG='v3.9'
LOCAL_TAG='latest'
# Latest tags point to older releases. Need to use version-specific tag::
IMAGES_MAJOR_LATEST="jenkins-2-rhel7 jenkins-slave-base-rhel7 jenkins-slave-maven-rhel7 jenkins-slave-nodejs-rhel7"
time for image in ${IMAGES_MAJOR_LATEST}; do   latest_version=`skopeo inspect --tls-verify=false docker://registry.access.redhat.com/openshift3/$image | jq ".RepoTags | map(select(startswith((\"${RHT_TAG}\")))) |.[] "| sort -V | tail -1 | tr -d '"'`;   if [[ "$latest_version" == "" ]]; then latest_version='latest';fi;   echo "Copying image: $image version: $latest_version";   skopeo copy --dest-tls-verify=false docker://registry.access.redhat.com/openshift3/${image}:${latest_version} docker://localhost:5000/openshift3/${image}:${LOCAL_TAG}; done
oc whoami
oc tag eap70-openshift:latest jboss-eap70-openshift:1.7
clear
ls
ll
cd repository/
ls
cd ..
clear
rpm -i https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum makecache
yum install -y docker-distribution skopeo jq
sed -i 's/^.*rootdirectory.*$/        rootdirectory: \/srv\/repohost\/registry/' /etc/docker-distribution/registry/config.yml
cat << EOF >> /etc/docker-distribution/registry/config.yml
log:
  accesslog:
    disabled: false
  level: info
  formatter: text
  fields:
    service: registry
    environment: staging
EOF

mkdir -p /srv/repohost/registry
systemctl enable docker-distribution
systemctl start docker-distribution
systemctl status docker-distribution
RHT_TAG=v3.9.14
LOCAL_TAG=v3.9.14
IMAGES_SAME_PATCH="ose-ansible ose-cluster-capacity ose-deployer ose-docker-builder ose-docker-registry ose-egress-http-proxy ose-egress-router ose-haproxy-router ose-pod ose-sti-builder ose container-engine efs-provisioner node openvswitch oauth-proxy logging-auth-proxy logging-curator logging-elasticsearch logging-fluentd logging-kibana metrics-cassandra metrics-hawkular-metrics metrics-heapster oauth-proxy ose ose-service-catalog prometheus-alert-buffer prometheus-alertmanager prometheus registry-console ose-web-console ose-template-service-broker ose-ansible-service-broker logging-deployer metrics-deployer ose-service-catalog mediawiki-apb postgresql-apb mariadb-apb mysql-apb"
time for image in ${IMAGES_SAME_PATCH}; do   latest_version=`skopeo inspect --tls-verify=false docker://registry.access.redhat.com/openshift3/$image | jq ".RepoTags | map(select(startswith((\"${RHT_TAG}\")))) |.[] "| sort -V | tail -1 | tr -d '"'`;   if [[ "$latest_version" == "" ]]; then latest_version='latest';fi;   echo "Copying image: $image version: $latest_version";   skopeo copy --dest-tls-verify=false docker://registry.access.redhat.com/openshift3/${image}:${latest_version} docker://localhost:5000/openshift3/${image}:${LOCAL_TAG};   echo "Copied image: $image version: $latest_version"; done
hostname
ssh master1.00d0.internal
oc get projects
oc project jdeenada-nexus
oc get pods
oc delete project jdeenada-nexus
oc new-project nexus
echo "apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nexus-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi" | oc create -f -
oc new-app openshift/nexus3:latest
oc rollout pause dc nexus3
oc patch dc nexus3 --patch='{ "spec": { "strategy": { "type": "Recreate" }}}'
oc set resources dc nexus3 --limits=memory=2Gi --requests=memory=1Gi
oc set volume dc/nexus3 --add --overwrite --name=nexus3-volume-1 --mount-path=/nexus-data/ --type persistentVolumeClaim --claim-name=nexus-pvc
oc set probe dc/nexus3 --liveness --failure-threshold 3 --initial-delay-seconds 60 -- echo ok
oc set probe dc/nexus3 --readiness --failure-threshold 3 --initial-delay-seconds 60 --get-url=http://:8081/repository/maven-public/
oc rollout resume dc nexus3
oc expose svc nexus3
oc get routes
oc get pods
watch oc get pods
oc delete project nexus
clear
oc get projects
oc get pv
oc get pvc
oc new-project cicd
echo "apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nexus-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi" | oc create -f -
oc new-app openshift/nexus3:latest
oc status
watch oc get pods
oc delete project cicd
docker image list
oc get image
oc get image |grep nexus
oc get image -h
oc get image nexus
oc get image nexus3
oc get image 
oc get image |grep nexus
oc new-project cicd
echo "apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nexus-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi" | oc create -f -
oc new-app sonatype/nexus3:latest
watch oc get pods
oc rollout pause dc nexus3
oc patch dc nexus3 --patch='{ "spec": { "strategy": { "type": "Recreate" }}}'
oc set resources dc nexus3 --limits=memory=2Gi --requests=memory=1Gi
oc set volume dc/nexus3 --add --overwrite --name=nexus3-volume-1 --mount-path=/nexus-data/ --type persistentVolumeClaim --claim-name=nexus-pvc
oc set probe dc/nexus3 --liveness --failure-threshold 3 --initial-delay-seconds 60 -- echo ok
oc set probe dc/nexus3 --readiness --failure-threshold 3 --initial-delay-seconds 60 --get-url=http://:8081/repository/maven-public/
oc rollout resume dc nexus3
oc expose svc nexus3
watch oc get pods
oc get pods
oc status -v
oc get pods
oc delete project cicd
oc get pods
oc delete project cicd
oc get pods
oc new-project cicd
echo "apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nexus-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi" | oc create -f -
oc new-app sonatype/nexus3:latest
watch oc get pods
oc expose svc nexus3
oc get routes
unzip -o openshift-tasks-repository.zip -d $HOME
cd $HOME/repository
cat << EOF > ./nexusimport.sh
while getopts ":r:u:p:" opt; do
  case \$opt in
    r) REPO_URL="\$OPTARG"
    ;;
    u) USERNAME="\$OPTARG"
    ;;
    p) PASSWORD="\$OPTARG"
    ;;
  esac
done

find . -type f \\
 -not -path './mavenimport\.sh*' \\
 -not -path '*/\.*' \\
 -not -path '*/\^archetype\-catalog\.xml*' \\
 -not -path '*/\^maven\-metadata\-local*\.xml' \\
 -not -path '*/\^maven\-metadata\-deployment*\.xml' | \\
 sed "s|^\./||" | \\
 xargs -t -I '{}' curl -s -S -u "\$USERNAME:\$PASSWORD" -X PUT -T {} \${REPO_URL}/{} ;
EOF

chmod +x $HOME/repository/nexusimport.sh
cd $HOME/repository
./nexusimport.sh -u admin -p admin123 -r http://$(oc get route nexus3 --template='{{ .spec.host }}' -n cicd)/repository/offline/
oc project cicd
oc new-app postgresql-persistent --param POSTGRESQL_DATABASE=gogs --param POSTGRESQL_USER=gogs --param POSTGRESQL_PASSWORD=gogs --param VOLUME_CAPACITY=4Gi -lapp=postgresql_gogs
oc get pods
watch oc get pods
echo 'kind: Template
apiVersion: v1
metadata:
  annotations:
    description: The Gogs git server. Requires a PostgreSQL database.
    tags: instant-app,gogs,datastore
    iconClass: icon-github
  name: gogs
objects:
- kind: Service
  apiVersion: v1
  metadata:
    annotations:
      description: The Gogs servers http port
    labels:
      app: ${APPLICATION_NAME}
    name: ${APPLICATION_NAME}
  spec:
    ports:
    - name: 3000-tcp
      port: 3000
      protocol: TCP
      targetPort: 3000
    selector:
      app: ${APPLICATION_NAME}
      deploymentconfig: ${APPLICATION_NAME}
    sessionAffinity: None
    type: ClusterIP
- kind: Route
  apiVersion: v1
  id: ${APPLICATION_NAME}-http
  metadata:
    annotations:
      description: Route for applications http service.
    labels:
      app: ${APPLICATION_NAME}
    name: ${APPLICATION_NAME}
  spec:
    host: ${GOGS_ROUTE}
    to:
      name: ${APPLICATION_NAME}
- kind: DeploymentConfig
  apiVersion: v1
  metadata:
    labels:
      app: ${APPLICATION_NAME}
    name: ${APPLICATION_NAME}
  spec:
    replicas: 1
    selector:
      app: ${APPLICATION_NAME}
      deploymentconfig: ${APPLICATION_NAME}
    strategy:
      rollingParams:
        intervalSeconds: 1
        maxSurge: 25%
        maxUnavailable: 25%
        timeoutSeconds: 600
        updatePeriodSeconds: 1
      type: Rolling
    template:
      metadata:
        labels:
          app: ${APPLICATION_NAME}
          deploymentconfig: ${APPLICATION_NAME}
      spec:
        containers:
        - image: \"\"
          imagePullPolicy: Always
          name: ${APPLICATION_NAME}
          ports:
          - containerPort: 3000
            protocol: TCP
          resources: {}
          terminationMessagePath: /dev/termination-log
          volumeMounts:
          - name: gogs-data
            mountPath: /data
          - name: gogs-config
            mountPath: /opt/gogs/custom/conf
          readinessProbe:
              httpGet:
                path: /
                port: 3000
                scheme: HTTP
              initialDelaySeconds: 3
              timeoutSeconds: 1
              periodSeconds: 20
              successThreshold: 1
              failureThreshold: 3
          livenessProbe:
              httpGet:
                path: /
                port: 3000
                scheme: HTTP
              initialDelaySeconds: 3
              timeoutSeconds: 1
              periodSeconds: 10
              successThreshold: 1
              failureThreshold: 3
        dnsPolicy: ClusterFirst
        restartPolicy: Always
        terminationGracePeriodSeconds: 30
        volumes:
        - name: gogs-data
          persistentVolumeClaim:
            claimName: gogs-data
        - name: gogs-config
          configMap:
            name: gogs-config
            items:
              - key: app.ini
                path: app.ini
    test: false
    triggers:
    - type: ConfigChange
    - imageChangeParams:
        automatic: true
        containerNames:
        - ${APPLICATION_NAME}
        from:
          kind: ImageStreamTag
          name: ${GOGS_IMAGE}
          namespace: openshift
      type: ImageChange
- kind: PersistentVolumeClaim
  apiVersion: v1
  metadata:
    name: gogs-data
  spec:
    accessModes:
      - ReadWriteOnce
    resources:
      requests:
        storage: ${GOGS_VOLUME_CAPACITY}
- kind: ConfigMap
  apiVersion: v1
  metadata:
    name: gogs-config
  data:
    app.ini: |
      APP_NAME = Gogs
      RUN_MODE = prod
      RUN_USER = gogs

      [database]
      DB_TYPE  = postgres
      HOST     = postgresql:5432
      NAME     = ${DATABASE_NAME}
      USER     = ${DATABASE_USER}
      PASSWD   = ${DATABASE_PASSWORD}
      SSL_MODE = disable

      [repository]
      ROOT = /data/repositories

      [server]
      ROOT_URL=http://${GOGS_ROUTE}

      [security]
      INSTALL_LOCK = true

      [mailer]
      ENABLED = false

      [service]
      ENABLE_CAPTCHA = false
      REGISTER_EMAIL_CONFIRM = false
      ENABLE_NOTIFY_MAIL     = false
      DISABLE_REGISTRATION   = false
      REQUIRE_SIGNIN_VIEW    = false

      [picture]
      DISABLE_GRAVATAR        = false
      ENABLE_FEDERATED_AVATAR = true

      [webhook]
      SKIP_TLS_VERIFY = true
parameters:
- name: APPLICATION_NAME
  description: The name for the application.
  required: true
  value: gogs
- name: GOGS_ROUTE
  description: The route for the Gogs Application
  required: true
- name: GOGS_VOLUME_CAPACITY
  description: Volume space available for data, e.g. 512Mi, 2Gi
  required: true
  value: 4Gi
- name: DATABASE_USER
  displayName: Database Username
  required: true
  value: gogs
- name: DATABASE_PASSWORD
  displayName: Database Password
  required: true
  value: gogs
- name: DATABASE_NAME
  displayName: Database Name
  required: true
  value: gogs
- name: GOGS_IMAGE
  displayName: Gogs Image and tag
  required: true
  value: gogs:latest' > $HOME/gogs.yaml
oc get routes
oc process -f $HOME/gogs.yaml --param GOGS_ROUTE=gogs-cicd.apps.$GUID.example.opentlc.com|oc create -f -
oc process -f $HOME/gogs.yaml --param GOGS_ROUTE=gogs-cicd.apps.00d0.example.opentlc.com|oc create -f -
oc get routes
oc get pods
oc delete label=gogs
oc delete --all label=gogs
oc delete --all 
oc delete --all gogs
oc delete all -l gogs
oc get pods
oc get dc
oc describe dc gogs
clear
oc delete bc gogs
oc get bc
oc delete dc gogs
oc delete rc gogs
oc delete pods gogs
oc get pods
oc get routes
oc delete routes gogs
oc get pv
oc get pvc
oc delete pvc gogs-data 
echo $APPLICATION_NAME
ls
cd
ls
vim gogs.yaml 
oc process -f $HOME/gogs.yaml --param GOGS_ROUTE=gogs-cicd.apps.00d0.example.opentlc.com|oc create -f -
oc delete svc gogs
oc delete cm gogs
oc delete route gogs
oc delete pvc gogs
oc delete pvc gogs-data 
vim gogs.yaml 
oc process -f $HOME/gogs.yaml --param GOGS_ROUTE=gogs-cicd.apps.00d0.example.opentlc.com|oc create -f -
oc get is
oc get is -n openshift
vim gogs.yaml 
oc process -f $HOME/gogs.yaml --param GOGS_ROUTE=gogs-cicd.apps.00d0.example.opentlc.com|oc create -f -
vim gogs.yaml 
oc process -f $HOME/gogs.yaml --param GOGS_ROUTE=gogs-cicd.apps.00d0.example.opentlc.com|oc create -f -
vim gogs.yaml 
oc process -f $HOME/gogs.yaml --param GOGS_ROUTE=gogs-cicd.apps.00d0.example.opentlc.com|oc create -f -
vim gogs.yaml 
oc process -f $HOME/gogs.yaml --param GOGS_ROUTE=gogs-cicd.apps.00d0.example.opentlc.com|oc create -f -
vim gogs.yaml 
oc process -f $HOME/gogs.yaml --param GOGS_ROUTE=gogs-cicd.apps.00d0.example.opentlc.com|oc create -f -
echo 'kind: Template
apiVersion: v1
metadata:
  annotations:
    description: The Gogs git server. Requires a PostgreSQL database.
    tags: instant-app,gogs,datastore
    iconClass: icon-github
  name: gogs
objects:
- kind: Service
  apiVersion: v1
  metadata:
    annotations:
      description: The Gogs servers http port
    labels:
      app: ${APPLICATION_NAME}
    name: ${APPLICATION_NAME}
  spec:
    ports:
    - name: 3000-tcp
      port: 3000
      protocol: TCP
      targetPort: 3000
    selector:
      app: ${APPLICATION_NAME}
      deploymentconfig: ${APPLICATION_NAME}
    sessionAffinity: None
    type: ClusterIP
- kind: Route
  apiVersion: v1
  id: ${APPLICATION_NAME}-http
  metadata:
    annotations:
      description: Route for applications http service.
    labels:
      app: ${APPLICATION_NAME}
    name: ${APPLICATION_NAME}
  spec:
    host: ${GOGS_ROUTE}
    to:
      name: ${APPLICATION_NAME}
- kind: DeploymentConfig
  apiVersion: v1
  metadata:
    labels:
      app: ${APPLICATION_NAME}
    name: ${APPLICATION_NAME}
  spec:
    replicas: 1
    selector:
      app: ${APPLICATION_NAME}
      deploymentconfig: ${APPLICATION_NAME}
    strategy:
      rollingParams:
        intervalSeconds: 1
        maxSurge: 25%
        maxUnavailable: 25%
        timeoutSeconds: 600
        updatePeriodSeconds: 1
      type: Rolling
    template:
      metadata:
        labels:
          app: ${APPLICATION_NAME}
          deploymentconfig: ${APPLICATION_NAME}
      spec:
        containers:
        - image: \"\"
          imagePullPolicy: Always
          name: ${APPLICATION_NAME}
          ports:
          - containerPort: 3000
            protocol: TCP
          resources: {}
          terminationMessagePath: /dev/termination-log
          volumeMounts:
          - name: gogs-data
            mountPath: /data
          - name: gogs-config
            mountPath: /opt/gogs/custom/conf
          readinessProbe:
              httpGet:
                path: /
                port: 3000
                scheme: HTTP
              initialDelaySeconds: 3
              timeoutSeconds: 1
              periodSeconds: 20
              successThreshold: 1
              failureThreshold: 3
          livenessProbe:
              httpGet:
                path: /
                port: 3000
                scheme: HTTP
              initialDelaySeconds: 3
              timeoutSeconds: 1
              periodSeconds: 10
              successThreshold: 1
              failureThreshold: 3
        dnsPolicy: ClusterFirst
        restartPolicy: Always
        terminationGracePeriodSeconds: 30
        volumes:
        - name: gogs-data
          persistentVolumeClaim:
            claimName: gogs-data
        - name: gogs-config
          configMap:
            name: gogs-config
            items:
              - key: app.ini
                path: app.ini
    test: false
    triggers:
    - type: ConfigChange
    - imageChangeParams:
        automatic: true
        containerNames:
        - ${APPLICATION_NAME}
        from:
          kind: ImageStreamTag
          name: ${GOGS_IMAGE}
          namespace: openshift
      type: ImageChange
- kind: PersistentVolumeClaim
  apiVersion: v1
  metadata:
    name: gogs-data
  spec:
    accessModes:
      - ReadWriteOnce
    resources:
      requests:
        storage: ${GOGS_VOLUME_CAPACITY}
- kind: ConfigMap
  apiVersion: v1
  metadata:
    name: gogs-config
  data:
    app.ini: |
      APP_NAME = Gogs
      RUN_MODE = prod
      RUN_USER = gogs

      [database]
      DB_TYPE  = postgres
      HOST     = postgresql:5432
      NAME     = ${DATABASE_NAME}
      USER     = ${DATABASE_USER}
      PASSWD   = ${DATABASE_PASSWORD}
      SSL_MODE = disable

      [repository]
      ROOT = /data/repositories

      [server]
      ROOT_URL=http://${GOGS_ROUTE}

      [security]
      INSTALL_LOCK = true

      [mailer]
      ENABLED = false

      [service]
      ENABLE_CAPTCHA = false
      REGISTER_EMAIL_CONFIRM = false
      ENABLE_NOTIFY_MAIL     = false
      DISABLE_REGISTRATION   = false
      REQUIRE_SIGNIN_VIEW    = false

      [picture]
      DISABLE_GRAVATAR        = false
      ENABLE_FEDERATED_AVATAR = true

      [webhook]
      SKIP_TLS_VERIFY = true
parameters:
- name: APPLICATION_NAME
  description: The name for the application.
  required: true
  value: gogs
- name: GOGS_ROUTE
  description: The route for the Gogs Application
  required: true
- name: GOGS_VOLUME_CAPACITY
  description: Volume space available for data, e.g. 512Mi, 2Gi
  required: true
  value: 4Gi
- name: DATABASE_USER
  displayName: Database Username
  required: true
  value: gogs
- name: DATABASE_PASSWORD
  displayName: Database Password
  required: true
  value: gogs
- name: DATABASE_NAME
  displayName: Database Name
  required: true
  value: gogs
- name: GOGS_IMAGE
  displayName: Gogs Image and tag
  required: true
  value: gogs:latest' > $HOME/gogs.yaml
oc process -f $HOME/gogs.yaml --param GOGS_ROUTE=gogs-cicd.apps.00d0.example.opentlc.com|oc create -f -
oc get pods
watch oc get pods
oc delete dc gogs
vi repository/nexusimport.sh 
oc new-app wkulhanek/gogs:11.34 -lapp=gogs
oc get pods
oc delete dc gogs
oc delete svc gogs
oc delete route gogs
oc delete rc gogs
oc delete pvc gogs-data 
oc new-app wkulhanek/gogs:11.34 -lapp=gogs
watch oc get gogs
watch oc get pods
echo "apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: gogs-data
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 4Gi" | oc create -f -
oc get routes
oc expose gogs
oc expose svc gogs
oc get routes
vi gogs.yaml 
git clone https://github.com/wkulhanek/openshift-tasks.git
ls
rm -rf openshift-tasks
git clone https://github.com/wkulhanek/openshift-tasks.git
cd $HOME/openshift-tasks
git remote add gogs http://gogs-cicd.apps.00d0.example.opentlc.com/CICDLabs/openshift-tasks.git
git push -u gogs master
oc get projects
oc project jdeenada-pipeline-tasks-dev
oc new-app eap70-basic-s2i --param MAVEN_MIRROR_URL=http://nexus3.cicd.svc.cluster.local:8081/repository/offline --param SOURCE_REPOSITORY_URL=http://gogs.cicd.svc.cluster.local:3000/CICDLabs/openshift-tasks --param SOURCE_REPOSITORY_REF=master --param CONTEXT_DIR= --param APPLICATION_NAME=tasks
oc get pods
oc get bc
oc delete bc tasks 
oc get dc
oc delete dc tasks
oc get svc
oc delete svc tasks
oc delete svc tasks-ping 
oc get routes
oc delete route tasks
oc get rc
clear
oc new-app eap70-basic-s2i --param MAVEN_MIRROR_URL=http://nexus3.cicd.svc.cluster.local:8081/repository/offline --param SOURCE_REPOSITORY_URL=http://gogs.cicd.svc.cluster.local:3000/CICDLabs/openshift-tasks --param SOURCE_REPOSITORY_REF=master --param CONTEXT_DIR= --param APPLICATION_NAME=tasks
oc get pods
oc delete bc tasks 
oc delete dc tasks 
oc delete svc tasks 
oc delete route tasks 
oc get is
oc delete is tasks
oc new-app eap70-basic-s2i --param MAVEN_MIRROR_URL=http://nexus3.cicd.svc.cluster.local:8081/repository/offline --param SOURCE_REPOSITORY_URL=http://gogs.cicd.svc.cluster.local:3000/CICDLabs/openshift-tasks --param SOURCE_REPOSITORY_REF=master --param CONTEXT_DIR= --param APPLICATION_NAME=tasks
oc delete bc tasks 
oc delete dc tasks 
oc delete is tasks
oc delete svc tasks 
oc delete route tasks 
oc delete svc tasks-ping 
oc new-app eap70-basic-s2i --param MAVEN_MIRROR_URL=http://nexus3.cicd.svc.cluster.local:8081/repository/offline --param SOURCE_REPOSITORY_URL=http://gogs.cicd.svc.cluster.local:3000/CICDLabs/openshift-tasks --param SOURCE_REPOSITORY_REF=master --param CONTEXT_DIR= --param APPLICATION_NAME=tasks
watch oc get pods
oc logs -f tasks-1-build
docker image list
history
oc delete bc tasks 
delete dc tasks 
oc delete is tasks
oc delete svc tasks 
oc delete route tasks 
oc delete svc tasks-ping 
oc status
oc new-app registry.access.redhat.com/jboss-eap-7/eap70-openshift --param MAVEN_MIRROR_URL=http://nexus3.cicd.svc.cluster.local:8081/repository/offline --param SOURCE_REPOSITORY_URL=http://gogs.cicd.svc.cluster.local:3000/CICDLabs/openshift-tasks --param SOURCE_REPOSITORY_REF=master --param CONTEXT_DIR= --param APPLICATION_NAME=tasks
watch oc get pods
oc expose svc/eap70-openshift
oc get routes
cd
oc get pods
oc get bc
oc delete pod eap70-openshift-1-gh6kk
oc new-app eap70-basic-s2i --param MAVEN_MIRROR_URL=http://nexus3.cicd.svc.cluster.local:8081/repository/offline --param SOURCE_REPOSITORY_URL=http://gogs.cicd.svc.cluster.local:3000/CICDLabs/openshift-tasks --param SOURCE_REPOSITORY_REF=master --param CONTEXT_DIR= --param APPLICATION_NAME=tasks
oc delete bc tasks 
delete dc tasks 
oc delete is tasks
oc delete svc tasks 
oc delete route tasks 
oc delete svc tasks-ping
oc new-app eap70-basic-s2i --param MAVEN_MIRROR_URL=http://nexus3.cicd.svc.cluster.local:8081/repository/offline --param SOURCE_REPOSITORY_URL=http://gogs.cicd.svc.cluster.local:3000/CICDLabs/openshift-tasks --param SOURCE_REPOSITORY_REF=master --param CONTEXT_DIR= --param APPLICATION_NAME=tasks
oc delete bc tasks 
delete dc tasks 
oc delete is tasks
oc delete svc tasks 
oc delete route tasks 
oc delete svc tasks-ping
oc get dc
oc delete dc
oc delete dc tasks 
oc get pods
oc delete pod openshift-tasks-1-build
oc get pods
oc new-app eap70-basic-s2i --param MAVEN_MIRROR_URL=http://nexus3.cicd.svc.cluster.local:8081/repository/offline --param SOURCE_REPOSITORY_URL=http://gogs.cicd.svc.cluster.local:3000/CICDLabs/openshift-tasks --param SOURCE_REPOSITORY_REF=master --param CONTEXT_DIR= --param APPLICATION_NAME=tasks
oc logs -f bc/tasks
oc get bc
oc edit bc tasks 
docker
oc image list
oc get image
oc get image |grep openshift
oc edit bc tasks 
oc get image |grep eap70-openshift
oc edit bc tasks 
oc logs -f bc/tasks
oc get dc
oc get pods
oc delete pod tasks-1-build
oc get pods
oc new-app eap70-basic-s2i --param MAVEN_MIRROR_URL=http://nexus3.cicd.svc.cluster.local:8081/repository/offline --param SOURCE_REPOSITORY_URL=http://gogs.cicd.svc.cluster.local:3000/CICDLabs/openshift-tasks --param SOURCE_REPOSITORY_REF=master --param CONTEXT_DIR= --param APPLICATION_NAME=tasks
oc get pods
oc get dc
oc edit dc tasks 
oc get bc
oc start-build tasks 
oc get pods
oc logs -f bc/tasks
oc logs -f bc/tasks-2
oc edit bc tasks
oc start-build tasks 
oc logs -f bc/tasks
oc import-image bastion.00d0.example.opentlc.com:5000/jboss-eap-7/eap70-openshift@sha256:a6b7475638629f354a3e845c41db1e80764a688df90febf7d1f906dcb204cf68
oc import-image eap70-openshift:latest
RHT_TAG='latest'
LOCAL_TAG='v3.9.14'
IMAGES_LATEST_TO_PATCH="ose-recycler prometheus-node-exporter"
time for image in ${IMAGES_LATEST_TO_PATCH}; do   latest_version=`skopeo inspect --tls-verify=false docker://registry.access.redhat.com/openshift3/$image | jq ".RepoTags | map(select(startswith((\"${RHT_TAG}\")))) |.[] "| sort -V | tail -1 | tr -d '"'`;   if [[ "$latest_version" == "" ]]; then latest_version='latest';fi;   echo "Copying image: $image version: $latest_version";   skopeo copy --dest-tls-verify=false docker://registry.access.redhat.com/openshift3/${image}:${latest_version} docker://localhost:5000/openshift3/${image}:${LOCAL_TAG} & done
ssh master1.00d0.internal
oc get nodes
oc get bc
oc get is
oc tag openshift-tasks:latest openshift-tasks:testready -n jdeenada-pipeline-tasks-dev
oc tag openshift-tasks:testready openshift-tasks:prodready -n jdeenada-pipeline-tasks-dev
oc get is
oc status
oc new-app jdeenada-pipeline-tasks-dev/openshift-tasks:testready --name=openshift-tasks -n jdeenada-pipeline-tasks-test
oc get pods
oc project jdeenada-pipeline-tasks-test
oc get pods
oc get svc
oc expose svc openshift-tasks
oc get routes
oc new-app jdeenada-pipeline-tasks-dev/openshift-tasks:testready --name=openshift-tasks -n jdeenada-pipeline-tasks-prod
oc project jdeenada-pipeline-tasks-prod
oc get pods
oc expose svc openshift-tasks
oc get routes
oc project jdeenada-pipeline-tasks-dev
oc get pods
oc delete pods openshift-tasks-3-build
oc delete pods openshift-tasks-2-build
oc delete pods openshift-tasks-1-build
history
oc get is
oc new-app openshift-tasks
oc new-app openshift-tasks:latest
oc get svc
oc delete svc openshift-tasks 
oc delete route openshift-tasks 
oc get bc
oc delete openshift-tasks
oc delete bc openshift-tasks
ls
clear
oc new-app openshift-tasks:latest
watch oc get pods
oc expose svc openshift-tasks 
oc get bc
oc start-build openshift-tasks
oc status
oc new-app openshift-tasks:latest
oc delete svc openshift-tasks 
oc delete route openshift-tasks 
ic get i
ic get is
oc get is
oc new-app openshift-tasks:latest
oc get pods
oc expose svc/openshift-tasks
oc get projects
oc project jdeenada-pipeline-tasks-test
oc get pods
oc get svc
oc delete svc openshift-tasks 
oc delete route openshift-tasks 
oc new-app  openshift-tasks:latest
oc new-app jdeenada-pipeline-tasks-test/openshift-tasks:testready
oc expose svc/openshift-tasks
oc project jdeenada-pipeline-tasks-prod
oc delete svc openshift-tasks 
oc delete route openshift-tasks
oc new-app jdeenada-pipeline-tasks-test/openshift-tasks:prodready
oc new-app jdeenada-pipeline-tasks-test/openshift-tasks:testready
oc expose svc/openshift-tasks
