locals {
  identity_id = replace(data.tls_certificate.control_plane_crt.url, "https://", "")
}
