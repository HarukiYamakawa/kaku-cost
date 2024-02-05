#nodejsのECRリポジトリを作成
resource "aws_ecr_repository" "repository_nodejs" {
  name = "${var.name_prefix}-nodejs"

  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "KMS"
  }

  tags = {
    Name = "${var.name_prefix}-nodejs"
    group = "${var.tag_group}"
  }
}

resource "aws_ecr_lifecycle_policy" "lifecycle_policy_nodejs" {
  repository = aws_ecr_repository.repository_nodejs.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep at most 3 images",
        selection = {
          tagStatus = "any",
          countType = "imageCountMoreThan",
          countNumber = 3
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}

#pumaのECRリポジトリを作成
resource "aws_ecr_repository" "repository_puma" {
  name = "${var.name_prefix}-puma"

  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "KMS"
  }

  tags = {
    Name = "${var.name_prefix}-puma"
    group = "${var.tag_group}"
  }
}

resource "aws_ecr_lifecycle_policy" "lifecycle_policy_puma" {
  repository = aws_ecr_repository.repository_puma.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep at most 3 images",
        selection = {
          tagStatus = "any",
          countType = "imageCountMoreThan",
          countNumber = 3
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}

#fluentbitのECRリポジトリを作成
resource "aws_ecr_repository" "repository_fluentbit" {
  name = "${var.name_prefix}-fluentbit"

  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "KMS"
  }

  tags = {
    Name = "${var.name_prefix}-fluentbit"
    group = "${var.tag_group}"
  }
}

resource "aws_ecr_lifecycle_policy" "lifecycle_policy_fluentbit" {
  repository = aws_ecr_repository.repository_fluentbit.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep at most 3 images",
        selection = {
          tagStatus = "any",
          countType = "imageCountMoreThan",
          countNumber = 3
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}