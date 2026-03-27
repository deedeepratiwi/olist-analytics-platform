variable "credentials" {
  description = "My Credentials"
  default     = "~/elt-ecommerce/.gcp/elt-ecommerce-tf.json"
}

variable "project" {
  description = "Project"
  default     = "elt-ecommerce"
}

variable "region" {
  description = "Region"
  default     = "asia-southeast1-c"
}

variable "location" {
  description = "Project Location"
  default     = "ASIA"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "olist_dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "olist-raw-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}