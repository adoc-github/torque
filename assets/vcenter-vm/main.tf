# Terraformプロジェクトのセットアップ
terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.3.1"
    }
  }
}

# vSphere Providerの設定
provider "vsphere" {
  vsphere_server = var.vsphere_server
  user_name      = var.user_name
  password       = var.password
  allow_unverified_ssl = true
}

# # VMの定義と設定
# resource "vsphere_virtual_machine" "example_vm" {
#   name             = "example-vm"
#   resource_pool_id = data.vsphere_resource_pool.pool.id

#   # 仮想マシンの設定
#   num_cpus = 2
#   memory   = 2048

#   # ディスクの設定
#   scsi_type = "pvscsi"
#   disk {
#     label            = "disk0"
#     size             = 20
#     eagerly_scrub    = true
#     thin_provisioned = true
#   }

#   # ネットワークアダプターの設定
#   network_interface {
#     network_id = data.vsphere_network.network.id
#   }

#   # ゲストOSの設定
#   guest_id = "rhel7_64Guest"
#   cdrom {
#     datastore_id = data.vsphere_datastore.datastore.id
#     path         = "[${data.vsphere_datastore.datastore.name}] iso/rhel-server-7.9-x86_64-dvd.iso"
#   }

#   # ログイン情報の設定
#   console {
#     type        = "serial"
#     start_connected = true
#   }
#   clone {
#     template_uuid = data.vsphere_virtual_machine.template.id
#   }
# }

# リソースプールの設定
data "vsphere_resource_pool" "pool" {
  name          = "192.168.90.206/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# # ネットワークの設定
# data "vsphere_network" "network" {
#   name          = "VM Network"
#   datacenter_id = data.vsphere_datacenter.dc.id
# }

# # データストアの設定
# data "vsphere_datastore" "datastore" {
#   name          = "Datastore"
#   datacenter_id = data.vsphere_datacenter.dc.id
# }

# データセンターの設定
data "vsphere_datacenter" "dc" {
  name = "Datacenter"
}

# # テンプレートの設定
# data "vsphere_virtual_machine" "template" {
#   name          = "template-vm"
#   datacenter_id = data.vsphere_datacenter.dc.id
# }
