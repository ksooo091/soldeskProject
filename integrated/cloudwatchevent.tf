
# resource "aws_codecommit_trigger" "front_trigger" {
#   repository_name = aws_codecommit_repository.frontend-server.repository_name
# }

resource "aws_cloudwatch_event_target" "front_target" {
  target_id = "frontpipe-target"
  rule      = aws_cloudwatch_event_rule.front_watch_rule.name
  arn       = aws_codepipeline.front_pipeline.arn
  role_arn  = aws_iam_role.cwe_role.arn  
}

resource "aws_cloudwatch_event_rule" "front_watch_rule" {
  name        = "front-watch-rule"
  description = "front code repo watch rule"

  event_pattern = jsonencode(
  {
    "source": [
      "aws.codecommit"
    ],
    "detail-type": [
      "CodeCommit Repository State Change"
    ],
    "resources": [
      aws_codecommit_repository.frontend-server.arn
    ],
    "detail": {
      "event": [
        "referenceCreated",
        "referenceUpdated"
      ],
      "referenceType": [
        "branch"
      ],
      "referenceName": [
        "main"
      ]
    }
  })
}



resource "aws_cloudwatch_event_target" "back_target" {
  target_id = "backpipe-target"
  rule      = aws_cloudwatch_event_rule.back_watch_rule.name
  arn       = aws_codepipeline.back_pipeline.arn
  role_arn  = aws_iam_role.cwe_role.arn  
}

resource "aws_cloudwatch_event_rule" "back_watch_rule" {
  name        = "back-watch-rule"
  description = "back code repo watch rule"

  event_pattern = jsonencode(
  {
    "source": [
      "aws.codecommit"
    ],
    "detail-type": [
      "CodeCommit Repository State Change"
    ],
    "resources": [
      aws_codecommit_repository.backend-server.arn
    ],
    "detail": {
      "event": [
        "referenceCreated",
        "referenceUpdated"
      ],
      "referenceType": [
        "branch"
      ],
      "referenceName": [
        "main"
      ]
    }
  })
}



resource "aws_iam_role" "cwe_role" {
  name = "crw-role-repo"
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "events.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}

EOF
}

resource "aws_iam_role_policy" "cwe_policy" {
  name = "cwe_policy"
  role = aws_iam_role.cwe_role.id
  policy = jsonencode(
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "codepipeline:StartPipelineExecution"
            ],
            "Resource": [
               aws_codepipeline.front_pipeline.arn,
               aws_codepipeline.back_pipeline.arn
            ]
        }
    ]
}

  )
}