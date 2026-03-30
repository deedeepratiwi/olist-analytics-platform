variable "credentials" {
  description = "My Credentials"
  default     = "/home/diana/elt-ecommerce/.gcp/elt-ecommerce-tf.json"
}

variable "project" {
  description = "Project"
  default     = "elt-ecommerce"
}

variable "region" {
  description = "Region"
  default     = "us-central1"
}

variable "location" {
  description = "Project Location"
  default     = "US"
}

variable "bq_dataset_raw" {
  description = "Raw Dataset"
  default     = "olist_raw"
}

variable "bq_dataset_analytics" {
  description = "Analytics Dataset"
  default     = "olist_analytics"
}

variable "gcs_bucket_name" {
  description = "Unique Bucket Name"
  default     = "olist-raw-bucket-elt-ecommerce"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}