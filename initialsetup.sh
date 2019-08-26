# Delete S3 Bucket if it exists
aws --profile se s3 rm --recursive s3://pankaj.setup.solace.com
aws --profile se s3 rb s3://pankaj.setup.solace.com

# Create S3 Bucket
aws --profile se s3 mb s3://pankaj.setup.solace.com
# Populate S3 Bucket
aws --profile se s3 cp awslogs.conf s3://pankaj.setup.solace.com/
aws --profile se s3 cp modules/vpc.yaml s3://pankaj.setup.solace.com
aws --profile se s3 cp modules/security-groups.yaml s3://pankaj.setup.solace.com
aws --profile se s3 cp modules/ecs-cluster.yaml s3://pankaj.setup.solace.com

###


# Create Cloud Formation
aws --profile se cloudformation create-stack --template-body file://master.yaml --stack-name dev --tags Key=Owner,Value=Pankaj.Arora



aws --profile se s3 cp infrastructure/security-groups.yaml s3://pankaj.setup.solace.com
aws --profile se s3 cp infrastructure/load-balancers.yaml s3://pankaj.setup.solace.com
aws --profile se s3 cp infrastructure/ecs-cluster.yaml s3://pankaj.setup.solace.com
aws --profile se s3 cp infrastructure/lifecyclehook.yaml s3://pankaj.setup.solace.com



aws --profile se cloudformation create-stack --template-body file://master.yaml --stack-name pankaj-cf1 --tags Key=Owner,Value=Pankaj.Arora

aws --profile se cloudformation delete-stack --stack-name pankaj-cf3
aws --profile se cloudformation create-stack --stack-name pankaj-cf3 --tags Key=Owner,Value=Pankaj.Arora  --template-body file://ecstest.yml --parameters ParameterKey=KeyName,ParameterValue=parora_ap_se


aws ec2 attach-volume --volume-id vol-1234abcd --instance-id $INSTANCE_ID --device /dev/xvdf


aws ec2 describe-volumes --volume-ids vol-09dd6dd707bd2e6b8 --query 'Volumes[0].State'


cluster=pankaj-ecs-cluster
region=ap-southeast-1
aws logs put-retention-policy --region $region --log-group-name $cluster/jail/logs/system.log --retention-in-days 7
aws logs put-retention-policy --region $region --log-group-name $cluster/jail/logs/command.log --retention-in-days 1
aws logs put-retention-policy --region $region --log-group-name $cluster/jail/logs/debug.log --retention-in-days 1
aws logs put-retention-policy --region $region --log-group-name $cluster/jail/logs/event.log --retention-in-days 1
aws logs put-retention-policy --region $region --log-group-name $cluster/var/log/dmesg --retention-in-days 1
aws logs put-retention-policy --region $region --log-group-name $cluster/var/log/ecs/ecs-agent.log --retention-in-days 1
aws logs put-retention-policy --region $region --log-group-name $cluster/var/log/ecs/ecs-init.log --retention-in-days 1
aws logs put-retention-policy --region $region --log-group-name $cluster/var/log/messages --retention-in-days 1
aws logs put-retention-policy --region $region --log-group-name $cluster/var/log/user-data.log --retention-in-days 1


#############
# Install Python3
sudo yum install -y python37 awscli
# Install aws-cli
#pip3 install --upgrade --user awscli
###########
VOL_ID='vol-09dd6dd707bd2e6b8'
VOL_STATUS=''
DEVICE=/dev/xvdh
INST_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
export AWS_DEFAULT_REGION=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/[a-z]$//')
aws ec2 attach-volume --volume-id $VOL_ID --instance-id $INST_ID --device /dev/sdh
until [ "x$VOL_STATUS" == "xattached" ]; do
    sleep 5
    VOL_STATUS=$(aws ec2 describe-volumes --volume-ids $VOL_ID --query 'Volumes[0].Attachments[0].State' --output text)
    echo $VOL_STATUS
done
FILES=$(sudo file -b -s $DEVICE)
if [ "$FILES" == 'data' ]
then
    echo Raw device. Creating filesystem...
    sudo mkfs -t ext4 $DEVICE
else 
    echo Existing Filesystem
fi
sudo mkdir /data
UUID=$(sudo blkid -s UUID -o value /dev/xvdh)
echo UUID=$UUID /data   ext4    defaults,nofail 0   2 | sudo tee -a /etc/fstab
sudo mount -a





###
Task definiiton

    "memory": null,


####################
WORKING LOG

