# Cryptography_Sixth
Custom Blockchain implementation for Cryptography Assignment

## TO-DO

- [ ] - implement your custom blockchain (it's messages can be about anything)
- [ ] - implement simple frontend for it
- [ ] - implement API to do transactions, download status of your wallet, chain status, number of blocks in chain etc.

### Additional TO-DO's

- [ ] - create custom graphic for it

### How to run: 

```
docker build -t coffee-coin-image .

# simply run the container instance & bind the port
docker run --name vapor-server -p 8080:8080 coffee-coin-image

# run the instance, bind the port, see logs remove after exit (CTRL+C)
docker run --rm -p 8080:8080 -it coffee-coin-image

```
