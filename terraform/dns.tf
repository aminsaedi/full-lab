resource "cloudflare_record" "gitlab-server-dns" {
  zone_id = var.cloudflare_zone_id
  name    = "gitlab"
  value   = digitalocean_droplet.gitlab-server.ipv4_address
  type    = "A"
  proxied = false
}

output "gitlab-server-fqdn" {
  value = cloudflare_record.gitlab-server-dns.hostname
}
