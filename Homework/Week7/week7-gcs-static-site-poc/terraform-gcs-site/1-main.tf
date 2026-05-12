#Week7 : Lab/Homework 7 - Create a Static Website using GCS and Terraform 

resource "google_storage_bucket" "static_website" {
  name                        = var.bucket_name
  location                    = var.location
  force_destroy               = true
  uniform_bucket_level_access = true
  public_access_prevention    = "inherited"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

# Upload a simple index.html page to the bucket
resource "google_storage_bucket_object" "indexpage" {
  name         = "index.html"
  source       = "mywebsite/index.html"
  content_type = "text/html"
  bucket       = google_storage_bucket.static_website.name
}

# Upload a simple 404 / error page to the bucket
resource "google_storage_bucket_object" "errorpage" {
  name         = "404.html"
  source       = "mywebsite/404.html"
  content_type = "text/html"
  bucket       = google_storage_bucket.static_website.name
}

# Upload the CSS file to the bucket
resource "google_storage_bucket_object" "stylefile" {
  name         = "style.css"
  source       = "mywebsite/style.css"
  content_type = "text/css"
  bucket       = google_storage_bucket.static_website.name
}

# Upload the image file to the bucket
resource "google_storage_bucket_object" "imagefile" {
  name         = "venezuela.png"
  source       = "imagefile/venezuela.png"
  content_type = "image/png"
  bucket       = google_storage_bucket.static_website.name
}

#Configure bucket permissions to allow public read access to the objects in the bucket, 
#so that the website can be accessed by anyone on the internet.
resource "google_storage_bucket_iam_member" "public_rule" {
  bucket = google_storage_bucket.static_website.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

