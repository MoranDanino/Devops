terraform {
    required_providers {
        time = {
            source = "hashicorp/time"
            version = "0.12.1"      # important
        }
    }
}

resource "time_sleep" "wait_for_ip" {
    create_duration = "40s" 
}

resource "null_resource" "check_public_ip" {   # see this in lab103
  provisioner "local-exec" {
    command = <<EOT
    retries=4
    interval=30
    for i in $(seq 1 $retries); do
      if [ -z "${aws_instance.vm.public_ip}" ]; then
        echo "Attempt $i/$retries: Public IP not assigned yet, retrying in $interval seconds..."
        sleep $interval
      else
        echo "Public IP assigned: ${aws_instance.vm.public_ip}"
        exit 0
      fi
    done
    echo "ERROR: Public IP address was not assigned after $retries attempts." >&2
    exit 1
    EOT
  }
  depends_on = [aws_instance.vm]
}