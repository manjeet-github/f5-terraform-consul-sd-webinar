provider "bigip" {
  address  = "https://${var.address}:${var.port}"
  username = "${var.username}"
  password = "${var.password}"
}

/*
# download jq
resource "null_resource" "download_jq" {
  provisioner "local-exec" {
    command = <<EOH
curl -o jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod 0755 jq
# Do some kind of JSON processing with ./jq
EOH
  }
}

# download rpm
resource "null_resource" "download_as3" {
  provisioner "local-exec" {
    command = "wget ${var.as3_rpm_url}"
  }
  depends_on = [null_resource.download_jq]  
}

# install rpm to BIG-IP
resource "null_resource" "install_as3" {
  provisioner "local-exec" {
    command = "./install_as3.sh ${var.address}:${var.port} admin:${var.password} ${var.as3_rpm}"
  }
  depends_on = [null_resource.download_as3]
}
*/
  
# deploy application using as3
resource "bigip_as3" "nginx" {
  as3_json    = "${file("nginx.json")}"
  tenant_name = "consul_sd"
  #depends_on  = [null_resource.install_as3]
}
