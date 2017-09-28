# els-haproxy

A proxy server based on [haproxy](https://cbonte.github.io/haproxy-dconv/)
which allows the use of
[Elastic Apps](https://docs.elasticlicensing.com/basics/glossary/#elastic-app)
on machines or VMs which are isolated from the public internet.

For security reasons, many environments do not allow internet access for
machines running software which processes sensitive information.

Elastic Apps need occasional access to the
[Elastic Licensing Service](https://docs.elasticlicensing.com/basics/glossary/#elastic-licensing-service)
- an internet-based API.

`els-haproxy` allows the use of Elastic Apps in such environments.

## Prerequisites

To get started, you will need to configure a machine or VM to act as a proxy
server, and which:

* is not running any service on port 80 or 443
* can be accessed across your intranet from the machines running Elastic Apps.
* has a firewall which permits https (TLS, port 443) traffic to
`api.elasticlicensing.com`.
* permits access to [hub.docker.com](https://hub.docker.com/) - at least during
configuration
* has [docker](https://docs.docker.com/) installed.

We recommend a linux machine; the script provided assumes use of a linux
server.

We recommend that you use a VM and monitor the memory, network and CPU usage
to ensure that the machine is powerful enough to handle the load. There are many
alternative configurations which are beyond the scope of this guide.

## Server Configuration

File `config/haproxy.cfg` configures haproxy. This will work without change, but
depending on your environment, you may wish to tune the settings. If so, edit
this file in place.

For further details, see the
[haproxy Configuration Manual](https://cbonte.github.io/haproxy-dconv/1.7/configuration.html).

## Running the server

Execute the following command:

    commands/run.sh

els-haproxy uses a standard [docker](https://docs.docker.com/) image -
[haproxy:1.7.9](https://hub.docker.com/_/haproxy/), which will
be downloaded automatically if necessary.

### Server Stats

You can check the server's stats by opening the following URL:

    <server domain>/stats

Or, if running on the server itself:

    127.0.0.1/stats

## Client Configuration

Client machines and VMs must be configured to redirect requests to
api.elasticlicensing.com to the Proxy Server you have setup. Follow the
steps below:

### 1. Get the IP address of your proxy server

You need the IP address which client machines can use to access your proxy
server.

For example, from a linux machine you could do:

    ping <domain name of server>

### 2. Update the hosts file on Client Machines

Add an entry to each client's hosts file which redirects the domain
`api.elasticlicensing.com` to the IP address of your proxy server you discovered
in step 1.

E.g. on linux, if the IP address was `10.0.123.99`, you would edit the
`/etc/hosts` file and add the following line:

10.0.123.99   api.elasticlicensing.com #els-haproxy redirect

Check online for instructions for editing the hosts file on other operating
systems.

### 3. Check Client Access

To check that the client can access Elastic Licensing via the proxy server,
attempt to access the following URL (e.g. using a browser or [curl](https://curl.haxx.se/)):

    https://api.elasticlicensing.com/version

If all is well, you should see a version number.

## Docs and help

For further details, see

* [Customers | Proxy Server](https://docs.elasticlicensing.com/customers/proxy-server)

