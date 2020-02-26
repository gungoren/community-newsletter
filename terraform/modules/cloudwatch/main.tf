
resource "aws_cloudwatch_event_rule" "event" {
    name = "${var.event_name}"
    description = "${var.event_name}"
    schedule_expression = "${var.schedule_midnight}"
}

resource "aws_cloudwatch_event_target" "event-lambda-target" {
    target_id   = "${var.event_name}-lambda-target"
    rule        = "${aws_cloudwatch_event_rule.event.name}"
    arn         = "${var.function_arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_slack_newsletter" {
    statement_id    = "AllowExecutionFromCloudWatch"
    action          = "lambda:InvokeFunction"
    function_name   = "${var.function_name}"
    principal       = "events.amazonaws.com"
    source_arn      = "${aws_cloudwatch_event_rule.event.arn}"
}
