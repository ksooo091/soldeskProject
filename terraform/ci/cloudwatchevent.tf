
resource "aws_codecommit_trigger" "front_trigger" {
  repository_name = aws_codecommit_repository.frontend-server.repository_name
}

resource "aws_cloudwatch_event_target" "front_target" {
  target_id = "frontpipe-target"
  rule      = aws_cloudwatch_event_rule.console.name
  arn       = aws_codepipeline.front_pipeline.arn

}

resource "aws_cloudwatch_event_rule" "front_watch_rule" {
  name        = "front-watch-rule"
  description = "front code repo watch rule"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.codecommit"
  ],
  "detail-type": [
    "CodeCommit Repository State Change"
  ],
  "resources": [
    ${aws_codecommit_repository.frontend-server.arn}
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
}
PATTERN
}
