resource "aws_budgets_budget" "monthly_budget" {
  name = "terraform-monthly-budget"
  time_unit = "MONTHLY"
  budget_type = "COST"
  limit {
    amount = 10.00
    unit   = "USD"
  }
  cost_types {
    include_tax = false
    include_subscription = true
  }
  notification {
    comparison_operator = "GREATER_THAN"
    threshold = 1
    notification_type = "ACTUAL"
    subscribers {
      subscription_type = "EMAIL"
      address = "igormartins0301@gmail.com"
    }
  }
}
