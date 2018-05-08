# Consul Example Deployment 

This repo deploys two Consul datacenters.  It deploys both the servers, and the clients.  The clients contain mongodb, redis, and nginx to give you different service targets if desired.

## Usage

An existing GCP project and credentials file is required.  You will need to update those values into the packer/build.sh file first.  Then execute the build.sh file to create the machine images we will later deploy.

Additionally, this assumes you are uploading a Consul executable (such as the Enterprise version).  Puppet can download the OSS version for you if you desire, but you would need to change the code.

```
cd packer
mkdir binaries && $PUT_CONSUL_BIN_HERE
./build.sh ~/.gcloud/default-ehron-env.json ehron-env us-east1-c
```

Next change directory into the root of the project, and then use Terraform to deploy the environment.  You'll need to update the env.sh file to contain your earlier referenced project and credntials file.

```
cd ..
terraform plan
terraform apply
```

Finally, cd into the Consul directory, and run Terraform again to create the prepared queries if desired.

```
cd consul

# update the server address values using the outputs from the previous steps
terraform plan
terraform apply
```

After the environment is created you can ssh to the hosts, and lookup services:
```
# Using a service lookup
deploy@client-east-cache-1:~$ dig @127.0.0.1 -p 8600 db.query.consul
...
# Using a prepared query
deploy@client-east-cache-1:~$ dig @127.0.0.1 -p 8600 db.query.consul
```

You can stop services, and reissue the queries if you like.
