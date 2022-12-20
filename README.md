# jenkins_agent_maven

Build
```bash
 docker build -t java_agent .
```

generate key pair
```bash
 ssh-keygen
```

Reference in jenkins cloud definition
new agent
agent environment
JENKINS_AGENT_SSH_PUBKEY= public generate key

Remote File System Root
/home/jenkins

Connect with ssh : use private key

remove volume : build locally

Never pull

Node properties
environment variables
- MAVEN_MIRROR_REPOSITORY
- MAVEN_RELEASES_REPOSITORY
- MAVEN_SNAPSHOTS_REPOSITORY
