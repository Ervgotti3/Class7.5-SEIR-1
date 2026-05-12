output "bucket_name" {
  value = google_storage_bucket.static_website.name
}

output "website_url" {
  value = "https://storage.googleapis.com/${google_storage_bucket.static_website.name}/index.html"
}
output "Image_url" {
  value = "https://storage.googleapis.com/${google_storage_bucket.static_website.name}/venezuela.png"
}