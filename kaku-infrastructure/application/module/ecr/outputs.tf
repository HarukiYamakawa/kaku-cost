output "nodejs_repository" {
    value = "${aws_ecr_repository.repository_nodejs.repository_url}"
}

output "puma_repository" {
    value = "${aws_ecr_repository.repository_puma.repository_url}"
}