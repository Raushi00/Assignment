import boto3
ec2_client = boto3.client('ec2')

auto_scaling_group_name = 'test-asg'

def get_cpu_utilization(instance_id):
    response = ec2_client.describe_instances(InstanceIds=[instance_id])
    cpu_utilization = response['Reservations'][0]['Instances'][0]['Monitoring']['CPUUtilization']
    return cpu_utilization

def scale_instances():
    instances = ec2_client.describe_auto_scaling_groups(AutoScalingGroupNames=[auto_scaling_group_name])['AutoScalingGroups'][0]['Instances']
    for instance in instances:
        instance_id = instance['InstanceId']
        cpu_utilization = get_cpu_utilization(instance_id)
        if cpu_utilization > 70: 
            ec2_client.set_desired_capacity(
                AutoScalingGroupName=auto_scaling_group_name,
                DesiredCapacity=1  # Increase instance count by 1
            )
        elif cpu_utilization < 30:  
            ec2_client.set_desired_capacity(
                AutoScalingGroupName=auto_scaling_group_name,
                DesiredCapacity=-1  
            )

scale_instances()
