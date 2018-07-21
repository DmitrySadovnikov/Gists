curl -sSL https://goo.gl/6wtTN5 | bash -s 1.1.0

docker tag hyperledger/fabric-tools:x86_64–1.0.2 hyperledger/fabric-tools:latest
cd first-network
./byfn.sh -m generate
./byfn.sh -m up
./byfn.sh -m down
