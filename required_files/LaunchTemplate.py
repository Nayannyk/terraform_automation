import boto3

# setting up ec2 client
ec2 = boto3.client('ec2')

# specifying ec2 configuration/details
image_id ='ami-0a94a1259c5779e00'
instance_type ='t2.micro'
keypair_name = '1807'
security_group = 'sg-00819d0f54bdfecc5'
subnet_id ='subnet-0567f932e0b86c116'

# launching instance
response = ec2.run_instances(
    ImageId=image_id,
    InstanceType=instance_type,
    KeyName=keypair_name,
    SecurityGroupIds=[security_group],
    SubnetId=subnet_id,
    MaxCount=1,
    MinCount=1
)

instance_id = response['Instances'][0]['InstanceId']

# wait until instance is running
ec2.get_waiter('instance_running').wait(InstanceIds=[instance_id])

# get instance details
desc = ec2.describe_instances(InstanceIds=[instance_id])
instance = desc['Reservations'][0]['Instances'][0]

print(f"Instance ID: {instance_id}")
print(f"Public IP address: {instance.get('PublicIpAddress', 'N/A')}")
print(f"Private IP address: {instance.get('PrivateIpAddress', 'N/A')}")
print(f'ssh -i "{keypair_name}.pem" ec2-user@{instance.get("PublicDnsName", "N/A")}')
