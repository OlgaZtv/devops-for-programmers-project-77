resource "yandex_dns_zone" "zone1" {
  name   = "project-dns-zone"
  zone   = "ttalki.ru."
  public = true
}

resource "yandex_dns_recordset" "rs2" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "ttalki.ru."
  type    = "A"
  ttl     = 200
  data    = [yandex_alb_load_balancer.project-balancer.listener[0].endpoint[0].address[0].external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "rs3" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "ttalki.ru."
  type    = "TXT"
  ttl     = 600
  data    = ["_globalsign-domain-verification=nsjVJZ25q2wIVRCQC3pBN7MGcegFCopdl3o5DOryjb"]
}