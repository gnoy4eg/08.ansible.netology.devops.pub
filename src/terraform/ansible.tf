resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "sleep 120"
  }

  depends_on = [
    local_file.inventory
  ]
}

resource "null_resource" "requirements" {
  provisioner "local-exec" {
    command = "ansible-galaxy install -r ../ansible/requirements.yml -p ../ansible/roles --force"
  }

  depends_on = [
    null_resource.wait
  ]
}

resource "null_resource" "site" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ../ansible/inventory ../ansible/site.yml"
  }

  depends_on = [
    null_resource.requirements
  ]
}