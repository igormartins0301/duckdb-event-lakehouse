resource "aws_budgets_budget" "cost" {
  name         =  "budget-free-tier"
  budget_type  = "COST"
  limit_amount = "5"
  limit_unit   = "USD"
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = ["igormartins0301@gmail.com"]
  }
}