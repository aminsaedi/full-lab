resource "digitalocean_droplet" "gitlab-server" {
  name   = "gitlab-server"
  image  = "ubuntu-20-04-x64"
  size   = "s-4vcpu-8gb"
  region = "tor1"
  ssh_keys = [
    data.digitalocean_ssh_key.default.id
  ]

}


output "gitlab-server-ip" {
  value = digitalocean_droplet.gitlab-server.ipv4_address
}