[ec2-user@ip-10-0-1-156 ~]$ docker logs 03622f4dd9fc
Host Boot ID: dc2f8552-6e19-4f23-a5d6-7352c059ed66
Starting VMR Docker Container: Sat Aug 24 17:41:10 UTC 2019
SolOS Version: soltr_9.2.0.14
2019-08-24T17:42:18.227+00:00 <syslog.info> ip-10-0-1-156 rsyslogd:  [origin software="rsyslogd" swVersion="8.1905.0" x-pid="303" x-info="https://www.rsyslog.com"] start
2019-08-24T17:42:19.226+00:00 <local6.info> ip-10-0-1-156 root[301]: rsyslog startup
2019-08-24T17:42:20.236+00:00 <local0.info> ip-10-0-1-156 root: EXTERN_SCRIPT  INFO: Log redirection enabled, beginning playback of startup log buffer
2019-08-24T17:42:20.242+00:00 <local0.info> ip-10-0-1-156 root: EXTERN_SCRIPT  INFO: Container user 'appuser' is now in 'root' groups
2019-08-24T17:42:20.247+00:00 <local0.info> ip-10-0-1-156 root: EXTERN_SCRIPT  INFO: /usr/sw/var/soltr_9.2.0.14/db/dbBaseline does not exist, generating from confd template
2019-08-24T17:42:20.256+00:00 <local0.info> ip-10-0-1-156 root: EXTERN_SCRIPT  INFO: repairDatabase.py: no database to process
2019-08-24T17:42:20.262+00:00 <local0.info> ip-10-0-1-156 root: EXTERN_SCRIPT  INFO: Finished playback of log buffer
2019-08-24T17:42:20.893+00:00 <local0.warning> ip-10-0-1-156 root[336]: /usr/sw                        ipcCommon.cpp:430                     (BASE_IPC     - 0x00000000) main(0)@solevent(?)                           WARN     SolOS is not currently up - aborting attempt to start solevent process
2019-08-24T17:42:20.896+00:00 <local0.warning> ip-10-0-1-156 pam_event[335]: WARN Failed raising event, rc: 2, event SYSTEM_AUTHENTICATION_SESSION_OPENED shell(sudo),<335>,internal,root,root
2019-08-24T17:42:21.516+00:00 <local0.warning> ip-10-0-1-156 root[338]: /usr/sw                        ipcCommon.cpp:430                     (BASE_IPC     - 0x00000000) main(0)@solevent(?)                           WARN     SolOS is not currently up - aborting attempt to start solevent process
2019-08-24T17:42:21.519+00:00 <local0.warning> ip-10-0-1-156 pam_event[335]: WARN Failed raising event, rc: 2, event SYSTEM_AUTHENTICATION_SESSION_CLOSED shell(sudo),<335>,root,root
2019-08-24T17:42:21.526+00:00 <local0.info> ip-10-0-1-156 root: EXTERN_SCRIPT  INFO: Updating dbBaseline with dynamic instance metadata
2019-08-24T17:42:21.682+00:00 <local0.info> ip-10-0-1-156 root: EXTERN_SCRIPT  INFO: Mirroring host timezone
2019-08-24T17:42:21.688+00:00 <local0.info> ip-10-0-1-156 root: EXTERN_SCRIPT  INFO: Generating SSH key
ssh-keygen: generating new host keys: RSA1 RSA DSA ECDSA ED25519
2019-08-24T17:42:22.445+00:00 <local0.info> ip-10-0-1-156 root: EXTERN_SCRIPT  INFO: Starting solace process
2019-08-24T17:42:23.485+00:00 <local0.info> ip-10-0-1-156 root: EXTERN_SCRIPT  INFO: Launching solacedaemon: /usr/sw/loads/soltr_9.2.0.14/bin/solacedaemon --vmr -z -f /usr/sw/loads/soltr_9.2.0.14/SolaceStartup.txt -r -1
2019-08-24T17:42:24.114+00:00 <local0.warning> ip-10-0-1-156 root[1]: /usr/sw                        main.cpp:3803                         (SOLDAEMON    - 0x00000000) main(0)@solacedaemon                          WARN     VMR Evaluation Edition 90 days remaining
2019-08-24T17:42:27.455+00:00 <local0.info> ip-10-0-1-156 root[403]: /usr/sw/loads/soltr_9.2.0.14/scripts/commonLogging.py:76    WARN   POST Violation [023]:Recommended system resource missing, System CPUs do not support invariant TSC (nonstop_tsc)
2019-08-24T17:42:32.524+00:00 <local0.warning> ip-10-0-1-156 root[1]: /usr/sw                        main.cpp:739                          (SOLDAEMON    - 0x00000000) main(0)@solacedaemon                          WARN     Determining platform type: [  OK  ]
2019-08-24T17:42:32.553+00:00 <local0.warning> ip-10-0-1-156 root[1]: /usr/sw                        main.cpp:739                          (SOLDAEMON    - 0x00000000) main(0)@solacedaemon                          WARN     Generating license file: [  OK  ]
2019-08-24T17:42:32.556+00:00 <local0.warning> ip-10-0-1-156 root[1]: /usr/sw                        main.cpp:739                          (SOLDAEMON    - 0x00000000) main(0)@solacedaemon                          WARN     Running pre-startup checks: [  OK  ]
