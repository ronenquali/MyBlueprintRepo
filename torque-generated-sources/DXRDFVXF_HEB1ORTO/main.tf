resource "azurerm_managed_disk" "res-0" {
  create_option = "Empty"
  location = "westeurope"
  name = "pvc-9a95354d-49ef-4b7d-8626-7cf1d355e87c"
  resource_group_name = "mc_aks-rg_qualidev-aks_westeurope"
  storage_account_type = "StandardSSD_LRS"
  tags = {
    k8s-azure-created-by = "kubernetes-azure-dd"
    "kubernetes.io-created-for-pv-name" = "pvc-9a95354d-49ef-4b7d-8626-7cf1d355e87c"
    "kubernetes.io-created-for-pvc-name" = "torque-storage-411e561"
    "kubernetes.io-created-for-pvc-namespace" = "vido-sb"
  }
}