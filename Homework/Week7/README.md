
# Week 7 GCS Static Website POC

## Website URL

https://storage.googleapis.com/week7-gcs-static-site-ervink/index.html

## Project Overview

This part of the lab was to deploy a proof of concept static website using Google Cloud Storage and Terraform. The website is made up of a basic HTML page, a 404 page, a CSS file, and an image.

Terraform was used to create the GCS bucket, upload the website files, configure the bucket for static website hosting, and make the objects publicly readable.

## Files Used for the Website

The website uses these files:

- index.html
- 404.html
- style.css
- venezuela.png

The image file name had to match what was listed in the index.html file.

## What Terraform Created

Terraform created the following:

- A Google Cloud Storage bucket
- Website configuration for index.html and 404.html
- Four uploaded bucket objects
- Public read access using roles/storage.objectViewer
- Output for the website URL

## Issues I Ran Into

One issue I ran into was with the backend configuration. I used the wrong argument name at first and had to correct it.

I also had to make sure the image filename matched between the HTML file and the object uploaded to the bucket. Another issue was making sure my .gitignore did not block the Terraform files from being pushed to GitHub.

## What I Learned

I learned that GCS can host static files without needing a web server. I also learned how Terraform can upload local files into a bucket and set the correct content types for HTML, CSS, and images.

I also got more practice with Terraform init, validate, plan, apply, outputs, and IAM permissions.

## Pros

- Simple way to host a small static website
- Low cost for a basic proof of concept
- Terraform makes the deployment repeatable
- No server is needed

## Cons

- This only works for static content
- Public access has to be handled carefully
- A production website would need more work for DNS, HTTPS, and security

## Documentation Used

- Google Cloud Storage static website hosting:
  https://docs.cloud.google.com/storage/docs/hosting-static-website

- Terraform Google provider:
  https://registry.terraform.io/providers/hashicorp/google/latest

- Terraform google_storage_bucket resource:
  https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket

- Terraform google_storage_bucket_object resource:
  https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object

- Terraform google_storage_bucket_iam_member resource:
  https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam