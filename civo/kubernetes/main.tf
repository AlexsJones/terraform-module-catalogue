provider "civo" {
  token = var.civotoken
}

terraform {
  required_version = ">= 0.13.0"
  required_providers {
    civo = {
      source = "civo/civo"
    }
  }
}

provider "kubernetes" {
  host     = civo_kubernetes_cluster.cluster.api_endpoint
  client_key = yamldecode(civo_kubernetes_cluster.cluster.kubeconfig).users[0].user.client-key-data
  client_certificate = yamldecode(civo_kubernetes_cluster.cluster.kubeconfig).users[0].user.client-certificate-data
  cluster_ca_certificate = base64decode(
    yamldecode(civo_kubernetes_cluster.cluster.kubeconfig).clusters[0].cluster.certificate-authority-data
  )
}

provider "helm" {
  kubernetes {
    host     = civo_kubernetes_cluster.cluster.api_endpoint
    client_key = yamldecode(civo_kubernetes_cluster.cluster.kubeconfig).users[0].user.client-key-data
    client_certificate = yamldecode(civo_kubernetes_cluster.cluster.kubeconfig).users[0].user.client-certificate-data
    cluster_ca_certificate = base64decode(
      yamldecode(civo_kubernetes_cluster.cluster.kubeconfig).clusters[0].cluster.certificate-authority-data
    )
  }
}
