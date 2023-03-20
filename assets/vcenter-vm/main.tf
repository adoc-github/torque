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
  user      = var.user_name
  password       = var.password
  allow_unverified_ssl = true
}

# データセンターの設定
data "vsphere_datacenter" "dc" {
  name = "Datacenter"
}

# リソースプールの設定
data "vsphere_resource_pool" "pool" {
  name          = "192.168.90.206/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# ネットワークの設定
data "vsphere_network" "network" {
  name          = "D Management Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# データストアの設定
data "vsphere_datastore" "datastore" {
  name          = "datastore2"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# テンプレートの設定
data "vsphere_virtual_machine" "template" {
  name          = "Templates/CentOS7_2003"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# VMの定義と設定
resource "vsphere_virtual_machine" "example_vm" {
  name             = "example-vm"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type

  # 仮想マシンの設定
  num_cpus = 2
  memory   = 3072

  # ディスクの設定
  disk {
    label            = "disk0"
    size             = 20
  }

  # ネットワークアダプターの設定
  network_interface {
    network_id = data.vsphere_network.network.id
  }

  # テンプレートからクローン作成する設定
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }
}
