resource "local_file" "favorite_food" {
  filename = "${path.module}/favorite_food.txt"
  content  = "My favorite food is pizza."
}